#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#
# find_near_gps.sh - list camera files whose EXIF GPS position lies within a
#                    given distance of a reference coordinate.
#
# Usage:
#   find_near_gps.sh LAT LON DIR [DIR...]
#
#   LAT, LON  Reference point in signed decimal degrees
#             (e.g. 46.5547 6.5520, or -33.8688 151.2093)
#   DIR       One or more folders to search recursively
#
# Requires: exiftool (https://exiftool.org), awk
#
set -euo pipefail

# ---- Configuration ---------------------------------------------------------

# Maximum distance in kilometres (can be overridden from the environment:
#   MAX_DISTANCE_KM=5 ./find_near_gps.sh ...)
MAX_DISTANCE_KM="${MAX_DISTANCE_KM:-20}"

# Set to 1 to print the distance next to each filename
SHOW_DISTANCE="${SHOW_DISTANCE:-0}"

# Extensions produced by cameras / phones (case-insensitive for exiftool)
EXTENSIONS=(
    # Common still formats
    jpg jpeg heic heif hif tif tiff png
    # RAW formats
    dng cr2 cr3 crw nef nrw arw srf sr2 orf rw2 raf pef srw x3f
    3fr fff iiq mos mrw erf kdc dcr rwl raw gpr
    # Video formats (GPS read from QuickTime/MP4 metadata)
    mp4 mov m4v 3gp mts insv
)

# ---- Argument checking -----------------------------------------------------

usage() {
    echo "Usage: $(basename "$0") LAT LON DIR [DIR...]" >&2
    echo "  Lists files within ${MAX_DISTANCE_KM} km of (LAT, LON)." >&2
    exit 1
}

[[ $# -ge 3 ]] || usage

if ! command -v exiftool >/dev/null 2>&1; then
    echo "Error: exiftool is not installed." >&2
    echo "  Debian/Ubuntu: sudo apt install libimage-exiftool-perl" >&2
    echo "  macOS:         brew install exiftool" >&2
    exit 1
fi

REF_LAT="$1"
REF_LON="$2"
shift 2

num_re='^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)$'
if ! [[ $REF_LAT =~ $num_re && $REF_LON =~ $num_re ]]; then
    echo "Error: LAT and LON must be decimal numbers." >&2
    usage
fi
if ! awk -v a="$REF_LAT" -v o="$REF_LON" \
        'BEGIN { exit !(a >= -90 && a <= 90 && o >= -180 && o <= 180) }'; then
    echo "Error: LAT must be in [-90,90] and LON in [-180,180]." >&2
    exit 1
fi

for dir in "$@"; do
    [[ -d $dir ]] || { echo "Error: '$dir' is not a directory." >&2; exit 1; }
done

# ---- Build exiftool extension filters ---------------------------------------

ext_args=()
for e in "${EXTENSIONS[@]}"; do
    ext_args+=(-ext "$e")
done

# ---- Scan and filter ---------------------------------------------------------
#
# exiftool runs once over all folders (much faster than once per file).
# -n gives signed decimal coordinates; -if skips files without GPS data.
# Output per line: "<lat> <lon> <path>"  (path may contain spaces).

exiftool -r -q -q -n "${ext_args[@]}" \
    -if '$GPSLatitude and $GPSLongitude' \
    -p '$GPSLatitude $GPSLongitude $Directory/$FileName' \
    "$@" 2>/dev/null |
awk -v rlat="$REF_LAT" -v rlon="$REF_LON" \
    -v maxd="$MAX_DISTANCE_KM" -v showd="$SHOW_DISTANCE" '
    BEGIN {
        pi = atan2(0, -1)
        R  = 6371.0           # mean Earth radius, km
        d2r = pi / 180
    }
    {
        lat = $1; lon = $2
        path = $0
        sub(/^[^ ]+ [^ ]+ /, "", path)

        # Haversine great-circle distance
        dlat = (lat - rlat) * d2r
        dlon = (lon - rlon) * d2r
        a = sin(dlat/2)^2 + cos(rlat*d2r) * cos(lat*d2r) * sin(dlon/2)^2
        d = 2 * R * atan2(sqrt(a), sqrt(1 - a))

        if (d <= maxd) {
            if (showd == 1) printf "%s\t%.2f km\n", path, d
            else            print path
        }
    }'
