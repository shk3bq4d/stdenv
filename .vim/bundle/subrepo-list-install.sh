#!/usr/bin/env bash

set -e
cd -P "$( dirname "${BASH_SOURCE[0]}" )"
cat subrepo-list.txt | while read dir url; do
	[[ -d "$dir" ]] && continue
	git clone $url "$dir"
	git submodule init && git submodule update || true
done
