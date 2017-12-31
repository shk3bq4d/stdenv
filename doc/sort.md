cat testfile | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- # sort by line length
