#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ DATA LABEL
## writes DATA in letters and as a QR code as well
## as LABEL in a temporary PDF file that is not kept on
## the filesystem. Ideal for offline secrets to be printed.
##
## Author: Jeff Malone, 29 Jan 2024
##


set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

tex() {
    local value comment
    value="$1"
    shift
    comment="$@"
    cat << EOF
\documentclass[
  a4paper
  ]{article}
\usepackage[a4paper]{geometry}
\usepackage[utf8]{inputenc}
\usepackage{qrcode}
\usepackage{seqsplit}
%\tolerance=1
%\emergencystretch=\maxdimen
%\hyphenpenalty=10000
%\hbadness=10000
\begin{document}

\newcommand{\myVariable}{$value}
\begin{center}
%\def\+{\discretionary{}{}{}}
\qrcode[height=8cm]{\myVariable}
\end{center}
%\begin{wrapfigure}{r}{0.1\textwidth}
\texttt{\seqsplit{\myVariable}}
%\seqsplit{\myVariable}
%\end{wrapfigure}
%\begin{wrapfigure}{r}{0.1\textwidth}
\vspace{1.3cm}
\newline
$comment
%\end{wrapfigure}

\end{document}
EOF
}

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" ]]  && [[ -d "$_tempdir" ]]  && rm -rf "$_tempdir"  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

_tex="$_tempdir/in.tex"
pdf="$_tempdir/out.pdf"
tex "$@" > "$_tex"
docker-mrlatex.sh "$_tex" "$pdf"

evince "$pdf" &
sleep 1
rm -f "$pdf"
cleanup
exit 0
