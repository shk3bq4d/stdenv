#!/usr/bin/env bash

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_sed() {
    cat << 'EOF'
# 214480 12:56:48.152486 recvmsg(9, {msg_namelen=0}, 0) = -1 EAGAIN (Resource temporarily unavailable) <0.000007>
/(read|recvmsg).{,40}EAGAIN .Resource temporarily unavailable. <[0-9.]+>$/ d

# 214480 12:56:48.152186 epoll_wait(32, [{events=EPOLLIN, data={u32=3967284256, u64=128333295121440}}], 32, 0) = 1 <0.000009>
/ epoll_wait\(/ d
/ poll\(\[/ d
/ futex\(/ d
/ mmap\(/ d
/ munmap\(/ d
/ munmap\(/ d
/ mprotect\(/ d
/ close\(/ d
/ timerfd_settime\(/ d

/ (read|write|writev|recvmsg)\(.*"[^"]?(\\([a-z]|[0-9]{,4})[^"]{,2})+"/ d
EOF
}

_vimf6_data() {
    cat << 'EOF' | grep -vE '^#' 
214480 12:56:48.152486 recvmsg(9, {msg_namelen=0}, 0) = -1 EAGAIN (Resource temporarily unavailable) <0.000007>
214480 12:56:48.152274 read(38, 0x74b7ec7709c0, 6144) = -1 EAGAIN (Resource temporarily unavailable) <0.000008>
214480 12:56:48.152186 epoll_wait(32, [{events=EPOLLIN, data={u32=3967284256, u64=128333295121440}}], 32, 0) = 1 <0.000009>
214480 12:56:48.152227 read(38, "\203\367\7\0\0\0\0\0@\221\5\0\0\0\0\0\4\0\4\0(\0\7\0\203\367\7\0\0\0\0\0@\221\5\0\0\0\0\0\1\0\34\0\0\0\0\0\203\367\7\0\0\0\0\0@\221\5\0\0\0\0\0\0\0\0\0\0\0\0\0", 6144) = 72 <0.000010>
214480 12:56:48.152307 write(6, "\1\0\0\0\0\0\0\0", 8) = 8 <0.000007>
214480 12:56:48.152399 poll([{fd=6, events=POLLIN}, {fd=9, events=POLLIN}, {fd=10, events=POLLIN}, {fd=32, events=POLLIN}], 4, -1) = 1 ([{fd=6, revents=POLLIN}]) <0.000007>
214480 12:56:48.152429 read(6, "\2\0\0\0\0\0\0\0", 16) = 8 <0.000006>
214480 12:56:48.152513 poll([{fd=6, events=POLLIN}, {fd=9, events=POLLIN}, {fd=10, events=POLLIN}, {fd=32, events=POLLIN}], 4, -1
214501 12:56:47.857713 futex(0x74b80e86a540, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {tv_sec=1713610608, tv_nsec=483589589}, FUTEX_BITSET_MATCH_ANY
214480 12:56:46.685273 read(38, "\201\367\7\0\0\0\0\0U\263\r\0\0\0\0\0\4\0\4\0\31\0\7\0\201\367\7\0\0\0\0\0U\263\r\0\0\0\0\0\1\0/\0\0\0\0\0\201\367\7\0\0\0\0\0U\263\r\0\0\0\0\0\0\0\0\0\0\0\0\0", 6144) = 72 <0.000013>
214480 12:56:46.601298 read(38, "\201\367\7\0\0\0\0\0007k\f\0\0\0\0\0\4\0\4\0\31\0\7\0\201\367\7\0\0\0\0\0007k\f\0\0\0\0\0\1\0/\0\1\0\0\0\201\367\7\0\0\0\0\0007k\f\0\0\0\0\0\0\0\0\0\0\0\0\0", 6144) = 72 <0.000014>
214480 12:56:41.433236 read(38, "|\367\7\0\0\0\0\0\6\333\t\0\0\0\0\0\4\0\4\0(\0\7\0|\367\7\0\0\0\0\0\6\333\t\0\0\0\0\0\1\0\34\0\0\0\0\0|\367\7\0\0\0\0\0\6\333\t\0\0\0\0\0\0\0\0\0\0\0\0\0", 6144) = 72 <0.000012>
214480 12:56:47.538529 recvmsg(9, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="U\2O\16\276\326\36\37\3\20\0\0\20\0\0\0\0\0\0\20\20\20\20\20\0\0\3\0372\3\0\0", iov_len=4096}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 32 <0.000016>
214480 12:56:09.235552 read(38, "\\\367\7\0\0\0\0\0f\326\6\0\0\0\0\0\4\0\4\0\340\0\7\0\\\367\7\0\0\0\0\0f\326\6\0\0\0\0\0\1\0\35\0\1\0\0\0\\\367\7\0\0\0\0\0f\326\6\0\0\0\0\0\0\0\0\0\0\0\0\0", 6144) = 72 <0.000016>
EOF
}

if [[ -n "${VIMF6:-}" ]]; then
	echo "VIMF6 mode"
	_vimf6_data | sed -u -r -e "$(_sed)"
	echo EOF
else
	sed -u -r -e "$(_sed)" "$@"
fi

exit $?
