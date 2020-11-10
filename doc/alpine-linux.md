# https://wiki.alpinelinux.org/wiki/How_to_get_regular_stuff_workingo
apk add man man-pages
apk add bash bash-doc bash-completion
apk add util-linux pciutils usbutils coreutils binutils findutils grep
apk add udisks2 udisks2-doc
apk add gettext libintl openssl


# man pages
apk add mandoc man-pages  less less-doc
apk add openssh-doc # search for packages with the -doc
export MANPAGER='less -sR'
