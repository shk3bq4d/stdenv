#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

# Fetch the remote, then for every local branch that is aligned with its
# upstream and already merged into the remote main branch, delete both the
# remote branch and the local one. Local branches with no branch on the remote
# are deleted when merged into the remote or the local main branch.

REMOTE=origin
# Empty: pick among MAIN_CANDIDATES the one with the most recent commit.
MAIN_BRANCH=
# Never deleted, locally or on the remote, whichever one is picked.
MAIN_CANDIDATES=(master main)
DRY_RUN=0

usage() {
    cat <<EOF
Usage: ${0##*/} [-n] [-r remote] [-b main_branch]

Delete local branches (and their upstream on <remote>) that are aligned with
their upstream and already merged into <remote>/<main_branch>.
Local branches with no branch on <remote> are deleted when merged into
<remote>/<main_branch> or the local <main_branch>.

  -n            dry run: only show what would be deleted
  -r remote     remote to work with (default: ${REMOTE})
  -b branch     main branch merges are checked against (default: whichever
                of ${MAIN_CANDIDATES[*]} on <remote> has the most recent commit)
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

# Print the candidate main branch on REMOTE with the most recent commit.
detect_main_branch() {
    local candidate time best= best_time=-1
    for candidate in "${MAIN_CANDIDATES[@]}"; do
        time=$(git log -1 --format=%ct "refs/remotes/${REMOTE}/${candidate}" -- 2>/dev/null) \
            || continue
        if (( time > best_time )); then
            best=$candidate
            best_time=$time
        fi
    done
    [[ -n $best ]] || return 1
    printf '%s\n' "$best"
}

is_main_branch() {
    local name=$1 candidate
    for candidate in "$MAIN_BRANCH" "${MAIN_CANDIDATES[@]}"; do
        if [[ $name == "$candidate" ]]; then
            return 0
        fi
    done
    return 1
}

main() {
    local opt
    while getopts ':nr:b:h' opt; do
        case $opt in
            n) DRY_RUN=1 ;;
            r) REMOTE=$OPTARG ;;
            b) MAIN_BRANCH=$OPTARG ;;
            h) usage; exit 0 ;;
            :) usage >&2; die "option -$OPTARG requires an argument" ;;
            *) usage >&2; die "unknown option -$OPTARG" ;;
        esac
    done
    shift $(( OPTIND - 1 ))
    (( $# == 0 )) || { usage >&2; die "unexpected argument: $1"; }

    git rev-parse --git-dir >/dev/null 2>&1 || die "not inside a git repository"

    log "fetching ${REMOTE}..."
    git fetch --prune "$REMOTE"

    if [[ -z $MAIN_BRANCH ]]; then
        MAIN_BRANCH=$(detect_main_branch) \
            || die "none of ${MAIN_CANDIDATES[*]} exists on ${REMOTE}, use -b"
        log "using ${REMOTE}/${MAIN_BRANCH} as main branch"
    fi

    local base="refs/remotes/${REMOTE}/${MAIN_BRANCH}"
    git rev-parse --verify --quiet "$base" >/dev/null \
        || die "${REMOTE}/${MAIN_BRANCH} does not exist"

    local current local_main
    current=$(git symbolic-ref --quiet --short HEAD || true)
    local_main=$(git rev-parse --verify --quiet "refs/heads/${MAIN_BRANCH}" || true)

    local branch upstream up_remote up_ref local_sha up_sha reason
    local -i deleted=0
    # Read on fd 3 so commands in the loop (e.g. git push asking for
    # credentials) cannot swallow the branch list from stdin.
    while IFS=$'\t' read -r -u 3 branch upstream up_remote up_ref; do
        if is_main_branch "$branch"; then
            continue
        fi
        if [[ $branch == "$current" ]]; then
            log "skip ${branch}: currently checked out"
            continue
        fi
        local_sha=$(git rev-parse "refs/heads/${branch}")

        # Without a branch on the remote (never tracked, tracking unset,
        # tracking another remote or a local branch, or deleted e.g. by
        # auto-delete after merge) only the local branch is left to clean up.
        # Same when tracking a main branch, which must never be deleted.
        # The local main branch counts too: its history keeps the commits.
        reason=
        if [[ -z $upstream ]]; then
            reason="no upstream"
        elif [[ $up_remote != "$REMOTE" ]]; then
            reason="upstream ${upstream#refs/*/} is not on ${REMOTE}"
        elif is_main_branch "${up_ref#refs/heads/}"; then
            reason="upstream ${upstream#refs/remotes/} is a main branch"
        elif ! up_sha=$(git rev-parse --verify --quiet "$upstream"); then
            reason="upstream ${upstream#refs/remotes/} is gone"
        fi
        if [[ -n $reason ]]; then
            if ! git merge-base --is-ancestor "$local_sha" "$base" \
                && ! { [[ -n $local_main ]] \
                    && git merge-base --is-ancestor "$local_sha" "$local_main"; }; then
                log "skip ${branch}: ${reason} but not merged into ${MAIN_BRANCH}"
                continue
            fi
            log "deleting ${branch} (${reason})"
            if ! run git branch -D "$branch"; then
                log "failed to delete local branch ${branch}"
                continue
            fi
            deleted+=1
            continue
        fi

        if [[ $local_sha != "$up_sha" ]]; then
            log "skip ${branch}: not aligned with ${upstream#refs/remotes/}"
            continue
        fi
        if ! git merge-base --is-ancestor "$local_sha" "$base"; then
            log "skip ${branch}: not merged into ${REMOTE}/${MAIN_BRANCH}"
            continue
        fi

        log "deleting ${branch} and ${upstream#refs/remotes/}"
        # Remote first: if the push fails, the local branch is kept.
        if ! run git push --quiet "$REMOTE" --delete "$up_ref"; then
            log "failed to delete ${upstream#refs/remotes/}, keeping ${branch}"
            continue
        fi
        # -D because merge status was checked against the remote main branch
        # above, which -d would not consider.
        if ! run git branch -D "$branch"; then
            log "failed to delete local branch ${branch}"
            continue
        fi
        deleted+=1
    done 3< <(git for-each-ref \
        --format='%(refname:short)%09%(upstream)%09%(upstream:remotename)%09%(upstream:remoteref)' \
        refs/heads/)

    if (( DRY_RUN )); then
        log "dry run: ${deleted} branch(es) would be deleted"
    else
        log "${deleted} branch(es) deleted"
    fi
}

main "$@"
