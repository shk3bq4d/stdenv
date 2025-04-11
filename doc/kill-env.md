
# multiprocess kill
pgrep_mask="-f cis-ovh"; pstree -p $(pgrep $pgrep_mask | head -n 1 )
pgrep_mask="-f cis-ovh"; pstree -p $(pgrep $pgrep_mask | head -n 1 ) | grep -oP '\(\d+\)' | grep -oP '\d+'
pgrep_mask="-f cis-ovh"; pstree -p $(pgrep $pgrep_mask | head -n 1 ) | grep -oP '\(\d+\)' | grep -oP '\d+' | xargs -n 1 kill
