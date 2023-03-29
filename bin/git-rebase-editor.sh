#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

#_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" ]]  && [[ -d "$_tempdir" ]]  && rm -rf "$_tempdir"  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
_tempdir=~/tmp
ORIG_HEAD=$(cat .git/rebase-merge/orig-head)
HEAD_NAME=$(sed -r -e 's,^refs/heads/,,' .git/rebase-merge/head-name)
ONTO=$(cat .git/rebase-merge/onto)
#todo=$_tempdir/git-rebase-todo

f="$1"
b=$_tempdir/todo-orig
#et -x
mv  $f $b

touch $f
#echo '# /* ex: set filetype=gitrebase fenc=utf-8 expandtab ts=4 sw=4 : */' >> $f
# probably that vimrc deactivates colors because --patch in 
echo '# to show patches' >> $f
echo "# glol --patch ${HEAD_NAME}...${ONTO:0:6}" >> $f
echo "# glol --patch ${ORIG_HEAD:0:6}...${ONTO:0:6}" >> $f

cat $b | while read line; do
    read instruction leftover <<<"$line"
#   >&2 echo "line $line"
#   >&2 echo "instruction $instruction"
#   >&2 echo "leftover $leftover"
    c=""
    case $instruction in \
        p|pick) true;;
        r|reword) true;;
        e|edit) true;;
        s|squash) true;;
        f|fixup)
            if [[ "$leftover" == "-c"* || "$leftover" == "-C"* ]]; then
                read c leftover <<<"$leftover"
            fi
            ;;
        # x, exec
        # b, break
        d|drop) true;;
        # l, label
        # t , reset
        m|merge)
            if [[ "$leftover" == "-c"* || "$leftover" == "-C"* ]]; then
                read c leftover <<<"$leftover"
            fi
            ;;
        *)
            #echo "not an instruction $instruction -- $line"
            echo "$line"
            continue
            ;;
    esac
    read ref leftover <<<"$leftover"
    if ! git show "$ref" &>/dev/null; then
        echo "not a ref $ref -- $line"
        continue
    fi
    echo ""
    echo -n "$instruction $c "
    git log -1 --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat --reverse $ref |
        sed -r -e '
        # delete stats summary
        /^ [0-9]+ file/ d

        # delete empty lines
        /^ *$/ d

        # file changes are prepended with a #
        s/^ /# /
        '
done >>$f
cat << EOF >>$f
#
# How to merge commit
# label a
# pick ABC
# pick XYZ
# label b
# reset a
# merge b # Merge branch 'mybranchname'

# ====================
# GRAPH:
$(git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' $ORIG_HEAD...$ONTO | sed -r -e 's/^/# /' )

EOF
cp $f $_tempdir/result

EDITORY=vim ~/bin/vim $f
cp $f ~/tmp/git-rebase-editor-$(date +'%Y.%m.%d-%H.%M.%S')
exit 0
