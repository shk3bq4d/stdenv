#!/usr/bin/env bash
# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

export VIMF6=1

[[ -z "$1" ]] && echo "Inception A" && exit 1
SCRIPT="$1"
LOG="$2"
#exec > >(tr -d '\r' | tee "$LOG")
exec > >(tee "$LOG")
exec 2>&1
SCRIPT_DIR=$(dirname "$SCRIPT")
SCRIPT_NAME=$(basename "$SCRIPT")
export PYTHONUNBUFFERED=hehe
function myexit() {
    echo "vimf6.sh by extension exit code is $1" # to review if we have case exit corde or real interpreter
    exit $1
}

# puppet module to capsule
if [[ "$SCRIPT" = */puppet-envs/modules/* ]]; then
    last_host_fp=~/.tmp/vimf6-last_host
    last_capsule_fp=~/.tmp/vimf6-last_capsule
    all_capsule_fp=~/.tmp/vimf6-all_capsule

    k=0
    if [[ -f $last_capsule_fp ]]; then
        last_capsule=$(<$last_capsule_fp)
        # all_proposals="$(grep -vw $last_capsule $all_capsule_fp)"
    else
        last_capsule=""
    fi
    # all_proposals="$(<$all_capsule_fp)"

    readarray pA < $all_capsule_fp

    # echo "$all_proposals"
    # exit 0
    choice=-1
    #echo "$all_proposals" |
    #while read line; do
    for k in "${!pA[@]}" # iterate over an array
    do
        printf "%2i %s\n" $k ${pA[$k]}
    done
    while :; do
        echo -en "\nChoose your capsule [$last_capsule]: "
        read response
        if [[ -z $response ]]; then
            if [[ -n $last_capsule ]]; then
                capsule=$last_capsule
                break
            fi
            continue
        fi
        capsule=${pA[$response]}
        [[ -n "$capsule" ]] && break
    done

    echo -e "\ncapsule is $capsule\n"
    # optional PATH assignment to override version in ~/bin, to test work copy
    # export PATH=~/git/ksgitlab/cfc/ide-infra/scripts:$PATH
    puppet-file-to-capsule.sh $capsule $SCRIPT && echo -n $capsule > $last_capsule_fp
    if [[ -f $last_host_fp ]]; then
        last_host=$(<$last_host_fp)
    else
        last_host=""
    fi
    echo -en "\nWould you like to execute a puppet agent run [${last_host^^},y,n]: "
    read response
    case $response in \
    n|N) exit 0 ;;
    y|Y|"")
        target=$last_host
        ssh $target true || { echo "FATAL: not a (a) host $target"; exit 1; }
        ;;
    *)
        target=$response
        ssh $target true && echo $target > $last_host_fp || { echo "FATAL: not a (b) host $target"; exit 1; }
        ;;
    esac
    echo # ex: set paste! wrap! number!=:
    echo "ssh $target sudo /opt/puppetlabs/puppet/bin/puppet agent -t"
    ssh $target sudo /opt/puppetlabs/puppet/bin/puppet agent -t
    echo ":AnsiEsc/F3 is your friend to colorize input"

    exit 0
fi


# executables
if [[ -x "$SCRIPT" ]]; then
    $SCRIPT
    myexit $?
fi

# shebang
FIRSTLINE=$(head -n 1 $SCRIPT)
if [[ $FIRSTLINE =~ ^#!.* ]]; then
    CMD=$(echo "$FIRSTLINE" | sed -r -e 's/^..//')
    $CMD $SCRIPT
    myexit $?
fi

# by extension
case "$SCRIPT" in \
vimf6.sh)
    echo "Inception B"
    exit 0
    ;;
*sh)  bash    $SCRIPT; myexit $?;;
*py)  python3 $SCRIPT; myexit $?;;
*pl)  perl    $SCRIPT; myexit $?;;
*php) php     $SCRIPT; myexit $?;;
*java)
    D=$SCRIPT_DIR
    mrjava_cp() {
        if [[ -d ../MrTools/ ]]; then
            echo -n ':../MrTools/build/classes'
        fi
        if [[ -d ../jar ]]; then
            echo -n ':../jar/*'
        fi
    }
    ant_output() {
        cat "$@" | sed -r -e '/^$/ d' | python -c "
# @begin=python@
# removes ant blocks that have no output
import fileinput
import re
prev_line = ''
for line in map(lambda x: x.rstrip(), fileinput.input('-')):
    if line == '': continue
    if re.match(r'^\\S+:', prev_line) and re.match(r'^\\S+:', line): pass
    else: print(prev_line)
    prev_line = line
print(prev_line)
# @end=python@
"
        }
    package=$(sed -r -n -e 's/^[[:blank:]]*package[[:blank:]]+([[:graph:]]+)[[:blank:]]*;.*/\1/ p' "$SCRIPT")
    test -n "$package" && package="${package}/"
    while :; do
        if [[ -f "$D/build.xml" ]]; then
            C=$(mktemp)
            cd $D
            if ant compile &> $C; then
                if cat $SCRIPT | sed -r -e 's/[[:blank:]]+/ /g' | tr '\n\r' '  ' | tr -s ' ' | grep -qE '\<void main ?\('; then
                    rm -f $C
                    echo "Would you like to execute ? Press Ctrl-C to abord"
                    echo java -cp "build/classes:$(mrjava_cp)" ${package}$(basename $SCRIPT .java)
                    read a
                         java -cp "build/classes:$(mrjava_cp)" ${package}$(basename $SCRIPT .java)
                    exit 0
               else
                    ant_output $C
                    exit 0
                fi
            else
                ant_output $C
                exit 1
            fi
        fi
        D="$(readlink -f "$(dirname "$D")")"
        if [[ -z $D || "$D" == "/" ]]; then
            javac $SCRIPT -d /tmp
            java -cp "/tmp/" ${package}$(basename $SCRIPT .java)
            #echo "Couldn't find a proper java compilation method"
            exit 1
        fi
    done
    ;;
*md)
    f=~/.local/bin/grip
    if [[ ! -x "$f" ]]; then
        echo "$0 FATAL $f, run pip install --user grip"
        exit 1
    fi
    if pgrep grip &>/dev/null; then
        echo "$0 INFO killing current existing grip session with PID $(pgrep grip)"
        pkill -9 grip
    fi
    echo "$0 starting background grip preview should starting in new browser tab"
    nohup ~/.local/bin/grip --quiet --title "$SCRIPT" -b $SCRIPT &>/dev/null &
    exit 0
    ;;
*.viz|*.dot|*.neato|*.fdp)
case $SCRIPT in \
    *.fdp) engine=fdp ;;
        *.neato) engine=neato ;;
        *)
            engine=dot
            ;;
    esac
    svg=/tmp/${SCRIPT_NAME}.svg
    $engine -Tsvg -o$svg -v $SCRIPT
    nohup firefox $svg &>/dev/null &
    exit 0
    ;;
