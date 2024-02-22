#!/usr/bin/env bash
# 1000000000 => 2001-09-09 03:46:40
# 2000000000 => 2033-05-18 05:33:20

bip() {
	cat << 'EOF'
msg=audit(1689087243.868:61): avc:  denied  { getatk
other line
EOF
}
# https://mywiki.wooledge.org/IFS#:~:text=The%20IFS%20variable%20is%20used,is%20space%2C%20tab%2C%20newline.
delimiter=","
delimiter=$'\1'

#bip |
	sed -u -r -e 's/(.*)(\<1[0-9]{9}\>)(.*)/\1'"$delimiter"'\2'"$delimiter"'\3/' \
	"$@" |
	while IFS="$delimiter" read a b c; do
		if [[ -n "$b" ]]; then
			echo "$(date -d @$b +'%Y.%m.%d %H:%M:%S') $a $c"
		else
			echo "$a"
		fi
	done
