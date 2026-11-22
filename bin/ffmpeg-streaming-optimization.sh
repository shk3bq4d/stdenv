#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


# optimize-media-container.sh
#
# Usage:
#   ./optimize-media-container.sh movie.mp4
#   ./optimize-media-container.sh movie.mkv
#
# Behavior:
#   MP4/M4V/MOV:
#     - Checks whether moov atom is before mdat.
#     - If already optimized, skips.
#     - If not, remuxes with -movflags +faststart.
#
#   MKV:
#     - There is no MP4-style faststart for MKV.
#     - Scans the file with ffmpeg.
#     - If ffmpeg reports container/timestamp/read errors, remuxes with -c copy.
#     - If scan is clean, skips.
#
# Warning:
#   This script does NOT keep a backup.

file="${1:-}"

if [[ -z "$file" ]]; then
  echo "Usage: $0 <file.mp4|file.m4v|file.mov|file.mkv>"
  exit 1
fi

if [[ ! -f "$file" ]]; then
  echo "Error: file not found: $file"
  exit 1
fi

command -v ffmpeg >/dev/null || {
  echo "Error: ffmpeg not found"
  exit 1
}

command -v ffprobe >/dev/null || {
  echo "Error: ffprobe not found"
  exit 1
}

ext="${file##*.}"
ext="${ext,,}"

case "$ext" in
  mp4|m4v|mov|mkv)
    ;;
  *)
    echo "Skipping: unsupported extension: .$ext"
    exit 0
    ;;
esac

dir="$(dirname -- "$file")"
base="$(basename -- "$file")"
tmp="${dir}/.${base}.optimize.tmp.${ext}"

stat_size() {
  stat -c%s "$1" 2>/dev/null || stat -f%z "$1"
}

validate_media() {
  local path="$1"

  ffprobe \
    -v error \
    -show_format \
    -show_streams \
    "$path" >/dev/null
}

replace_on_success() {
  local tmp_file="$1"

  echo "Validating output..."

  if ! validate_media "$tmp_file"; then
    echo "Error: output failed ffprobe validation."
    rm -f "$tmp_file"
    exit 1
  fi

  local orig_size
  local new_size
  orig_size="$(stat_size "$file")"
  new_size="$(stat_size "$tmp_file")"

  local min_size=$((orig_size / 2))

  if [[ "$new_size" -lt "$min_size" ]]; then
    echo "Error: output is unexpectedly small."
    echo "Original: $orig_size bytes"
    echo "New:      $new_size bytes"
    rm -f "$tmp_file"
    exit 1
  fi

  mv -f -- "$tmp_file" "$file"

  echo "Success."
  echo "Replaced original with optimized file:"
  echo "$file"
}

mp4_needs_faststart() {
  local path="$1"
  local scan_bytes=$((64 * 1024 * 1024))

  local moov_pos
  local mdat_pos

  moov_pos="$(head -c "$scan_bytes" "$path" | grep -abo 'moov' | head -n1 | cut -d: -f1 || true)"
  mdat_pos="$(head -c "$scan_bytes" "$path" | grep -abo 'mdat' | head -n1 | cut -d: -f1 || true)"

  if [[ -n "$moov_pos" && -n "$mdat_pos" && "$moov_pos" -lt "$mdat_pos" ]]; then
    return 1
  fi

  return 0
}

mkv_needs_remux() {
  local path="$1"
  local log
  log="$(mktemp)"

  ffmpeg \
    -hide_banner \
    -v warning \
    -i "$path" \
    -map 0 \
    -c copy \
    -f null - \
    2>"$log" || true

  if grep -Eiq \
    'error|invalid|corrupt|non-monoton|timestamp|missing|damaged|truncat|could not find codec parameters|header|cues|seekhead|read' \
    "$log"; then
    rm -f "$log"
    return 0
  fi

  rm -f "$log"
  return 1
}

echo "Checking: $file"

if ! validate_media "$file"; then
  echo "Error: ffprobe could not read file: $file"
  exit 1
fi

rm -f "$tmp"

case "$ext" in
  mp4|m4v|mov)
    if ! mp4_needs_faststart "$file"; then
      echo "Skipping: MP4/MOV already appears optimized for faststart."
      exit 0
    fi

    echo "Optimizing MP4/MOV faststart..."

    ffmpeg \
      -hide_banner \
      -y \
      -i "$file" \
      -map 0 \
      -c copy \
      -movflags +faststart \
      "$tmp"

    replace_on_success "$tmp"
    ;;

  mkv)
    if ! mkv_needs_remux "$file"; then
      echo "Skipping: MKV scan looks clean; no remux needed."
      exit 0
    fi

    echo "Remuxing MKV because scan reported container/timestamp/read issues..."

    ffmpeg \
      -hide_banner \
      -y \
      -i "$file" \
      -map 0 \
      -c copy \
      -avoid_negative_ts make_zero \
      "$tmp"

    replace_on_success "$tmp"
    ;;
esac
echo EOF
exit 0
