https://wiki.archlinux.org/title/wpa_supplicant#Connecting_with_wpa_cli

wpa_supplicant -B  -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0 -Dnl80211,wext
wpa_supplicant -dd -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0 -Dnl80211,wext

Dec 26 20:57:30 pifour1.ly.lan dhcpcd-run-hooks[443]: wlan0: Successfully initialized wpa_supplicant#012Line 9: invalid number ""10""#012Line 9: failed to parse priority '"10"'.#012Line 10: failed to parse network block.#012Line 15: invalid number ""20""#012Line 15: failed to parse priority '"20"'.#012Line 16: failed to parse network block.#012Line 19: Invalid BSSID '"c0:aa:00:e8:5c:e7"'.#012Line 19: failed to parse bssid '"c0:aa:00:e8:5c:e7"'.#012Line 21: invalid number ""25""#012Line 21: failed to parse priority '"25"'.#012Line 22: failed to parse network block.#012Line 25: Invalid BSSID '"c0:aa:00:e8:5c:e8"'.#012Line 25: failed to parse bssid '"c0:aa:00:e8:5c:e8"'.#012Line 27: invalid number ""30""#012Line 27: failed to parse priority '"30"'.#012Line 28: failed to parse network block.#012Failed to read or parse configuration '/etc/wpa_supplicant/wpa_supplicant.conf'.
