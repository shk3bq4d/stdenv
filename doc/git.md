

# https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud # recommended by @aviolat
git init
git add
.hignore
git branch BRANCHNAME
git commit -m "message"
git checkout master
git merge BRANCHNAME
git branch -d BRANCHNAME
git log

git help -a
git help -g

# This will destroy any local modifications.
# Don't do it if you have uncommitted work you want to keep.
git reset --hard 0d1d7fc32

# This will destroy any local untracked modifications
git clean -n # review what is about to be deleted
git clean -f # do the deletion

git reset HEAD~  # undo last commit and put its change in the work tree
git reset HEAD~1 # undo last commit and put its change in the work tree
git reset HEAD~2 # undo last commit and put its change in the work tree

git checkout -- <file> # revert reset discard unstaged change
git checkout -- . # forget revert reset discard unstaged change

git branch # list of branches
git branch -a # list of branches including remote
git remote show origin # list remote branches
git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d # delete merged branches


git show 8647ae93864cdf0a42da59c4f33b319ce6324366

git branch -m oldname newname # renames local branch
git branch -m newname # renames current local branch

git mv # rename

git submodule add https://github.com/flazz/vim-colorschemes.git bundle/colorschemes
git clone --config http.sslVerify=false https://git:8443/git/infra_auto_config.git
git clone git@gitlab.ksnet.nagra.com:CFC/zabbix.git
git clone https://$USER@gitlab.ksnet.nagra.com/CFC/managed-devices-tools.git
git config --global user.name "Donald Duck"
git config --global user.email "donald.duck@acme.it"
git add README.md
git commit -m "add README"
git push -u origin master

git difftool --tool=vimdiff --no-prompt

git diff --stat --cached origin/master     # http://stackoverflow.com/questions/3636914/how-can-i-see-what-i-am-about-to-push-with-git
git diff --stat --cached origin/production # http://stackoverflow.com/questions/3636914/how-can-i-see-what-i-am-about-to-push-with-git
git push --dry-run
git cherry -v # To simply list the commits waiting to be pushed: (this is the one you will remember)
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global difftool.prompt false
vim -p `git diff --name-only`
$ git show :1:hello.rb > hello.common.rb
$ git show :2:hello.rb > hello.ours.rb
$ git show :3:hello.rb > hello.theirs.rb

git config --global -e
git config --global -l
git config -l
git config -e

# MERGE
git mergetool
:diffg RE  " get from REMOTE
:diffg BA  " get from BASE
:diffg LO  " get from LOCAL
git add -u
git commit -m merged
git push origin master

# http://stackoverflow.com/questions/4785107/resolve-conflicts-using-remote-changes-when-pulling-from-git-remote
If you truly want to discard the commits you've made locally, i.e. never have them in the history again, you're not asking how to pull - pull means merge, and you don't need to merge. All you need do is this:
@begin=sh@
# fetch from the default remote, origin
git fetch
# reset your current branch (master) to origin's master
git reset --hard origin/master
@end=sh@
I'd personally recommend creating a backup branch at your current HEAD first, so that if you realize this was a bad idea, you haven't lost track of it.
If on the other hand, you want to keep those commits and make it look as though you merged with origin, and cause the merge to keep the versions from origin only, you can use the ours merge strategy:
@begin=sh@
# fetch from the default remote, origin
git fetch
# create a branch at your current master
git branch old-master
# reset to origin's master
git reset --hard origin/master
# merge your old master, keeping "our" (origin/master's) content
git merge -s ours old-master
@end=sh@

git pull -s recursive -X theirs

# Git performs a three-way merge, finding the common ancestor (aka "merge base") of the two branches you are merging. When you invoke git mergetool on a conflict, it will produce these files suitable for feeding into a typical 3-way merge tool. Thus:
foo.LOCAL: the "ours" side of the conflict - ie, your branch (HEAD) that will contain the results of the merge
foo.REMOTE: the "theirs" side of the conflict - the branch you are merging into HEAD
foo.BASE: the common ancestor. useful for feeding into a three-way merge tool
foo.BACKUP: the contents of file before invoking the merge tool, will be kept on the filesystem if mergetool.keepBackup = true.

