~/git/github/shk3bq4d/i3-gaps-builder/
* https://github.com/Airblader/i3 # i3-gaps
* https://github.com/i3/i3
* https://github.com/i3/i3/blob/next/RELEASE-NOTES-4.18.2

# installation
cd /tmp
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
dpkg -i ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
apt update
apt install i3

# https://i3wm.org/docs/userguide.html


file explorer: thunar

Mod+a select all

i3 '[id="94475176160464"] focus'
i3 '[id="127926281"] fullscreen'
i3 '[id="127926281"] floating enable'
i3 '[class="VirtualBox Machine"] floating disable'
i3 '[class="VirtualBox Machine"] fullscreen'
~/bin/mri3_get_window_criteria.sh


# i3 blocks install
#git clone git://github.com/vivien/i3blocks
git clone -b mr https://github.com/shk3bq4d/i3blocks.git
cd i3blocks
make clean debug # or make clean all
sudo make install

# i3 blocks
https://extendedreality.wordpress.com/2016/12/04/blocks-of-i3blocks-stuff-that-rocks/
i3 gaps outer all set 70

pkill -RTMIN+10 i3blocks
[mri3server]
command=$HOME/.config/i3/blocklet/mri3server-receiver.sh
color=#E5E5E5
interval=once
signal=10
markup=pango


xprop
xev # catches mouse and keyboard event
xwininfo

# links
* https://github.com/talwrii/i3-clever-layout
* https://github.com/cornerman/i3-easyfocus
* https://www.reddit.com/r/i3wm/comments/4twwi8/saving_and_restoring_layouts/
i3-save-tree --workspace  0 > ~/tmp/2x2.json
i3-msg "workspace 1; append_layout /home/michael/.i3/workspace-1.json"

i3-msg '[workspace="workspace_name"]' move workspace to output output_index # https://unix.stackexchange.com/questions/397269/i3wm-how-to-move-workspaces-between-monitors

# errors
less /run/user/1000/i3/errorlog.2489
vi -R $(ls -1t /run/user/$EUID/i3/errorlog.2489 | head -n1 )

# chromium full screen bug
https://www.reddit.com/r/i3wm/comments/edd5fx/fullscreen_mode_in_i3_automatically_set_firefox/
https://www.reddit.com/r/i3wm/comments/e9pgou/no_more_full_screen_video_panes_in_chromefirefox/
https://github.com/i3/i3/issues/2107

i3 move workspace to output DP-2   # apr16 bottom below
i3 move workspace to output HDMI-2 # apr16 top above
i3 rename workspace to '"0   $   "' # apr16 citrix workspace to correct screen

pip install i3ipc # python https://github.com/altdesktop/i3ipc-python

less /run/user/3000/i3/errorlog.4108
cd /run/user/$(id -u)/i3/

mod+q # sticky floating window, persistent accross all workspaces

# layout
* https://i3wm.org/docs/layout-saving.html
```sh
i3-save-tree --workspace '1   comm   ' > ~/.config/i3/i3-save-tree-workspace-comm.json
i3-msg "workspace 1; append_layout /home/michael/.i3/workspace-1.json"
i3-msg "append_layout ~/.config/i3/i3-save-tree-workspace-comm.json"
echo "'$(mri3_current_workspace.py)'" XC
```
