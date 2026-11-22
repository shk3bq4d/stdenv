timeout 300 yes >/dev/null # bash

apt install hey                              # rate limit load tester http 429 http curl
hey -n 100 -c 45 -q 1 https://$(hostname -f) # rate limit load tester http 429 http curl


sudo apt install stress-ng   # Debian/Ubuntu
apt install stress-ng -y
stress-ng --cpu 4 --timeout 60s
stress-ng --cpu 4 --cpu-load 70 --timeout 60s
stress-ng --oomable --bigheap 1
stress-ng --oomable --bigheap 1 --vm-keep --vm-bytes 8G --timeout 120s
stress-ng --oomable --bigheap 1 --bigheap-growth 4096 --vm-keep --vm-bytes 8G --timeout 120s
stress-ng --oomable --bigheap 1 --bigheap-growth 4096 --vm-keep --vm-bytes 256M --timeout 120s
stress-ng --bigheap 1 --bigheap-growth 4096 --bigheap-bytes 16M --oomable --no-oom-adjust --timeout 20s
stress-ng --bigheap 1 --bigheap-growth 4096 --bigheap-bytes 3100M --oomable --no-oom-adjust --timeout 20m
stress-ng --bigheap 1 --bigheap-growth 4096 --bigheap-bytes 3300M --oomable --no-oom-adjust --timeout 20m
stress-ng --fallocate 1 --fallocate-bytes 95% --timeout 20m # fill disk
