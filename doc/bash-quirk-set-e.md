# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#
echo case1
set -euo pipefail
a() { echo "x"; echo "y"; return 1; }
for b in $(a); do
    echo "looping over $b"
done
echo "KO case1 exits with 0 which is misleading"


echo case2
set -euo pipefail
a() { echo "x"; echo "y"; return 1; }
c="$(a)"
for b in $c; do
    echo "looping over $b"
done
echo "ok case2 exit with 1, printing nothing"


echo case3
set -euo pipefail
a() { echo "x"; echo "y"; return 1; }
a | while read b; do
    echo "looping over $b"
done
echo "ok case3 exits with 1, printing x and y"

echo case4
set -euo pipefail
a() { echo "x"; echo "y"; return 1; }
while read b; do
    echo "looping over $b"
done < <(a)
echo "KO case4 exits with 0 which is misleading"

