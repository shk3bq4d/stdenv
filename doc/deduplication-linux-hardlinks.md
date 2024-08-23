deduplication

BEWARE OF FILE OWNERSHIPS

rdfind is compatible with link-dest
ts="$(date +'%Y.%m.%d-%H.%M.%S')"; rdfind -outputname result.$ts.txt -makehardlinks true -dryrun true $PWD |& tee rdfind.$ts.txt
ts="$(date +'%Y.%m.%d-%H.%M.%S')"; rdfind -outputname result.$ts.txt -makehardlinks true              $PWD |& tee rdfind.$ts.txt
rdfind -makehardlinks true /backup/bipbip/data/hardlinks/
rdfind -makehardlinks true /backup/bipbip/data/hardlinks/ /backup/sync-from-other/data/hardlinks
-n, -dryrun true|false


find $PWD -printf '%5n %p\n'  | tee filelist.txt

https://rmlint.readthedocs.io/en/latest/cautions.html
