cat testfile | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- # sort by line length
sort -n # numeric doesn't work to well, use -V
sort -V # better for numeric and string    -V, --version-sort natural sort of (version) numbers within text
