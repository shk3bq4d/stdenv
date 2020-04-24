#!/usr/bin/env bash

function _go() {
	local OLD_SUDOUSER_GID OLD_SUDOUSER_NAME OLD_SUDOUSER_GROUPNAME OLD_USER_GID OLD_USER_NAME OLD_USER_GROUPNAME
	set -eux

	OLD_USER_NAME=user
	OLD_SUDOUSER_NAME=sudouser
	OLD_USER_GROUPNAME=$OLD_USER_NAME
	OLD_SUDOUSER_GROUPNAME=$OLD_SUDOUSER_NAME

	test -n "${SUDOUSER_UID:-}" && usermod -u $SUDOUSER_UID $OLD_SUDOUSER_NAME
	test -n "${USER_UID:-}"     && usermod -u     $USER_UID     $OLD_USER_NAME
	if [[ -n "${SUDOUSER_GID:-}" ]]; then
		OLD_SUDOUSER_GID=$(id -g $OLD_SUDOUSER_NAME)
		find $(eval echo ~$OLD_SUDOUSER_NAME) -gid $OLD_SUDOUSER_GID -print0 | xargs -0r chgrp $SUDOUSER_GID
		groupmod -g $SUDOUSER_GID $OLD_SUDOUSER_GROUPNAME
	fi
	if [[ -n "${USER_GID:-}" ]]; then
		OLD_USER_GID=$(id -g $OLD_USER_NAME)
		find $(eval echo ~$OLD_USER_NAME) -gid $OLD_USER_GID -print0 | xargs -0r chgrp $USER_GID
		groupmod -g $USER_GID $OLD_USER_GROUPNAME
	fi
	set +x
	echo done
}
_go
exec "$@"
