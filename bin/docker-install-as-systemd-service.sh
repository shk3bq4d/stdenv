#!/usr/bin/env bash


set -e
set -u

if [[ ! -f Dockerfile ]]; then
	echo "FATAL: this script should be run from a directory containing a Dockerfile"
	exit 1
fi

NAME=$(basename $(realpath .))

if [[ -z "$(docker images "$NAME" -q)" ]]; then
	echo "FATAL: Unknown image $NAME"
	exit 2
fi

SYSTEMDFP=/etc/systemd/system/docker-${NAME}.service

if [[ -f "$SYSTEMDFP" ]]; then
	echo "FATAL: file already exists $SYSTEMDFP"
	exit 3
fi

if [[ $EUID -ne 0 ]]; then
	sudo $0 "$@"
	exit $?
fi

echo "
[Unit]
Description=${NAME}
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a ${NAME}
ExecStop=/usr/bin/docker stop -t 2 ${NAME}

[Install]
WantedBy=default.target
" > $SYSTEMDFP
systemctl daemon-reload

echo "systemctl start  docker-${NAME}.service # to start the service"
echo "systemctl enable docker-${NAME}.service # to make it autostart on boot"
