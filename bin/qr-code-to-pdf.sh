#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

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
