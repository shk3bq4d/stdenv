#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; };
trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
#echo $_tempdir

tar_filepath="$_tempdir/my.tar"

echo "# ex: set filetype=Dockerfile fenc=utf-8 expandtab ts=4 sw=4 :"
>&2 echo "# docker save $@"
docker save "$@" > "$tar_filepath"
>&2 echo "# Done"
json_filenames() {
    tar --list -f "$tar_filepath" | grep -vE '/|manifest.json' | grep -E '\.json$'
}

json_filenames | while read json_filename; do
    echo "# Image $(basename $json_filename .json)"
    tar -axf "$tar_filepath" "$json_filename" -O | jq -r '.history[].created_by'
    echo ""
    echo ""
done

cleanup
exit 0