*svg)
    nohup firefox $SCRIPT &>/dev/null &
    exit 0
    ;;
*yml)
    # trying for ansible
    if grep -qE "^[- ] hosts:" $SCRIPT; then
        #ansible-playbook $SCRIPT --ask-become-pass --diff --check
        ansible_args="$(sed -r -n -e '/vimf6_ansible_args:/s/.*:// p' $SCRIPT | head -n 1)"
        if test -z "$ansible_args"; then
            ansible_args="--diff --check"
            echo "Running ansible in check mode"
        fi
        while read key value; do
            #[[ "$key" == "ansible"* ]] && echo upper
            #[[ "$key" == "ansible"* ]] && key=${key^^}
            echo "export ANSIBLE_${key^^}=$value"
            eval "export ANSIBLE_${key^^}=$value"
        done < <(head -n 50 $SCRIPT | sed -r -n -e 's/^.{,4}vimf6_ansible_env:\s*(.+)\s*[:=]\s*(.*?)/\1 \2/ p')

        export ANSIBLE_STDOUT_CALLBACK=yaml
        #export ANSIBLE_STDOUT_CALLBACK=timer
        #export ANSIBLE_STDOUT_CALLBACK=dense
        #export ANSIBLE_STDOUT_CALLBACK=unixy
        #export ANSIBLE_STDOUT_CALLBACK=oneline
        # export ANSIBLE_DISPLAY_OK_HOSTS=no
        if grep -wq become $SCRIPT && ! grep -w vimf6_ansible_nolocalsudo: $SCRIPT | head -n 1 | grep -wqiE '(yes|true|1)'; then
            sudo true
            set -x
            # the eval allows --start-at-task "multiple word" constructs
            #eval sudo -E $(which ansible-playbook) $SCRIPT ${ansible_args} 2>&1 | ts # -l 127.0.0.1
            eval ansible-playbook $SCRIPT                  ${ansible_args} 2>&1 | ts # -l 127.0.0.1
            _exit=$?
        else
            # the eval allows --start-at-task "multiple word" constructs
            set -x
            eval ansible-playbook $SCRIPT                  ${ansible_args} 2>&1 | ts # -l 127.0.0.1
            _exit=$?
        fi
        set +x
        rm -f $SCRIPT_DIR/$(basename $SCRIPT .yml).retry || true
        myexit $_exit
    else
        #echo "($(basename $0)): unimplemented case for YAML script $SCRIPT"
        echo '# /* e''x: set filetype=python */'
        python -c "
