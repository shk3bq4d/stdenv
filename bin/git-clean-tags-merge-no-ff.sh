#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

# Delete every tag matching a glob pattern, both on the remote and locally.

REMOTE=origin
PATTERN='git-merge-no-ff-*'
DRY_RUN=0
# Tags per git invocation, to stay well below the argument length limit.
CHUNK=100

usage() {
    cat <<EOF
Usage: ${0##*/} [-n] [-r remote] [-p pattern]

Delete all tags matching <pattern> on <remote> and locally.

  -n            dry run: only show what would be deleted
  -r remote     remote to work with (default: ${REMOTE})
  -p pattern    shell glob tags must match (default: ${PATTERN})
  -h            show this help
EOF
}

log() {
    printf '%s\n' "$*" >&2
}

die() {
    log "error: $*"
    exit 1
}

run() {
    if (( DRY_RUN )); then
        log "would run: $*"
    else
        "$@"
    fi
}

# Print the names, one per line, that match PATTERN. The glob is applied here
# rather than by git so that "*" also matches "/".
filter_tags() {
    local tag
    while IFS= read -r tag; do
        if [[ -n $tag && $tag == $PATTERN ]]; then
            printf '%s\n' "$tag"
        fi
    done
}

main() {
    local opt
    while getopts ':nr:p:h' opt; do
        case $opt in
            n) DRY_RUN=1 ;;
            r) REMOTE=$OPTARG ;;
            p) PATTERN=$OPTARG ;;
            h) usage; exit 0 ;;
            :) usage >&2; die "option -$OPTARG requires an argument" ;;
            *) usage >&2; die "unknown option -$OPTARG" ;;
        esac
    done
    shift $(( OPTIND - 1 ))
    (( $# == 0 )) || { usage >&2; die "unexpected argument: $1"; }

    git rev-parse --git-dir >/dev/null 2>&1 || die "not inside a git repository"

    local listing i
    local -a remote_tags local_tags refs

    # Queried directly rather than fetched, so deleted tags are not pulled
    # back in. --refs drops the peeled "^{}" entries of annotated tags.
    log "listing tags on ${REMOTE}..."
    listing=$(git ls-remote --refs --tags "$REMOTE")
    mapfile -t remote_tags < <(
        cut -f2 <<<"$listing" | sed -e 's|^refs/tags/||' | filter_tags)

    if (( ${#remote_tags[@]} )); then
        log "deleting ${#remote_tags[@]} tag(s) on ${REMOTE}"
        for (( i = 0; i < ${#remote_tags[@]}; i += CHUNK )); do
            refs=("${remote_tags[@]:i:CHUNK}")
            run git push --quiet "$REMOTE" --delete "${refs[@]/#/refs/tags/}"
        done
    else
        log "no tag matching ${PATTERN} on ${REMOTE}"
    fi

    # Full refname: the short form turns into "tags/<name>" when a branch has
    # the same name.
    listing=$(git for-each-ref --format='%(refname)' refs/tags/)
    mapfile -t local_tags < <(sed -e 's|^refs/tags/||' <<<"$listing" | filter_tags)

    if (( ${#local_tags[@]} )); then
        log "deleting ${#local_tags[@]} local tag(s)"
        for (( i = 0; i < ${#local_tags[@]}; i += CHUNK )); do
            run git tag --delete "${local_tags[@]:i:CHUNK}" >/dev/null
        done
    else
        log "no local tag matching ${PATTERN}"
    fi

    if (( DRY_RUN )); then
        log "dry run: nothing deleted"
    else
        log "done"
    fi
}

main "$@"
