#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

tex() {
    cat << EOF
\documentclass{article}
\usepackage{qrcode}
\begin{document}

\newcommand{\myVariable}{$@}
\begin{center}
\qrcode[height=8cm]{\myVariable}
\vspace{2.1cm}
\newline
\myVariable
\end{center}

\end{document}
EOF
}

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" ]]  && [[ -d "$_tempdir" ]]  && rm -rf "$_tempdir"  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

_tex="$_tempdir/in.tex"
pdf="$_tempdir/out.pdf"
tex "$(cat -- "$@")" > "$_tex"
docker-mrlatex.sh "$_tex" "$pdf"

evince "$pdf" &
sleep 1
rm -f "$pdf"
cleanup
exit 0