import yaml
import pprint
with open('$SCRIPT', 'rb') as f:
    pprint.pprint(yaml.safe_load(f))
            "
        exit 0
    fi
    ;;
$HOME/.Xdefaults)
    set -x
    xrdb -merge ~/.Xdefaults
    myexit $?
    ;;
*tf)
    terraform apply -no-color
    myexit $?
    ;;
*txt)
    echo "($(basename $0)): ignored for filetype $SCRIPT"
    exit 0
    ;;
*tex)
    out=/tmp/$(date +'%Y.%m.%d_%H.%M.%S')-${SCRIPT_NAME}.pdf
    #docker run -i narf/latex < $SCRIPT > $out
    image=mrlatex
    if ! docker images $image | grep -wqE "^${image}"; then
        echo "Image not found $image, execute the following:"
        echo "  git clone https://github.com/shk3bq4d/docker-latex/ ~/git/shk3bq4d/docker-latex/ && \\"
        echo "    cd ~/git/shk3bq4d/docker-latex/ && ./build.sh"
        exit 1
    elif docker run -i mrlatex < $SCRIPT > $out 2>/dev/null; then
        echo $out
        nohup evince $out &>/dev/null </dev/null &
        exit 0
    else
        echo "exit code is $?"
        cat $out
        exit 1
    fi
    ;;
*.plantuml)
    f=~/.tmp/bip.svg
    echo $f
    date
    cat $SCRIPT | docker run --rm -i think/plantuml > $f
    chromium-browser --incognito --new-window --app=file://$f
    date
    exit 0
    echo "please ensure to have run
docker run -d -p 8081:8080 plantuml/plantuml-server:jetty
        "
        echo wget -O/tmp/bip.svg "http://localhost:8081/svg/$(cat $SCRIPT | base64 | tr -d '\n')"
    ;;
$HOME/.config/i3/config)
    cd $HOME/.config/i3/
    #i3 restart && sleep 5 && compton-i3-restart-reset-opacity.sh
    i3 restart && sleep 5 && compton-reinitialize.py
    echo "i3 restarted A"
    exit 0
    ;;
$HOME/.config/i3/config.*)
    cd $HOME/.config/i3/
    ./stdhome-templating-config.sh
    i3 restart || true
    { sleep 6 && compton-reinitialize.py; } &
    echo "i3 restarted B"
    exit 0
    ;;
*/Dockerfile)
    if [[ -f $SCRIPT_DIR/build.sh ]]; then
        bash $DIR/build.sh
    elif [[ -f $SCRIPT_DIR/../build.sh ]]; then
        bash $SCRIPT_DIR/../build.sh
    else
        docker build -f $SCRIPT $SCRIPT_DIR
    fi
    exit 0
    ;;
/e/*/validator/run/rules/*/*/*.js)
    set -x
    /validator/testrules.sh -j $(echo $SCRIPT | sed -r -e 's/.*rules.(.*)/\1/')
    exit $?
    ;;
*)
    # validator.sh
    if [[ "$HOSTNAME" = jly200 ]] && head -c 6 $SCRIPT | grep -qE '^\{1:F01$'; then
        cd /validator
        ./tree.sh -r $(date +'%y') -e 1 $SCRIPT 2>&1 | dos2unix
        exit $?
    fi
    exit 1
    ;;
esac
echo "($(basename $0)): unimplemented case for script $SCRIPT"
exit 1
