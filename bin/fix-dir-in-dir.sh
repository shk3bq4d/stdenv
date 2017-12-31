#!/usr/bin/env bash                                            
##
## fix-dir-in-dir.sh DIR
##    moves up one dir structure when you have something like ../foo/foo/..
##
function usage() { sed -r -n -e '/^##/s/^..// p' $0 ; }

set -eux

[[ $# -ne 1 ]] && usage && exit 1
D=$1
case "$D" in \
-h|--help)
	usage
	exit 0
esac
[[ ! -d "$D" ]] && echo "FATAL: not a dir $D" && exit 1
[[ $( ls -1 "$D" | wc -l ) -ne 1 ]] && echo "FATAL: dir contains more than one element" && exit 1
ORIGINAL_PARENTNAME="$(basename "$(realpath "$D")")"
ORIGINAL_CHILDNAME="$(basename "$(realpath "$D"/*)")"
PARENT_DIR="$(dirname "$D")"
while :; do
	TEMP_DIRNAME="${PARENT_DIR}/.tmp${RANDOM}"
	[[ ! -d "$TEMP_DIRNAME" ]] && break
done

mv "${D}"/* "$TEMP_DIRNAME"
if ! rmdir "${D}"; then
	mv "$TEMP_DIRNAME" "${D}/$ORIGINAL_CHILDNAME"
	echo "FATAL: could'nt rmdir $D"
	exit 1
fi
mv "$TEMP_DIRNAME" "$ORIGINAL_PARENTNAME"

echo "Successufully replaced ${D}/$ORIGINAL_CHILDNAME onto $D"

