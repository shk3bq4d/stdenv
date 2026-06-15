#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#
# Prints: CN<TAB>filename<TAB>line
#
# Scans common Linux system CA bundle locations and split-certificate dirs.
# Requires: openssl, awk, grep

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

# Prints:
# FILE,LINE                                                                                 SUBJECT
#
# First column is left-aligned to 90 chars.
# Separator is spaces only.
#
# Requires: openssl, awk, grep, find, sort

CA_PATHS=(
  /etc/ssl/certs
  /etc/pki/tls/certs
  /etc/pki/ca-trust/extracted/pem
  /usr/local/share/ca-certificates
  /etc/ca-certificates
)

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

print_cert() {
  local file="$1"
  local start_line="$2"
  local cert_file="$3"
  local subject location

  subject="$(
    openssl x509 -in "$cert_file" -noout -subject -nameopt RFC2253 2>/dev/null || true
  )"

  [[ -n "$subject" ]] || return 0

  subject="${subject#subject=}"
  location="${file},${start_line}"

  printf '%-90s  %s\n' "$location" "$subject"
}

scan_file() {
  local file="$1"

  awk -v outdir="$tmpdir" '
    /-----BEGIN CERTIFICATE-----/ {
      in_cert=1
      n++
      start_line=NR
      cert_path=outdir "/cert." n ".pem"
    }
    in_cert {
      print > cert_path
    }
    /-----END CERTIFICATE-----/ && in_cert {
      close(cert_path)
      print start_line " " cert_path
      in_cert=0
    }
  ' "$file" |
  while read -r start_line cert_file; do
    print_cert "$file" "$start_line" "$cert_file"
  done
}

printf '%-90s  %s\n' 'FILE,LINE' 'SUBJECT'

for path in "${CA_PATHS[@]}"; do
  [[ -e "$path" ]] || continue

  if [[ -d "$path" ]]; then
    find "$path" -type f \( \
      -name '*.crt' -o \
      -name '*.pem' -o \
      -name '*.cer' -o \
      -name 'ca-bundle.crt' -o \
      -name 'cert.pem' \
    \) -print0
  elif [[ -f "$path" ]]; then
    printf '%s\0' "$path"
  fi
done |
sort -zu |
while IFS= read -r -d '' file; do
  grep -q -- '-----BEGIN CERTIFICATE-----' "$file" 2>/dev/null || continue
  scan_file "$file"
done