# diff between branches
git diff branch1 branch2 -- # -- is a separator between branches and filenames. This is optional but help when a branch has the same name as a file/directory


# change origin url
git remote set-url origin git://new.url.here
git remote set-url origin ssh://git@gitlab.ksnet.nagra.com/CFC/managed-devices-tools.git
git remote add origin git0@ly.abc1.ch:docker && git branch --set-upstream-to=origin/master master
git remote add origin git0@jexternalssh.ly.lan:docker && git branch --set-upstream-to=origin/master master

git clone ssh://git0@ly.abc1.ch:443/home/git0/stdhome



git checkout . # revert local changes
git checkout bip.py # revert local changes for file bip.py


git config --get remote.origin.url # If referential integrity has been broken:
git remote show origin # If referential integrity is intact:

git help everyday

http://stackoverflow.com/questions/6934752/combining-multiple-commits-before-pushing-in-git
git rebase -i origin/master     # Change all the pick to squash except the first one:
git rebase -i origin/production # Change all the pick to squash except the first one:
git tag $(git_current_branch)-prerebase-$(date-Y.m.d.sh)

git pull
git fetch
#git pull does a git fetch followed by a git merge.
git archive --remote=ssh://git@gitlab.ksnet.nagra.com/CFC/managed-devices-tools.git HEAD zabbix/zabbix-servicenow.py


https://atlassian.cyberfusion.center/confluence/display/C0001/Git+for+puppet+code


# serving a server:
git init --bare
# or if it was done on init
git config --bool core.bare true

# list file currently versionned control
git ls-tree -r master --name-only

http://toroid.org/git-website-howto


https://atlassian.cyberfusion.center/confluence/display/C0001/Git+for+puppet+code # r10k
BRANCH=my-new-branch
git branch $BRANCH
git checkout $BRANCH
git commit
git push --set-upstream origin $BRANCH
git commit && git push # reiterate if needed, default remote branch has been set for this local branch
git checkout production
git pull
git merge $BRANCH
git branch -d $BRANCH # -d is --delete
git push origin --delete $BRANCH


http://stackoverflow.com/questions/1628088/reset-local-repository-branch-to-be-just-like-remote-repository-head
#Setting your branch to exactly match the remote branch can be done in two steps:
git fetch origin
git reset --hard origin/master
#If you want to save your current branch's state before doing this (just in case), you can do:
git commit -a -m "Saving my work, just in case"
git branch my-saved-work

# git clone subdirectory partial subpart http://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository
@begin=sh@
# What you are trying to do is called a sparse checkout, and that feature was added in git 1.7.0 (Feb. 2012). The steps to do a sparse clone are as follows:
mkdir <repo>
cd <repo>
git init
git remote add -f origin <url>
# This creates an empty repository with your remote, and fetches all objects but doesn't check them out. Then do:
git config core.sparseCheckout true
# Now you need to define which files/folders you want to actually check out. This is done by listing them in .git/info/sparse-checkout, eg:
echo "some/dir/" >> .git/info/sparse-checkout
echo "f5/python" >> .git/info/sparse-checkout
echo "another/sub/tree" >> .git/info/sparse-checkout
# Last but not least, update your empty repo with the state from the remote:
git pull origin master
@end=sh@

git archive --remote=git@gitlab.ksnet.nagra.com:CFC/ide-infra.git master katello/create-foreman-vm.sh | tar xvf - # extract raw specific files from repo

# configure pull push default
git config branch.master.remote origin # configure pull push default
git config branch.master.merge refs/heads/master # configure pull push default
git branch --set-upstream-to=jlighttpd/<branch> master # configure pull push default

git remote get-url origin # get remote url



git push -u origin --all
git push -u origin --tags
git push --tags
git push origin mytagname # push single tag (origin is mandatory)


git submodule update --init --recursive # first time
git submodule update --recursive --remote # pull


