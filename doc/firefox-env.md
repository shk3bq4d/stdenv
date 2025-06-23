
https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml
https://mozilla.github.io/policy-templates/
https://support.mozilla.org/en-US/kb/customizing-firefox-using-policiesjson
wget https://addons.mozilla.org/firefox/downloads/file/4405733/tampermonkey-5.3.3.xpi

# keyboard shorcuts
<F6> shift between text entry

# ublock-origin
uBlock0@raymondhill.net:
https://addons.mozilla.org/en-US/firefox/addon/ublock-origin
https://github.com/gorhill/uBlock
https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin
https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin:-configuration

# tampermonkey
https://addons.mozilla.org/en-US/firefox/addon/tampermonkey/
https://github.com/Tampermonkey/tampermonkey

# vimium
https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/
https://github.com/philc/vimium

# 3rdparty Extensions Policy
storage.managed
chrome.storage.managed
ADMX file.
https://mozilla.github.io/policy-templates/#3rdparty
https://extensionworkshop.com/documentation/enterprise/enterprise-development/#how-to-add-policy
https://mozilla.github.io/policy-templates/#3rdparty

# force restart
either go to about:restartrequired
or go to about:profiles

about:processes , about:performance CPU Memory tab Firefox Task Manager (Shift + Esc (though it doesn't work))

* https://kb.mozillazine.org/About:config_entries


```sh
cp -p $(find ~/.mozilla/firefox* -maxdepth 2 -type f -name prefs.js | xargs ls -tr | tail -1) ~/tmp/$(date +%Y.%m.%d-%H.%M.%S)-firefex-prefs.js # export about:config
