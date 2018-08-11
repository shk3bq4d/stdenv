# How to hide the tab bar in Google Chrome
right-click on the omnibar and select "Edit Search Engines"
Add a new entry under "Other Search Engines" with the following fields:
Name: Hide tab bar
Keyword: ht
javascript:window.open(location.href, "detab", "toolbar=0"); window.close()

# search engines
make mr mr http://jlighttpd.ly.lan/websupport/search.py?q=%s the default
make mr mr http://127.0.0.1:63435/websupport/search.py?q=%s the default
rename the shortcut for the other ones, do not delete as they'll be readded when browing those sites

# extensions list
http://userscripts-mirror.org/scripts/source/78822.user.js # Better Outlook Web Access
ublock origin
cookie exporter
tampermonkey 
http://127.0.0.1:63435/websupport/tampermonkey/mr.js

chrome://extensions/
https://chrome.google.com/webstore/category/apps # use it from chromium

Shift + Esc # CPU Memory tab Chrome Task Manager

chrome://chrome-urls/
chrome://net-internals/proxyservice.config#proxy
chrome://net-internals/proxyservice.config
chrome://net-internals/proxyservice.init_log

chrome://net-internals/#dns
chrome://about
chrome://accessibility
chrome://appcache-internals
chrome://apps
chrome://blob-internals
chrome://bluetooth-internals
chrome://bookmarks
chrome://cache
chrome://chrome
chrome://chrome-urls
chrome://components
chrome://crashes
chrome://credits
chrome://device-log
chrome://devices
chrome://dino
chrome://dns
chrome://downloads
chrome://extensions
chrome://flags
chrome://flash
chrome://gcm-internals
chrome://gpu
chrome://help
chrome://histograms
chrome://history
chrome://indexeddb-internals
chrome://inspect
chrome://invalidations
chrome://linux-proxy-config
chrome://local-state
chrome://media-engagement
chrome://media-internals
chrome://net-export
chrome://net-internals
chrome://network-error
chrome://network-errors
chrome://newtab
chrome://ntp-tiles-internals
chrome://omnibox
chrome://password-manager-internals
chrome://settings/passwords?search=pass
chrome://policy
chrome://predictors
chrome://print
chrome://profiler
chrome://quota-internals
chrome://safe-browsing
chrome://sandbox
chrome://serviceworker-internals
chrome://settings
chrome://signin-internals
chrome://site-engagement
chrome://suggestions
chrome://supervised-user-internals
chrome://sync-internals
chrome://system
chrome://taskscheduler-internals
chrome://terms
chrome://thumbnails
chrome://tracing
chrome://translate-internals
chrome://usb-internals
chrome://user-actions
chrome://version
chrome://view-http-cache
chrome://webrtc-internals
chrome://webrtc-logs

notifications are configured in
chrome://settings/content

# view cookies
chrome://settings/cookies
chrome://settings/content/cookies # Update (2017-08-08) [verified in 59.0.3071.115 (Official Build) (64-bit)
chrome://settings/siteData # Update (2018-03-01) [Google Chrome 64.0.3282.167 (Official Build) (64-bit)] # view cookies

# Jquery Injection
@begin=javascript@
var jq = document.createElement('script');
jq.src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js";
document.getElementsByTagName('head')[0].appendChild(jq);
// ... give time for script to load, then type (or see below for non wait option)
jQuery.noConflict();
// or oneliner with the noConflict part
var script = document.createElement('script');script.src = "https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js";document.getElementsByTagName('head')[0].appendChild(script);
// now text extraction
a = []; $('h2').each(function(i,h){a.push($(h).text());}); a.join('\n')
a = []; $('h2').each(function(i,h){a.push(h.innerText);}); a.join('\n') // this excluded the subelements text
@end=javascript@

# delete all cookie bookmarklet
javascript:new function(){var c=document.cookie.split(";");for(var i=0;i<c.length;i++){var e=c[i].indexOf("=");var n=e>-1?c[i].substr(0,e):c[i];document.cookie=n+"=;expires=Thu, 01 Jan 1970 00:00:00 GMT";}}()
=======

# windows
In Internet Explorer 11, the WinINET team has disabled WinINET’s support for file:// based scripts to promote interoperability across network stacks. Corporations are advised to instead host their proxy configuration scripts on a HTTP or HTTPS server. As a temporary workaround, this block can be removed by setting the following registry key:
Key:   HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\
Value: EnableLegacyAutoProxyFeatures
Type:  REG_DWORD
Data:  1

Internet Options, Connections, LAN settings, Use automatic configuration script
file://C:\Users\myuser\cygwin64\home\myuser\proxy.corp.pac


http://classically.me/blogs/how-clear-hsts-settings-major-browsers
chrome://net-internals/#hsts

#ublock origin
chrome-extension://cjpalhdlnbpafiamejdnhcphjbkeiagm/dashboard.html#1p-filters.html

Ctrl-L # https://winaero.com/blog/how-to-enter-file-location-manually-in-gtk-3-opensave-dialog/

@begin=javascript@
var bA = document._getElementsByXPath("//input[@type='checkbox']"); for (var k = bA.length - 1; k >= 0; --k) {bA[k].checked = true;} // zabbix template import select all box
@end=javascript@

# notification
Notification.requestPermission().then(function(result) {console.log('bip');})
a = new Notification("Salut2")
a.close();