RB=master; LB=master; R=origin; git fetch $R && git diff $LB $R/$RB # http://stackoverflow.com/questions/5162800/git-diff-between-cloned-and-original-remote-repository


git branch -d bip # delete rm remove local branch
git push origin --delete bip # delete rm remove remote branch


git ls-files --deleted -z | xargs -0 git rm # https://stackoverflow.com/questions/492558/removing-multiple-files-from-a-git-repo-that-have-already-been-deleted-from-disk git autoremove files no longer present

git reset --hard commitHash # cancel / revert local, puts back HEAD to previous commit (you should use the commit that you want to restart, eg. 44a587491e32eafa1638aca7738)
git revert REF # cancels out specified REF in a new commit with its inverted diff



git log -1

https://stackoverflow.com/questions/16244969/how-to-tell-git-to-ignore-individual-lines-i-e-gitignore-for-specific-lines-of # part of file


# https://stackoverflow.com/questions/594757/how-do-i-do-a-git-status-so-it-doesnt-display-untracked-files-without-using git status ignore untracked
git status -uno # which is equivalent to git status --untracked-files=no
git config status.showuntrackedfiles no

# list untracked files
git ls-files --others --exclude-standard

# store in another directory
export GIT_DIR=/home/jly200_user/gitfw/
export GIT_WORK_TREE=/

GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentityFile=tmp/id_rsa"
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentityFile=$HOME/.ssh/id_rsa"

@begin=sh@
#!/usr/bin/env bash

set -eux
DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
cd $DIR
[[ -d git/ ]] && rm -rf git/
mkdir git/
cd git
git init
git remote add -f origin git://github.com/rails/rails.git
git config core.sparseCheckout true

echo "
python/configs/zabbix-adhoc-template.json
python/configs/zabbix-adhoc-template.conf
python/idecore/__init__.py
python/idecore/credentials.py
python/idecore/d42.py
python/idecore/idelogging.py
python/idecore/idetools.py
python/idecore/zabbix.py
python/zabbix-adhoc-template.py
" > .git/info/sparse-checkout
git pull origin master
@end=sh@

http://teotti.com/a-successful-deploy-workflow-using-git-tags-and-a-changelog/

export GIT_SSL_NO_VERIFY=true

git rm --cached <file> # untrack stop tracking forget file (will happen at next commit)

# merge repos https://stackoverflow.com/questions/1425892/how-do-you-merge-two-git-repositories
git subtree add --prefix=PocNginxTomcatMysql ../PocNginxTomcatMysql/.git master
git subtree add --prefix=rails git://github.com/rails/rails.git master


git ls-tree -r master --name-only # all files in master that git knows about
git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d' # all files that ever existed in git repo


# Creating Tags
Git supports two types of tags: lightweight and annotated.
A lightweight tag is very much like a branch that doesn’t change — it’s just a pointer to a specific commit.
Annotated tags, however, are stored as full objects in the Git database. They’re checksummed; contain the tagger name, email, and date; have a tagging message; and can be signed and verified with GNU Privacy Guard (GPG). It’s generally recommended that you create annotated tags so you can have all this information; but if you want a temporary tag or for some reason don’t want to keep the other information, lightweight tags are available too.

see parent commit message for more info about this tag

# Listing tags https://stackoverflow.com/questions/35762002/how-to-get-all-local-and-remote-tags-in-git
git fetch --tags
git tag
git tag -l PATTERN

# work-tree
$ git worktree add -b emergency-fix ../temp master
$ pushd ../temp
# ... hack hack hack ...
$ git commit -a -m 'emergency fix for boss'
$ popd
$ rm -rf ../temp
$ git worktree prune

# debug connection with wrapper. Watch out ssh stderr seems to be parsed by git parent process
@begin=sh@
ssh_wrapper=/tmp/my-ssh-wrapper
cat > $ssh_wrapper << EOF
#!/usr/bin/env bash
echo -e "\n\$(date) \$0 \$@" >> /tmp/logfile.txt
exec > >(tee -a /tmp/logfile.txt)
exec 2> /tmp/logfile2.txt
ssh -o LogLevel=DEBUG3 -o IdentityFile=$(get_private_key_filepath) \$@
EOF
chmod u+x $ssh_wrapper
export GIT_SSH="$ssh_wrapper



