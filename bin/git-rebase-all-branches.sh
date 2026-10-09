#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

# Fetch all remotes, then bring every local branch that tracks a remote branch
# up to date with it, but only when the remote has commits the local branch
# lacks:
#   - local has nothing of its own: fast-forward
#   - both sides have commits:       rebase local onto upstream
# A rebase that hits conflicts is aborted and the branch is left untouched.

DRY_RUN=0

usage() {
    cat <<EOF
Usage: ${0##*/} [-n]

Fast-forward or rebase every local branch onto its remote tracking branch when
the remote has commits the local branch does not have.

  -n    dry run: only show what would be done
  -h    show this help
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

worktree_is_clean() {
    git update-index -q --refresh || true
    git diff-index --quiet HEAD --
}

rebase_in_progress() {
    [[ -d $(git rev-parse --git-path rebase-merge) \
        || -d $(git rev-parse --git-path rebase-apply) ]]
}

main() {
    local opt
    while getopts ':nh' opt; do
        case $opt in
            n) DRY_RUN=1 ;;
            h) usage; exit 0 ;;
            *) usage >&2; die "unknown option -$OPTARG" ;;
        esac
    done
    shift $(( OPTIND - 1 ))
    (( $# == 0 )) || { usage >&2; die "unexpected argument: $1"; }

    git rev-parse --git-dir >/dev/null 2>&1 || die "not inside a git repository"
    rebase_in_progress && die "a rebase is already in progress"

    log "fetching all remotes..."
    git fetch --all --prune --quiet

    local toplevel current orig_head clean=1
    toplevel=$(git rev-parse --show-toplevel)
    current=$(git symbolic-ref --quiet --short HEAD || true)
    orig_head=$(git rev-parse HEAD)
    worktree_is_clean || clean=0

    local branch upstream wt_path local_sha up_sha counts ahead behind up_name
    local -i updated=0 failed=0 switched=0
    # Read on fd 3 so commands in the loop cannot swallow the branch list
    # from stdin.
    while IFS=$'\t' read -r -u 3 branch upstream wt_path; do
        # Only branches tracking a remote branch (not another local branch).
        if [[ $upstream != refs/remotes/* ]]; then
            continue
        fi
        up_name=${upstream#refs/remotes/}
        if ! up_sha=$(git rev-parse --verify --quiet "$upstream"); then
            log "skip ${branch}: upstream ${up_name} is gone"
            continue
        fi
        local_sha=$(git rev-parse "refs/heads/${branch}")

        counts=$(git rev-list --left-right --count "${local_sha}...${up_sha}")
        read -r ahead behind <<<"$counts"
        if (( behind == 0 )); then
            continue
        fi
        if [[ -n $wt_path && $wt_path != "$toplevel" ]]; then
            log "skip ${branch}: checked out in another worktree (${wt_path})"
            continue
        fi

        if (( ahead == 0 )); then
            log "${branch}: fast-forwarding ${behind} commit(s) from ${up_name}"
            if [[ $branch == "$current" ]]; then
                # Updates the working tree too; git refuses if local changes
                # would be overwritten.
                if ! run git merge --ff-only --quiet "$up_sha"; then
                    log "failed to fast-forward ${branch}"
                    failed+=1
                    continue
                fi
            else
                # Old value guards against the branch moving meanwhile.
                run git update-ref -m "rebase-all: fast-forward to ${up_name}" \
                    "refs/heads/${branch}" "$up_sha" "$local_sha"
            fi
            updated+=1
            continue
        fi

        if (( ! clean )); then
            log "skip ${branch}: needs a rebase (${ahead} local, ${behind} remote commit(s)) but the working tree has uncommitted changes"
            continue
        fi
        log "${branch}: rebasing ${ahead} local commit(s) onto ${behind} new commit(s) from ${up_name}"
        if (( DRY_RUN )); then
            log "would run: git rebase --quiet ${up_name} ${branch}"
            updated+=1
            continue
        fi
        # Rebasing a branch checks it out; the original HEAD is restored below.
        switched=1
        if ! git rebase --quiet "$up_sha" "$branch"; then
            if rebase_in_progress; then
                git rebase --abort
            fi
            log "failed to rebase ${branch} (conflicts?), left as it was"
            failed+=1
            continue
        fi
        updated+=1
    done 3< <(git for-each-ref \
        --format='%(refname:short)%09%(upstream)%09%(worktreepath)' \
        refs/heads/)

    if (( switched )); then
        if [[ -n $current ]]; then
            git checkout --quiet "$current"
        else
            git checkout --quiet --detach "$orig_head"
        fi
    fi

    if (( DRY_RUN )); then
        log "dry run: ${updated} branch(es) would be updated"
    else
        log "${updated} branch(es) updated, ${failed} failed"
    fi
    (( failed == 0 ))
}

main "$@"
