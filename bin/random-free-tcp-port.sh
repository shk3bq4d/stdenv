#!/usr/bin/env bash
# arguments passed on the command line are added to the forbidden ports

MAX_AVAILABLE_PORT=65535
MIN_AVAILABLE_PORT=1024

if [[ $MAX_AVAILABLE_PORT -lt $MIN_AVAILABLE_PORT ]]; then
    a=$MAX_AVAILABLE_PORT
    MAX_AVAILABLE_PORT=$MIN_AVAILABLE_PORT
    MIN_AVAILABLE_PORT=$a
fi

if false; then
    ports() {
        netstat -tan | sed -r -n -e '/[0-9]/s/.*:([0-9\*]+).*:([0-9\*]+).*/\1\n\2/g p'  | grep -vF '*'
    }
    max_port=$(ports | sort -n | tail -1)
    #echo "max_port is $max_port"

    if [[ $max_port -le $MIN_AVAILABLE_PORT ]]; then
        echo $MAX_AVAILABLE_PORT
        exit 0
    fi
    if [[ $max_port -ge $MAX_AVAILABLE_PORT ]]; then
        min_port=$(ports | sort -n | head -1)
        if [[ $min_port -le $MIN_AVAILABLE_PORT ]]; then
            echo "FATAL"
            exit 1
        fi
        echo $(( $min_port - 1 ))
        exit 0
    fi
    echo $(( $max_port + 1 ))
fi
_netstat="$(netstat -tan)"
diff=$(( MAX_AVAILABLE_PORT - MIN_AVAILABLE_PORT ))
while :; do
    P=$(( ( RANDOM  % diff ) + MIN_AVAILABLE_PORT ))

    # check not lower than min port
    [[ $P -lt $MIN_AVAILABLE_PORT ]] && continue
    # check not higher than max port
    [[ $P -gt $MAX_AVAILABLE_PORT ]] && continue
    # check that value is not in the argument list
    [[ " ${@} " =~ " $P " ]] && continue

    # check that the port is not currently in used
    grep -qw "$P" <<< "$_netstat" && continue
    echo $P
    break
done