git log newbranch..oldbranch # To show the commits in oldbranch but not in newbranch:
git diff newbranch...oldbranch # To show the diff in the commits in oldbranch but not in newbranch:
git log oldbranch ^newbranch --no-merges # show commit logs for all commits on oldbranch that are not on newbranch
git log oldbranch1 oldbranch2 ^newbranch1 ^newbranch2 --no-merges   # show commit logs for all commits on oldbranch that are not on newbranch1 nor newbranch2


git grep 'create_ou' $(git rev-list --all) -- ad.py
git checkout 'master@{1979-02-26 18:30:00}'
git checkout `git rev-list -n 1 --before="2009-07-27 13:37" master`


git config -e
[filter "ssh_config"]
    clean = "sed -r -e '/# ?(gitignore|sedkatello|sedvirtualbox)$/'d"
config filter=ssh_config # part of WORKDIR/.gitattributes ~/.gitattributes or GIT_DIR/attributes


git format-patch HEAD^ # see detailed diff changes (including file mode) # https://stackoverflow.com/questions/14564946/git-status-shows-changed-files-but-git-diff-doesnt

git config --global branch.autosetuprebase always

git log --all --full-history -- **/thefile.* # "grep" history filename
git log --all --full-history -- <path-to-file> # "grep" history exact filepath
git show <SHA>:<path-to-file> # "cat raw file from history"
git checkout <SHA>^ -- <path-to-file> # "restore specific file as it was from history
@end=sh@


# relative reference https://git-scm.com/book/en/v2/Git-Tools-Revision-Selectiohttps://git-scm.com/book/en/v2/Git-Tools-Revision-Selection
git diff 'HEAD@{2.months.ago}'
git show 'HEAD@{1.weeks.ago}':smart_class_variables_diffs_katello/identity/identity::users.json # cat
master@{yesterday}
HEAD@{5}
HEAD^
HEAD^^^
HEAD~3
HEAD~
d921970^2 means “the second parent of d921970" (only useful for commit with multiple parents such as merge commit)

gitk # graph gui
gitk --simplify-by-decoration --all
gitk master origin/master origin/experiment
gitk --all

# https://help.github.com/articles/removing-sensitive-data-from-a-repository/
# https://rtyley.github.io/bfg-repo-cleaner/

git rev-parse --abbrev-ref HEAD # current branch

git stash # checkout current version and pushes local modification to the stash stack
git stash pop # pulls at the top of the stash's stack

git --git-dir=~/git/ly.abc1.ch/stdenv/.git submodule deinit ~
[submodule ".vim/bundle/Align"]
    path = .vim/bundle/Align
    url = https://github.com/vim-scripts/Align.git
[submodule ".vim/bundle/AutoComplPop"]
    path = .vim/bundle/AutoComplPop
    url = https://github.com/vim-scripts/AutoComplPop.git
[submodule ".vim/bundle/colorschemes"]
    path = .vim/bundle/colorschemes
    url = https://github.com/flazz/vim-colorschemes.git
[submodule ".vim/bundle/puppet"]
    path = .vim/bundle/puppet
    url = https://github.com/rodjek/vim-puppet.git
[submodule ".vim/bundle/tabular"]
    path = .vim/bundle/tabular
    url = https://github.com/godlygeek/tabular.git
[submodule ".vim/bundle/AnsiEsc"]
    path = .vim/bundle/AnsiEsc
    url = https://github.com/vim-scripts/AnsiEsc.vim.git
[submodule ".vim/bundle/SyntaxRange"]
    path = .vim/bundle/SyntaxRange
    url = https://github.com/vim-scripts/SyntaxRange.git
[submodule ".vim/bundle/bufexplorer"]
    path = .vim/bundle/bufexplorer
    url = https://github.com/jlanzarotta/bufexplorer.git
