#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

# maybe you should start with looking at strace-log-merge

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

vimf6_data() {
    cat << 'EOF'
10:15:16.078908 execve("/home/bip/bin/ansible-playbook", ["ansible-playbook", "bip.yml", "-D"], 0x7fff602bd400 /* 95 vars */) = 0 <0.000291>
10:15:16.082467 execve("/home/bip/bin/bash", ["bash", "/home/bip/bin/ansible-playbook", "bip.yml", "-D"], 0x7ffcaee203e8 /* 95 vars */) = -1 ENOENT (No such file or directory) <0.000080>
10:15:16.082609 execve("/home/bip/.local/bin/bash", ["bash", "/home/bip/bin/ansible-playbook", "bip.yml", "-D"], 0x7ffcaee203e8 /* 95 vars */) = -1 ENOENT (No such file or directory) <0.000072>
10:15:16.082741 execve("/usr/local/sbin/bash", ["bash", "/home/bip/bin/ansible-playbook", "bip.yml", "-D"], 0x7ffcaee203e8 /* 95 vars */) = -1 ENOENT (No such file or directory) <0.000067>
10:15:16.082866 execve("/usr/local/bin/bash", ["bash", "/home/bip/bin/ansible-playbook", "bip.yml", "-D"], 0x7ffcaee203e8 /* 95 vars */) = -1 ENOENT (No such file or directory) <0.000071>
10:15:16.082994 execve("/usr/sbin/bash", ["bash", "/home/bip/bin/ansible-playbook", "bip.yml", "-D"], 0x7ffcaee203e8 /* 95 vars */) = -1 ENOENT (No such file or directory) <0.000066>
10:15:16.083117 execve("/usr/bin/bash", ["bash", "/home/bip/bin/ansible-playbook", "bip.yml", "-D"], 0x7ffcaee203e8 /* 95 vars */) = 0 <0.000304>
10:15:16.241538 execve("/home/bip/.virtualenvs/ansible/bin/ansible-playbook", ["ansible-playbook", "--vault-id", "dev@salut/ansible-vault-dev", "--vault-id", "habon@salut/ansible-vault-habon", "bip.yml", "-D"], 0x55d407804750 /* 99 vars */) = 0 <0.000261>
10:15:16.080373 read(3, "\177ELF\2\1\1\3\0", 832) = 832 <0.000015>
10:15:16.080437 pread64(3, "\6\0\0\0\4\0\0", 784, 64) = 784 <0.000014>
10:15:16.080510 pread64(3, "\4\0\0\0 \0\0\", 48, 848) = 48 <0.000015>
10:15:16.080568 pread64(3, "\4\0\0\0\24\0\", 68, 896) = 68 <0.000014>
10:15:16.080622 newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=2216304, ...}, AT_EMPTY_PATH) = 0 <0.000017>
10:15:16.080688 pread64(3, "\6\0\0\0\4\0\0", 784, 64) = 784 <0.000015>
10:15:16.080754 mmap(NULL, 2260560, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f78d0400000 <0.000024>
10:15:16.080817 mmap(0x7f78d0428000, 1658880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x7f78d0428000 <0.000039>
10:15:17.431874 newfstatat(AT_FDCWD, "bip.yml", {st_mode=S_IFREG|0640, st_size=139, ...}, 0) = 0 <0.000018>
10:15:17.431959 newfstatat(AT_FDCWD, "bip.yml", {st_mode=S_IFREG|0640, st_size=139, ...}, 0) = 0 <0.000019>
10:15:22.350973 newfstatat(AT_FDCWD, "/home/bip/git/youpi/hehe/paac/ans/bip.yml", {st_mode=S_IFREG|0640, st_size=139, ...}, 0) = 0 <0.000013>
10:15:22.351028 openat(AT_FDCWD, "/home/bip/git/youpi/hehe/paac/ans/bip.yml", O_RDONLY|O_CLOEXEC) = 6 <0.000015>
EOF
}

test -t 1 && C="--color=always" || C=""

go() {

    cat "$@" |
        sort |
        grep $C -E '^.{1,20}? [a-z0-9]+\(([A-Z_]+, )?"[^"\\]+'
}

if [[ -n "${VIMF6:-}" ]]; then
    vimf6_data | go
else
    go "$@"
fi
