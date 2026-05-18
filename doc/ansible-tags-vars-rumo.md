```sh
find -type f -name '*.yml'  | xargs yq -r '[.. | select(has("tags")) | .tags | explode(.)] | flatten | unique | sort'
find roles -type f -name '*.yml'  -ipath '*/tasks/*' | xargs yq -r '[.. | select(has("tags")) | .tags | explode(.)] | flatten | unique | sort' | grep -vxF '[]' | yq 'unique | sort'

desktop-become-local.sh dnsmasq
desktop-become-local.sh firefox_cfg
desktop-become-local.sh firefox_prefs
desktop-become-local.sh firefox_policies
desktop-become-local.sh edge,msedge
desktop-local.sh i3
desktop-local.sh sf
desktop-local.sh git-crypt
desktop-local.sh i3blocks
desktop-local.sh i3cfg
desktop-local.sh git_zsh # hide git status in prompt for oh-my-zsh git plugin
desktop-local.sh azcli
ap ansible-account-sudo-passwordless.yml -Dl HF # sudo


ap dockerhub-images.yml -e sfrx=dnsmasq
```