[submodule ".vim/bundle/ingo-library"]
    path = .vim/bundle/ingo-library
    url = https://github.com/vim-scripts/ingo-library.git
[submodule ".vim/bundle/Dockerfile"]
    path = .vim/bundle/Dockerfile
    url = https://github.com/ekalinin/Dockerfile.vim
[submodule ".vim/colorschemes"]
    path = .vim/colorschemes
    url = https://github.com/flazz/vim-colorschemes.git
[submodule ".vim/bundle/vim-gitgutter"]
    path = .vim/bundle/vim-gitgutter
    url = https://github.com/airblade/vim-gitgutter.git


# interactive
git add --interactive # stages
git add -p # stages interactively
git reset -p # unstages interactively

# diff conveniency
git diff --ignore-space-at-eol     # white blank spaces diff
git diff --color-words # https://stackoverflow.com/questions/28551556/git-remove-leading-plus-minus-from-lines-in-diff
git log -b # --ignore-space-change # white blank tabs spaces diff
git log -w # --ignore-all-space    # white blank tabs spaces diff
git log --ignore-blank-lines       # white blank tabs spaces diff
git log --inter-hunk-context= # diff with more lines of context like in grep -C -A -B
git log -W # --function-context # diff

# https://stackoverflow.com/questions/1764380/how-to-push-to-a-non-bare-git-repository
git config --local receive.denyCurrentBranch updateInstead

# browse other revisions
git ls-tree --long REV -- .
git show REV:./myfile.tx # relative maybe useful as CWD is not respected otherwise

# change commit author
export GIT_AUTHOR_NAME="Jeff Malone" GIT_AUTHOR_EMAIL="jeff@malone.com" GIT_COMMITTER_NAME="Jeff Malone" GIT_COMMITTER_EMAIL="jeff@malone.com"
git commit --amend --reset-author

git config --local user.name "Jeff Malone"
git config --local user.email "jeff.malone.com"

git checkout master && git reset --hard 24e4306 && git pull # repair ide-infra

git config pull rebase true

if [ -z "$(git status --porcelain)" ]; # working directory clean             https://unix.stackexchange.com/questions/155046/determine-if-git-working-directory-is-clean-from-a-script
if [ -n "$(git status --porcelain)" ]; # uncommitted change in tracked files https://unix.stackexchange.com/questions/155046/determine-if-git-working-directory-is-clean-from-a-script


git log --oneline $MAINREF..$MYREF | awk-print1.sh | tac | while read a; do git show --color-words $a; done # for
for i in $(git diff $REF --name-only); do git diff $REF -- $i; done # while

git log --no-renames

git rev-parse --show-toplevel # https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-commandt rev-parse --show-toplevel

# Client hooks
## Around commits:
* pre-commit: before commit creation, even before message editing (e.g. linting, unit tests);
* prepare-commit-msg: before commit creation, when everything's ready to start editing the message (e.g. pre-calculated message injection);
* commit-msg: before commit creation, but after message editing (e.g. message content control and override);
* post-commit: when the commit is done (e.g. notification);
## Around patches (git am):
* applypatch-msg: before the patch (e.g. check patch message);
* pre-applypatch: after the patch is applied, but before the commit is created (e.g. patch content validation);
* post-applypatch: when the path is applied and the commit is done (e.g. notify patch author);
# Other actions:
* pre-rebase: before starting git rebase (e.g. stop rebase of master branch);
* post-checkout: after git checkout execution, for instance on rebase or at the end of a git clone (e.g. setting up a branch-associated configuration);
* post-merge: after a successful git merge (e.g. check if there are conflict markers left after a "bad" merge);
* post-rewrite: called by "rewriting" commands (git commit --amend, git rebase);
* pre-auto-gc: on garbage collection (e.g. stop references clean-up if we have to use old ones);
* pre-push: just before pushing revisions and objects to a remote repository (e.g. running unit tests and stop push if they they fail).

git diff -w --no-color [file names] | git apply --cached --ignore-whitespace # https://stackoverflow.com/questions/23910879/git-unstage-lines-where-the-only-changes-is-white-space
