# How to hide the tab bar in Google Chrome
right-click on the omnibar and select "Edit Search Engines"
Add a new entry under "Other Search Engines" with the following fields:
Name: Hide tab bar
Keyword: ht
javascript:window.open(location.href, "detab", "toolbar=0"); window.close()

# search engines
make mr mr http://jlighttpd.ly.lan/websupport/search.py?q=%s the default
make mr mr http://127.0.0.1:57155/search.py?q=%s the default
rename the shortcut for the other ones, do not delete as they'll be readded when browing those sites

Shift + Delete # https://superuser.com/questions/382437/how-can-i-remove-a-suggestion-from-the-chrome-address-bar

# tamper monkey script
* http://userscripts-mirror.org/scripts/source/78822.user.js # Better Outlook Web Access
* http://127.0.0.1:57155/tampermonkey/mr.js

# extensions list
* tampermonkey https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo
* https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb dbepggeogbaibhgnhhndojpepiihcmeb vimium
* git@github.com:shk3bq4d/X-Agent.git # mr user-agent useragent
  * ~/git/shk3bq4d/X-Agent
* https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm ublock origin
  http://127.0.0.1:57155/www/stdenv/adblock-ublock-origin.list
* https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg cookies.txt cookie exporter

https://chrome.google.com/extensions
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
======

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

# history
```sh
a=~/.config/chromium/Default/History; b=$(mktemp -u); cp $a $b; sqlite3 $b;
a=~/.config/chromium/Default/History; b=$(mktemp -u); cp $a $b; echo "select url from downloads_url_chains urls limit 13;" | sqlite3 $b;
```
```python
f = os.path.expanduser('~/.config/chromium/Default/History')
d = mrtools.ephemeral_dir()
nf = os.path.join(d, 'history')
shutil.copy(f, nf)
con = sqlite3.connect(nf)
cur = con.cursor()
q = "select url from downloads_url_chains urls where url like 'https://%' limit 13"
cur.execute(q)
for i in cur.fetchall():
    pprint(i)
```

# user agent
https://developers.whatismybrowser.com/useragents/explore/software_name/chrome/
User-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36
User-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36

# Okta 3rd party cookies 
https://support.okta.com/help/s/article/deprecation-of-3rd-party-cookies-in-google-chrome?language=en_US
## to try early
chrome://flags#third-party-cookie-deprecation-trial -> enabled
chrome://flags/#tracking-protection-3pcd -> enabled
chrome://flags/#tpcd-metadata-grants -> disabled

* https://chromium.googlesource.com/chromium/chromium/+/trunk/chrome/common/chrome_switches.cc # command line switches
* https://chromium.googlesource.com/chromium/chromium/+/trunk/base/base_switches.cc

# undocumented command line switches
taken from https://peter.sh/experiments/chromium-command-line-switches/
--/prefetch:1[1] ⊗	/prefetch:# arguments to use when launching various process types. It has been observed that when file reads are consistent for 3 process launches with the same /prefetch:# argument, the Windows prefetcher starts issuing reads in batch at process launch. Because reads depend on the process type, the prefetcher wouldn't be able to observe consistent reads if no /prefetch:# arguments were used. Note that the browser process has no /prefetch:# argument; as such all other processes must have one in order to avoid polluting its profile. Note: # must always be in [1, 8]; otherwise it is ignored by the Windows prefetcher. ↪
--/prefetch:2[1] ⊗	No description ↪
--/prefetch:3[1] ⊗	No description ↪
--/prefetch:4[1] ⊗	No description ↪
--/prefetch:5[1] ⊗	/prefetch:# arguments for the browser process launched in background mode and for the watcher process. Use profiles 5, 6 and 7 as documented on kPrefetchArgument* in content_switches.cc. ↪
--/prefetch:6[1] ⊗	No description ↪
--/prefetch:8[1] ⊗	Prefetch arguments are used by the Windows prefetcher to disambiguate different execution modes (i.e. process types) of the same executable image so that different types of processes don't trample each others' prefetch behavior. Legal values are integers in the range [1, 8]. We reserve 8 to mean "whatever", and this will ultimately lead to processes with /prefetch:8 having inconsistent behavior thus disabling prefetch in practice. TODO(rockot): Make it possible for embedders to override this argument on a per-service basis. ↪
--0 ⊗	Value of the --profiler-timing flag that will disable timing information for chrome://profiler. ↪
--? ⊗	No description ↪
--accept-resource-provider ⊗	Flag indicating that a resource provider must be set up to provide cast receiver with resources. Apps cannot start until provided resources. This flag implies --alsa-check-close-timeout=0. ↪
--account-consistency[2] ⊗	Command line flag for enabling account consistency. Default mode is disabled. Mirror is a legacy mode in which Google accounts are always addded to Chrome, and Chrome then adds them to the Google authentication cookies. Dice is a new experiment in which Chrome is aware of the accounts in the Google authentication cookies. ↪
--adaboost ⊗	No description ↪
--aec-refined-adaptive-filter ⊗	Enables a new tuning of the WebRTC Acoustic Echo Canceler (AEC). The new tuning aims at resolving two issues with the AEC: https://bugs.chromium.org/p/webrtc/issues/detail?id=5777 https://bugs.chromium.org/p/webrtc/issues/detail?id=5778 TODO(hlundin): Remove this switch when experimentation is over; crbug.com/603821. ↪
--agc-startup-min-volume ⊗	Override the default minimum starting volume of the Automatic Gain Control algorithm in WebRTC used with audio tracks from getUserMedia. The valid range is 12-255. Values outside that range will be clamped to the lowest or highest valid value inside WebRTC. TODO(tommi): Remove this switch when crbug.com/555577 is fixed. ↪
--aggressive ⊗	No description ↪
--aggressive-cache-discard ⊗	No description ↪
--aggressive-tab-discard ⊗	No description ↪
--all[3] ⊗	No description ↪
--allarticles ⊗	No description ↪
--allow-cross-origin-auth-prompt ⊗	Allows third-party content included on a page to prompt for a HTTP basic auth username/password pair. ↪
--allow-external-pages ⊗	Allow access to external pages during layout tests. ↪
--allow-failed-policy-fetch-for-test ⊗	If this flag is passed, failed policy fetches will not cause profile initialization to fail. This is useful for tests because it means that tests don't have to mock out the policy infrastructure. ↪
--allow-file-access-from-files ⊗	By default, file:// URIs cannot read other file:// URIs. This is an override for developers who need the old behavior for testing. ↪
--allow-hidden-media-playback ⊗	Allows media playback for hidden WebContents ↪
--allow-http-background-page ⊗	Allows non-https URL for background_page for hosted apps. ↪
--allow-http-screen-capture ⊗	Allow non-secure origins to use the screen capture API and the desktopCapture extension API. ↪
--allow-insecure-localhost ⊗	Enables TLS/SSL errors on localhost to be ignored (no interstitial, no blocking of requests). ↪
--allow-legacy-extension-manifests ⊗	Allows the browser to load extensions that lack a modern manifest when that would otherwise be forbidden. ↪
--allow-loopback-in-peer-connection ⊗	Allows loopback interface to be added in network list for peer connection. ↪
--allow-nacl-crxfs-api[4] ⊗	Specifies comma-separated list of extension ids or hosts to grant access to CRX file system APIs. ↪
--allow-nacl-file-handle-api[4] ⊗	Specifies comma-separated list of extension ids or hosts to grant access to file handle APIs. ↪
--allow-nacl-socket-api[4] ⊗	Specifies comma-separated list of extension ids or hosts to grant access to TCP/UDP socket APIs. ↪
--allow-no-sandbox-job ⊗	Enables the sandboxed processes to run without a job object assigned to them. This flag is required to allow Chrome to run in RemoteApps or Citrix. This flag can reduce the security of the sandboxed processes and allow them to do certain API calls like shut down Windows or access the clipboard. Also we lose the chance to kill some processes until the outer job that owns them finishes. ↪
--allow-outdated-plugins ⊗	Don't block outdated plugins. ↪
--allow-ra-in-dev-mode ⊗	Allows remote attestation (RA) in dev mode for testing purpose. Usually RA is disabled in dev mode because it will always fail. However, there are cases in testing where we do want to go through the permission flow even in dev mode. This can be enabled by this flag. ↪
--allow-running-insecure-content ⊗	By default, an https page cannot run JavaScript, CSS or plugins from http URLs. This provides an override to get the old insecure behavior. ↪
--allow-sandbox-debugging ⊗	Allows debugging of sandboxed processes (see zygote_main_linux.cc). ↪
--allow-silent-push ⊗	Allows Web Push notifications that do not show a notification. ↪
--alsa-check-close-timeout ⊗	Time in ms to wait before closing the PCM handle when no more mixer inputs remain. Assumed to be 0 if --accept-resource-provider is present. ↪
--alsa-enable-upsampling ⊗	Flag that enables resampling audio with sample rate below 32kHz up to 48kHz. Should be set to true for internal audio products. ↪
--alsa-fixed-output-sample-rate ⊗	Optional flag to set a fixed sample rate for the alsa device. ↪
--alsa-input-device[5] ⊗	The Alsa device to use when opening an audio input stream. ↪
--alsa-mute-device-name ⊗	Name of the device the mute mixer should be opened on. If this flag is not specified it will default to the same device as kAlsaVolumeDeviceName. ↪
--alsa-mute-element-name ⊗	Name of the simple mixer control element that the ALSA-based media library should use to mute the system. ↪
--alsa-output-avail-min ⊗	Minimum number of available frames for scheduling a transfer. ↪
--alsa-output-buffer-size ⊗	Size of the ALSA output buffer in frames. This directly sets the latency of the output device. Latency can be calculated by multiplying the sample rate by the output buffer size. ↪
--alsa-output-device[5] ⊗	The Alsa device to use when opening an audio stream. ↪
--alsa-output-period-size ⊗	Size of the ALSA output period in frames. The period of an ALSA output device determines how many frames elapse between hardware interrupts. ↪
--alsa-output-start-threshold ⊗	How many frames need to be in the output buffer before output starts. ↪
--alsa-volume-device-name ⊗	Name of the device the volume control mixer should be opened on. Will use the same device as kAlsaOutputDevice and fall back to "default" if kAlsaOutputDevice is not supplied. ↪
--alsa-volume-element-name ⊗	Name of the simple mixer control element that the ALSA-based media library should use to control the volume. ↪
--also-emit-success-logs ⊗	Also emit full event trace logs for successful tests. ↪
--alternative ⊗	The Chrome-Proxy "exp" directive value used by data reduction proxy to receive an alternative back end implementation. ↪
--always-authorize-plugins ⊗	Prevents Chrome from requiring authorization to run certain widely installed but less commonly used plugins. ↪
--always-on ⊗	No description ↪
--always-use-complex-text ⊗	Always use the complex text path for layout tests. ↪
--alwaystrue ⊗	No description ↪
--android-fonts-path ⊗	Uses the android SkFontManager on linux. The specified directory should include the configuration xml file with the name "fonts.xml". This is used in blimp to emulate android fonts on linux. ↪
--android-stderr-port[6] ⊗	Redirect stderr to the given port. Only supported on Android. ↪
--android-stdin-port[6] ⊗	Redirect stdin to the given port. Only supported on Android. ↪
--android-stdout-port[6] ⊗	Redirect stdout to the given port. Only supported on Android. ↪
--angle ⊗	No description ↪
--app ⊗	Specifies that the associated value should be launched in "application" mode. ↪
--app-auto-launched ⊗	Specifies whether an app launched in kiosk mode was auto launched with zero delay. Used in order to properly restore auto-launched state during session restore flow. ↪
--app-id ⊗	Specifies that the extension-app with the specified id should be launched according to its configuration. ↪
--app-mode-auth-code ⊗	Value of GAIA auth code for --force-app-mode. ↪
--app-mode-oauth-token ⊗	Value of OAuth2 refresh token for --force-app-mode. ↪
--app-mode-oem-manifest ⊗	Path for app's OEM manifest file. ↪
--app-shell-allow-roaming ⊗	Allow roaming in the cellular network. ↪
--app-shell-host-window-size ⊗	Size for the host window to create (i.e. "800x600"). ↪
--app-shell-preferred-network ⊗	SSID of the preferred WiFi network. ↪
--app-shell-refresh-token ⊗	Refresh token for identity API calls for the current user. Used for testing. ↪
--app-shell-user ⊗	User email address of the current user. ↪
--apple ⊗	No description ↪
--apps-gallery-download-url ⊗	The URL that the webstore APIs download extensions from. Note: the URL must contain one '%s' for the extension ID. ↪
--apps-gallery-update-url ⊗	The update url used by gallery/webstore extensions. ↪
--apps-gallery-url ⊗	The URL to use for the gallery link in the app launcher. ↪
--apps-keep-chrome-alive-in-tests[7] ⊗	Prevents Chrome from quitting when Chrome Apps are open. ↪
--arc-availability ⊗	Signals ARC support status on this device. This can take one of the following three values. - none: ARC is not installed on this device. (default) - installed: ARC is installed on this device, but not officially supported. Users can enable ARC only when Finch experiment is turned on. - officially-supported: ARC is installed and supported on this device. So users can enable ARC via settings etc. ↪
--arc-available ⊗	DEPRECATED: Please use --arc-availability=installed. Signals the availability of the ARC instance on this device. ↪
--arc-start-mode ⊗	Defines how to start ARC. This can take one of the following values: - always-start automatically start with Play Store UI support. - always-start-with-no-play-store automatically start without Play Store UI. In both cases ARC starts after login screen in almost all cases. Secondary profile is an exception where ARC won't start. If it is not set, then ARC is started in default mode. ↪
--artifacts-dir ⊗	Screenshot testing: specifies the directoru where artifacts will be stored. ↪
--ash-animate-from-boot-splash-screen ⊗	Enables an animated transition from the boot splash screen (Chrome logo on a white background) to the login screen. Implies |kAshCopyHostBackgroundAtBoot| and doesn't make much sense if used in conjunction with |kDisableBootAnimation| (since the transition begins at the same time as the white/grayscale login screen animation). ↪
--ash-copy-host-background-at-boot ⊗	Copies the host window's content to the system background layer at startup. Can make boot slightly slower, but also hides an even-longer awkward period where we display a white background if the login wallpaper takes a long time to load. ↪
--ash-debug-shortcuts ⊗	Enable keyboard shortcuts useful for debugging. ↪
--ash-dev-shortcuts ⊗	Enable keyboard shortcuts used by developers only. ↪
--ash-disable-smooth-screen-rotation ⊗	Disables a smoother animation for screen rotation. ↪
--ash-disable-touch-exploration-mode ⊗	Disable the Touch Exploration Mode. Touch Exploration Mode will no longer be turned on automatically when spoken feedback is enabled when this flag is set. ↪
--ash-enable-magnifier-key-scroller ⊗	Enables key bindings to scroll magnified screen. ↪
--ash-enable-mirrored-screen ⊗	Enables mirrored screen. ↪
--ash-enable-night-light ⊗	Enable the Night Light feature. ↪
--ash-enable-palette-on-all-displays ⊗	Enables the palette on every display, instead of only the internal one. ↪
--ash-enable-scale-settings-tray ⊗	Enables display scale tray settings. This uses force-device-scale-factor flag to modify the dsf of the device to any non discrete value. ↪
--ash-enable-software-mirroring ⊗	Enables software based mirroring. ↪
--ash-enable-unified-desktop[8] ⊗	Enables unified desktop mode. ↪
--ash-estimated-presentation-delay ⊗	Specifies the estimated time (in milliseconds) from VSYNC event until when visible light can be noticed by the user. ↪
--ash-hide-notifications-for-factory ⊗	Hides notifications that are irrelevant to Chrome OS device factory testing, such as battery level updates. ↪
--ash-host-window-bounds ⊗	Sets a window size, optional position, and optional scale factor. "1024x768" creates a window of size 1024x768. "100+200-1024x768" positions the window at 100,200. "1024x768*2" sets the scale factor to 2 for a high DPI display. "800,0+800-800x800" for two displays at 800x800 resolution. "800,0+800-800x800,0+1600-800x800" for three displays at 800x800 resolution. ↪
--ash-shelf-color ⊗	Enables the shelf color to be derived from the wallpaper. ↪
--ash-shelf-color-scheme ⊗	The color scheme to be used when the |kAshShelfColor| feature is enabled. ↪
--ash-touch-hud ⊗	Enables the heads-up display for tracking touch points. ↪
--ash-webui-init ⊗	When wallpaper boot animation is not disabled this switch is used to override OOBE/sign in WebUI init type. Possible values: parallel|postpone. Default: parallel. ↪
--attestation-server ⊗	Determines which Google Privacy CA to use for attestation. ↪
--audio-buffer-size ⊗	Allow users to specify a custom buffer size for debugging purpose. ↪
--audio-output-channels ⊗	Number of audio output channels. This will be used to send audio buffer with specific number of channels to ALSA and generate loopback audio. Default value is 2. ↪
--aura-legacy-power-button ⊗	(Most) Chrome OS hardware reports ACPI power button releases correctly. Standard hardware reports releases immediately after presses. If set, we lock the screen or shutdown the system immediately in response to a press instead of displaying an interactive animation. ↪
--auth-ext-path ⊗	Enables overriding the path for the default authentication extension. ↪
--auth-server-whitelist ⊗	Whitelist for Negotiate Auth servers ↪
--auth-spnego-account-type[6] ⊗	Android authentication account type for SPNEGO authentication ↪
--auto ⊗	The values the kTouchEventFeatureDetection switch may have, as in --touch-events=disabled. auto: enabled at startup when an attached touchscreen is present. ↪
--auto-open-devtools-for-tabs ⊗	This flag makes Chrome auto-open DevTools window for each tab. It is intended to be used by developers and automation to not require user interaction for opening DevTools. ↪
--auto-select-desktop-capture-source ⊗	This flag makes Chrome auto-select the provided choice when an extension asks permission to start desktop capture. Should only be used for tests. For instance, --auto-select-desktop-capture-source="Entire screen" will automatically select to share the entire screen in English locales. ↪
--autoplay-policy ⊗	Command line flag name to set the autoplay policy. ↪
--blink-settings ⊗	Set blink settings. Format is <name>[=<value],<name>[=<value>],... The names are declared in Settings.json5. For boolean type, use "true", "false", or omit '=<value>' part to set to true. For enum type, use the int value of the enum value. Applied after other command line flags and prefs. ↪
--bootstrap ⊗	Values for the kExtensionContentVerification flag. See ContentVerifierDelegate::Mode for more explanation. ↪
--browser[3] ⊗	No description ↪
--browser-startup-dialog ⊗	Causes the browser process to display a dialog on launch. ↪
--browser-subprocess-path ⊗	Path to the exe to run for the renderer and plugin subprocesses. ↪
--browser-test ⊗	Tells Content Shell that it's running as a content_browsertest. ↪
--bwsi ⊗	Indicates that the browser is in "browse without sign-in" (Guest session) mode. Should completely disable extensions, sync and bookmarks. ↪
--bypass-app-banner-engagement-checks ⊗	This flag causes the user engagement checks for showing app banners to be bypassed. It is intended to be used by developers who wish to test that their sites otherwise meet the criteria needed to show app banners. ↪
--canvas-msaa-sample-count ⊗	The number of MSAA samples for canvas2D. Requires MSAA support by GPU to have an effect. 0 disables MSAA. ↪
--cast-initial-screen-height ⊗	No description ↪
--cast-initial-screen-width ⊗	Used to pass initial screen resolution to GPU process. This allows us to set screen size correctly (so no need to resize when first window is created). ↪
--cc-layer-tree-test-long-timeout ⊗	Increases timeout for memory checkers. ↪
--cc-layer-tree-test-no-timeout ⊗	Prevents the layer tree unit tests from timing out. ↪
--cc-rebaseline-pixeltests ⊗	Makes pixel tests write their output instead of read it. ↪
--cellular-first ⊗	If this flag is set, it indicates that this device is a "Cellular First" device. Cellular First devices use cellular telephone data networks as their primary means of connecting to the internet. Setting this flag has two consequences: 1. Cellular data roaming will be enabled by default. 2. UpdateEngine will be instructed to allow auto-updating over cellular data connections. ↪
--cellular-only ⊗	No description ↪
--check-for-update-interval ⊗	How often (in seconds) to check for updates. Should only be used for testing purposes. ↪
--check-layout-test-sys-deps ⊗	Check whether all system dependencies for running layout tests are met. ↪
--child-wallpaper-large ⊗	Default large wallpaper to use for kids accounts (as path to trusted, non-user-writable JPEG file). ↪
--child-wallpaper-small ⊗	Default small wallpaper to use for kids accounts (as path to trusted, non-user-writable JPEG file). ↪
--chrome-home-swipe-logic[6] ⊗	Android authentication account type for SPNEGO authentication ↪
--ChromeOSMemoryPressureHandling ⊗	The memory pressure thresholds selection which is used to decide whether and when a memory pressure event needs to get fired. ↪
--cipher-suite-blacklist ⊗	Comma-separated list of SSL cipher suites to disable. ↪
--clamshell ⊗	No description ↪
--class[9] ⊗	The same as the --class argument in X applications. Overrides the WM_CLASS window property with the given value. ↪
--clear-token-service ⊗	Clears the token service before using it. This allows simulating the expiration of credentials during testing. ↪
--cloud-print-file ⊗	Tells chrome to display the cloud print dialog and upload the specified file for printing. ↪
--cloud-print-file-type ⊗	Specifies the mime type to be used when uploading data from the file referenced by cloud-print-file. Defaults to "application/pdf" if unspecified. ↪
--cloud-print-job-title ⊗	Used with kCloudPrintFile to specify a title for the resulting print job. ↪
--cloud-print-print-ticket ⊗	Used with kCloudPrintFile to specify a JSON print ticket for the resulting print job. Defaults to null if unspecified. ↪
--cloud-print-setup-proxy ⊗	Setup cloud print proxy for provided printers. This does not start service or register proxy for autostart. ↪
--cloud-print-url ⊗	The URL of the cloud print service to use, overrides any value stored in preferences, and the default. Only used if the cloud print service has been enabled. Used for testing. ↪
--cloud-print-xmpp-endpoint ⊗	The XMPP endpoint the cloud print service will use. Only used if the cloud print service has been enabled. Used for testing. ↪
--compensate-for-unstable-pinch-zoom ⊗	Enable compensation for unstable pinch zoom. Some touch screens display significant amount of wobble when moving a finger in a straight line. This makes two finger scroll trigger an oscillating pinch zoom. See crbug.com/394380 for details. ↪
--compile-shader-always-succeeds ⊗	Always return success when compiling a shader. Linking will still fail. ↪
--component-updater ⊗	Comma-separated options to troubleshoot the component updater. Only valid for the browser process. ↪
--connectivity-check-url ⊗	Url for network connectivity checking. Default is "https://clients3.google.com/generate_204". ↪
--conservative ⊗	No description ↪
--content-image-texture-target ⊗	Texture target for CHROMIUM_image backed content textures. ↪
--content-shell-host-window-size ⊗	Size for the content_shell's host window (i.e. "800x600"). ↪
--controller ⊗	No description ↪
--crash-dumps-dir ⊗	The directory breakpad should store minidumps in. ↪
--crash-on-failure ⊗	When specified to "enable-leak-detection" command-line option, causes the leak detector to cause immediate crash when found leak. ↪
--crash-on-hang-threads ⊗	Comma-separated list of BrowserThreads that cause browser process to crash if the given browser thread is not responsive. UI,IO,DB,FILE,CACHE are the list of BrowserThreads that are supported. For example: --crash-on-hang-threads=UI:3:18,IO:3:18 --> Crash the browser if UI or IO is not responsive for 18 seconds and the number of browser threads that are responding is less than or equal to 3. ↪
--crash-server-url ⊗	Server url to upload crash data to. Default is "http://clients2.google.com/cr/report" for prod devices. Default is "http://clients2.google.com/cr/staging_report" for non prod. ↪
--crash-test ⊗	Causes the browser process to crash on startup. ↪
--crashpad-handler ⊗	A process type (switches::kProcessType) that indicates chrome.exe or setup.exe is being launched as crashpad_handler. This is only used on Windows. We bundle the handler into chrome.exe on Windows because there is high probability of a "new" .exe being blocked or interfered with by application firewalls, AV software, etc. On other platforms, crashpad_handler is a standalone executable. ↪
--create-browser-on-startup-for-tests ⊗	Some platforms like ChromeOS default to empty desktop. Browser tests may need to add this switch so that at least one browser instance is created on startup. TODO(nkostylev): Investigate if this switch could be removed. (http://crbug.com/148675) ↪
--create-default-gl-context ⊗	Ask the GLX driver for the default context instead of trying to get the highest version possible. ↪
--cros-gaia-api-v1 ⊗	Forces use of Chrome OS Gaia API v1. ↪
--cros-region ⊗	Forces CrOS region value. ↪
--cros-regions-mode ⊗	Control regions data load ("" is default). ↪
--crosh-command[8] ⊗	Custom crosh command. ↪
--cryptauth-http-host ⊗	Overrides the default URL for Google APIs (https://www.googleapis.com) used by CryptAuth. ↪
--custom-devtools-frontend ⊗	Specify a custom path to devtools for devtools tests ↪
--custom-launcher-page ⊗	Specifies the chrome-extension:// URL for the contents of an additional page added to the app launcher. ↪
--custom_summary[6] ⊗	Forces a custom summary to be displayed below the update menu item. ↪
--d3d-support[1] ⊗	No description ↪
--d3d11 ⊗	No description ↪
--d3d9 ⊗	No description ↪
--daemon ⊗	No description ↪
--dark_muted ⊗	No description ↪
--dark_vibrant ⊗	No description ↪
--data-path ⊗	Makes Content Shell use the given path for its data directory. ↪
--data-reduction-proxy-config-url ⊗	The URL from which to retrieve the Data Reduction Proxy configuration. ↪
--data-reduction-proxy-experiment ⊗	The name of a Data Reduction Proxy experiment to run. These experiments are defined by the proxy server. Use --force-fieldtrials for Data Reduction Proxy field trials. ↪
--data-reduction-proxy-http-proxies ⊗	The semicolon-separated list of proxy server URIs to override the list of HTTP proxies returned by the Data Saver API. It is illegal to use |kDataReductionProxy| or |kDataReductionProxyFallback| switch in conjunction with |kDataReductionProxyHttpProxies|. If the URI omits a scheme, then the proxy server scheme defaults to HTTP, and if the port is omitted then the default port for that scheme is used. E.g. "http://foo.net:80", "http://foo.net", "foo.net:80", and "foo.net" are all equivalent. ↪
--data-reduction-proxy-lo-fi ⊗	The mode for Data Reduction Proxy Lo-Fi. The various modes are always-on, cellular-only, slow connections only and disabled. ↪
--data-reduction-proxy-pingback-url ⊗	No description ↪
--data-reduction-proxy-secure-proxy-check-url ⊗	Sets a secure proxy check URL to test before committing to using the Data Reduction Proxy. Note this check does not go through the Data Reduction Proxy. ↪
--data-reduction-proxy-server-experiments-disabled ⊗	Disables server experiments that may be enabled through field trial. ↪
--dbus-stub ⊗	Forces the stub implementation of dbus clients. ↪
--debug-devtools ⊗	Run devtools tests in debug mode (not bundled and minified) ↪
--debug-enable-frame-toggle ⊗	Enables a frame context menu item that toggles the frame in and out of glass mode (Windows Vista and up only). ↪
--debug-packed-apps ⊗	Adds debugging entries such as Inspect Element to context menus of packed apps. ↪
--debug-print[10] ⊗	Enables support to debug printing subsystem. ↪
--default ⊗	No description ↪
--default-background-color ⊗	The background color to be used if the page doesn't specify one. Provided as RGBA integer value in hex, e.g. 'ff0000ff' for red or '00000000' for transparent. ↪
--default-tile-height ⊗	No description ↪
--default-tile-width ⊗	Sets the tile size used by composited layers. ↪
--default-wallpaper-is-oem ⊗	Indicates that the wallpaper images specified by kAshDefaultWallpaper{Large,Small} are OEM-specific (i.e. they are not downloadable from Google). ↪
--default-wallpaper-large ⊗	Default large wallpaper to use (as path to trusted, non-user-writable JPEG file). ↪
--default-wallpaper-small ⊗	Default small wallpaper to use (as path to trusted, non-user-writable JPEG file). ↪
--demo ⊗	Optional value for Data Saver prompt on cellular networks. ↪
--derelict-detection-timeout ⊗	Time in seconds before a machine at OOBE is considered derelict. ↪
--derelict-idle-timeout ⊗	Time in seconds before a derelict machines starts demo mode. ↪
--desktop ⊗	No description ↪
--desktop-window-1080p ⊗	When present, desktop cast_shell will create 1080p window (provided display resolution is high enough). Otherwise, cast_shell defaults to 720p. ↪
--deterministic-fetch ⊗	Instructs headless_shell to cause network fetches to complete in order of creation. This removes a significant source of network related non-determinism at the cost of slower page loads. ↪
--device-management-url ⊗	Specifies the URL at which to fetch configuration policy from the device management backend. ↪
--device-scale-factor[1] ⊗	Device scale factor passed to certain processes like renderers, etc. ↪
--devtools-flags ⊗	Passes command line parameters to the DevTools front-end. ↪
--diagnostics ⊗	Triggers a plethora of diagnostic modes. ↪
--diagnostics-format ⊗	Sets the output format for diagnostic modes enabled by diagnostics flag. ↪
--diagnostics-recovery ⊗	Tells the diagnostics mode to do the requested recovery step(s). ↪
--dice[2] ⊗	No description ↪
--dice_fix_auth_errors ⊗	No description ↪
--disable ⊗	Values for the kShowSavedCopy flag. ↪
--disable-2d-canvas-clip-aa ⊗	Disable antialiasing on 2d canvas clips ↪
--disable-2d-canvas-image-chromium ⊗	Disables Canvas2D rendering into a scanout buffer for overlay support. ↪
--disable-3d-apis ⊗	Disables client-visible 3D APIs, in particular WebGL and Pepper 3D. This is controlled by policy and is kept separate from the other enable/disable switches to avoid accidentally regressing the policy support for controlling access to these APIs. ↪
--disable-accelerated-2d-canvas ⊗	Disable gpu-accelerated 2d canvas. ↪
--disable-accelerated-jpeg-decoding ⊗	Disable partially decoding jpeg images using the GPU. At least YUV decoding will be accelerated when not using this flag. Has no effect unless GPU rasterization is enabled. ↪
--disable-accelerated-mjpeg-decode ⊗	Disable hardware acceleration of mjpeg decode for captured frame, where available. ↪
--disable-accelerated-video-decode ⊗	Disables hardware acceleration of video decode, where available. ↪
--disable-app-info-dialog-mac[7] ⊗	Disable the toolkit-views App Info dialog for Mac. ↪
--disable-app-list-dismiss-on-blur ⊗	If set, the app list will not be dismissed when it loses focus. This is useful when testing the app list or a custom launcher page. It can still be dismissed via the other methods (like the Esc key). ↪
--disable-app-window-cycling[7] ⊗	Disables custom Cmd+` window cycling for platform apps and hosted apps. ↪
--disable-appcontainer ⊗	No description ↪
--disable-arc-data-wipe ⊗	Disables android user data wipe on opt out. ↪
--disable-arc-opt-in-verification ⊗	Disables ARC Opt-in verification process and ARC is enabled by default. ↪
--disable-audio-support-for-desktop-share ⊗	No description ↪
--disable-avfoundation-overlays[11] ⊗	Disable use of AVFoundation to draw video content. ↪
--disable-background-networking ⊗	Disable several subsystems which run network requests in the background. This is for use when doing network performance testing to avoid noise in the measurements. ↪
--disable-background-timer-throttling ⊗	Disable task throttling of timer tasks from background pages. ↪
--disable-backing-store-limit ⊗	Disable limits on the number of backing stores. Can prevent blinking for users with many windows/tabs and lots of memory. ↪
--disable-blink-features ⊗	Disable one or more Blink runtime-enabled features. Use names from RuntimeEnabledFeatures.json5, separated by commas. Applied after kEnableBlinkFeatures, and after other flags that change these features. ↪
--disable-bookmark-reordering ⊗	Disables bookmark reordering. ↪
--disable-boot-animation ⊗	Disables wallpaper boot animation (except of OOBE case). ↪
--disable-breakpad ⊗	Disables the crash reporting. ↪
--disable-browser-task-scheduler ⊗	No description ↪
--disable-bundled-ppapi-flash ⊗	Disables the bundled PPAPI version of Flash. ↪
--disable-canvas-aa ⊗	Disable antialiasing on 2d canvas. ↪
--disable-captive-portal-bypass-proxy ⊗	Disables bypass proxy for captive portal authorization. ↪
--disable-cast-streaming-hw-encoding ⊗	Disables hardware encoding support for Cast Streaming. ↪
--disable-checker-imaging ⊗	Disabled defering image decodes to the image decode service. ↪
--disable-clear-browsing-data-counters ⊗	Disables data volume counters in the Clear Browsing Data dialog. ↪
--disable-client-side-phishing-detection ⊗	Disables the client-side phishing detection feature. Note that even if client-side phishing detection is enabled, it will only be active if the user has opted in to UMA stats and SafeBrowsing is enabled in the preferences. ↪
--disable-cloud-import ⊗	Disables cloud backup feature. ↪
--disable-component-cloud-policy ⊗	Disables fetching and storing cloud policy for components. ↪
--disable-component-extensions-with-background-pages ⊗	Disable default component extensions with background pages - useful for performance tests where these pages may interfere with perf results. ↪
--disable-component-update ⊗	No description ↪
--disable-composited-antialiasing ⊗	Disables layer-edge anti-aliasing in the compositor. ↪
--disable-contextual-search ⊗	Disables Contextual Search. ↪
--disable-d3d11 ⊗	Disables use of D3D11. ↪
--disable-databases ⊗	Disables HTML5 DB support. ↪
--disable-datasaver-prompt ⊗	Disables Data Saver prompt on cellular networks. ↪
--disable-default-apps ⊗	Disables installation of default apps on first run. This is used during automated testing. ↪
--disable-demo-mode ⊗	Disables the Chrome OS demo. ↪
--disable-device-disabling ⊗	If this switch is set, the device cannot be remotely disabled by its owner. ↪
--disable-device-discovery-notifications ⊗	Disables device discovery notifications. ↪
--disable-dinosaur-easter-egg ⊗	Disables the dinosaur easter egg on the offline interstitial. ↪
--disable-direct-composition ⊗	Disables the use of DirectComposition to draw to the screen. ↪
--disable-direct-composition-layers ⊗	Disables using DirectComposition layers. ↪
--disable-directwrite-for-ui[1] ⊗	Disables DirectWrite font rendering for general UI elements. ↪
--disable-display-color-calibration[8] ⊗	No description ↪
--disable-display-list-2d-canvas ⊗	No description ↪
--disable-distance-field-text ⊗	Disables distance field text. ↪
--disable-domain-blocking-for-3d-apis ⊗	Disable the per-domain blocking for 3D APIs after GPU reset. This switch is intended only for tests. ↪
--disable-domain-reliability ⊗	Disables Domain Reliability Monitoring. ↪
--disable-drive-search-in-app-launcher ⊗	No description ↪
--disable-dwm-composition ⊗	Disables use of DWM composition for top level windows. ↪
--disable-encryption-migration ⊗	Disable encryption migration for user's cryptohome to run latest Arc. ↪
--disable-eol-notification ⊗	Disables notification when device is in end of life status. ↪
--disable-es3-apis ⊗	Disable OpenGL ES 3 APIs. This in turn will disable WebGL2. ↪
--disable-es3-gl-context ⊗	Disables use of ES3 backend (use ES2 backend instead). ↪
--disable-extensions ⊗	Disable extensions. ↪
--disable-extensions-except ⊗	Disable extensions except those specified in a comma-separated list. ↪
--disable-extensions-file-access-check ⊗	Disable checking for user opt-in for extensions that want to inject script into file URLs (ie, always allow it). This is used during automated testing. ↪
--disable-extensions-http-throttling ⊗	Disable the net::URLRequestThrottlerManager functionality for requests originating from extensions. ↪
--disable-features ⊗	Lists separated by commas the name of features to disable. See base::FeatureList::InitializeFromCommandLine for details. ↪
--disable-field-trial-config ⊗	Disable field trial tests configured in fieldtrial_testing_config.json. ↪
--disable-file-manager-touch-mode ⊗	Touchscreen-specific interactions of the Files app. ↪
--disable-file-system ⊗	Disable FileSystem API. ↪
--disable-flash-3d ⊗	Disable 3D inside of flapper. ↪
--disable-flash-stage3d ⊗	Disable Stage3D inside of flapper. ↪
--disable-fullscreen-low-power-mode[7] ⊗	Disables fullscreen low power mode on Mac. ↪
--disable-fullscreen-tab-detaching[7] ⊗	Disables tab detaching in fullscreen mode on Mac. ↪
--disable-gaia-services ⊗	Disables GAIA services such as enrollment and OAuth session restore. Used by 'fake' telemetry login. ↪
--disable-gesture-editing ⊗	No description ↪
--disable-gesture-requirement-for-presentation ⊗	Disable user gesture requirement for presentation. ↪
--disable-gesture-typing ⊗	No description ↪
--disable-gl-drawing-for-tests ⊗	Disables GL drawing operations which produce pixel output. With this the GL output will not be correct but tests will run faster. ↪
--disable-gl-error-limit ⊗	Disable the GL error log limit. ↪
--disable-gl-extensions ⊗	Disables specified comma separated GL Extensions if found. ↪
--disable-glsl-translator ⊗	Disable the GLSL translator. ↪
--disable-gpu ⊗	Disables GPU hardware acceleration. If software renderer is not in place, then the GPU process won't launch. ↪
--disable-gpu-compositing ⊗	Prevent the compositor from using its GPU implementation. ↪
--disable-gpu-driver-bug-workarounds ⊗	Disable workarounds for various GPU driver bugs. ↪
--disable-gpu-early-init ⊗	Disable proactive early init of GPU process. ↪
--disable-gpu-memory-buffer-compositor-resources ⊗	Do not force that all compositor resources be backed by GPU memory buffers. ↪
--disable-gpu-memory-buffer-video-frames ⊗	Disable GpuMemoryBuffer backed VideoFrames. ↪
--disable-gpu-process-crash-limit ⊗	Disable the limit on the number of times the GPU process may be restarted. For tests and platforms where software fallback is disabled. ↪
--disable-gpu-program-cache ⊗	Turn off gpu program caching ↪
--disable-gpu-rasterization ⊗	Disable GPU rasterization, i.e. rasterize on the CPU only. Overrides the kEnableGpuRasterization and kForceGpuRasterization flags. ↪
--disable-gpu-sandbox ⊗	Disable the GPU process sandbox. ↪
--disable-gpu-shader-disk-cache ⊗	Disables the GPU shader on disk cache. ↪
--disable-gpu-vsync ⊗	Stop the GPU from synchronizing on the vsync before presenting. We can select from the options below: beginframe: Next frame can start without any delay on cc::scheduler in renderer compositors. gpu: Disable display and browser vsync. default: Set both flags. ↪
--disable-gpu-watchdog ⊗	Disable the thread that crashes the GPU process if it stops responding to messages. ↪
--disable-hang-monitor ⊗	Suppresses hang monitor dialogs in renderer processes. This may allow slow unload handlers on a page to prevent the tab from closing, but the Task Manager can be used to terminate the offending process in this case. ↪
--disable-hid-detection-on-oobe ⊗	Disables HID-detection OOBE screen. ↪
--disable-histogram-customizer ⊗	Disable the RenderThread's HistogramCustomizer. ↪
--disable-hosted-app-shim-creation[7] ⊗	Disables app shim creation for hosted apps on Mac. ↪
--disable-hosted-apps-in-windows[7] ⊗	Prevents hosted apps from being opened in windows on Mac. ↪
--disable-in-process-stack-traces ⊗	Disable the in-process stack traces. ↪
--disable-infobars ⊗	Prevent infobars from appearing. ↪
--disable-input-view ⊗	No description ↪
--disable-ios-password-suggestions ⊗	Disable showing available password credentials in the keyboard accessory view when focused on form fields. ↪
--disable-ios-physical-web ⊗	Disables Physical Web scanning for nearby URLs. ↪
--disable-javascript-harmony-shipping ⊗	Disable latest shipping ECMAScript 6 features. ↪
--disable-kill-after-bad-ipc ⊗	Don't kill a child process when it sends a bad IPC message. Apart from testing, it is a bad idea from a security perspective to enable this switch. ↪
--disable-lcd-text ⊗	Disables LCD text. ↪
--disable-legacy-window[1] ⊗	Disable the Legacy Window which corresponds to the size of the WebContents. ↪
--disable-local-storage ⊗	Disable LocalStorage. ↪
--disable-logging ⊗	Force logging to be disabled. Logging is enabled by default in debug builds. ↪
--disable-logging-redirect[8] ⊗	Disables logging redirect for testing. ↪
--disable-login-animations ⊗	Avoid doing expensive animations upon login. ↪
--disable-login-screen-apps[8] ⊗	Disables apps on the login screen. By default, they are allowed and can be installed through policy. ↪
--disable-low-end-device-mode ⊗	Force disabling of low-end device mode when set. ↪
--disable-low-latency-dxva ⊗	Disables using CODECAPI_AVLowLatencyMode when creating DXVA decoders. ↪
--disable-low-res-tiling ⊗	When using CPU rasterizing disable low resolution tiling. This uses less power, particularly during animations, but more white may be seen during fast scrolling especially on slower devices. ↪
--disable-mac-overlays[11] ⊗	Fall back to using CAOpenGLLayers display content, instead of the IOSurface based overlay display path. ↪
--disable-mac-views-native-app-windows[7] ⊗	Disables use of toolkit-views based native app windows. ↪
--disable-machine-cert-request ⊗	Disables requests for an enterprise machine certificate during attestation. ↪
--disable-main-frame-before-activation ⊗	Disables sending the next BeginMainFrame before the previous commit activates. Overrides the kEnableMainFrameBeforeActivation flag. ↪
--disable-md-oobe ⊗	Disables material design OOBE UI. ↪
--disable-media-session-api[6] ⊗	Disable Media Session API ↪
--disable-media-suspend ⊗	No description ↪
--disable-merge-key-char-events[1] ⊗	Disables merging the key event (WM_KEY*) with the char event (WM_CHAR). ↪
--disable-mojo-local-storage ⊗	Dont use a Mojo-based LocalStorage implementation. ↪
--disable-mojo-renderer[12] ⊗	Rather than use the renderer hosted remotely in the media service, fall back to the default renderer within content_renderer. Does not change the behavior of the media service. ↪
--disable-mtp-write-support ⊗	Disables mtp write support. ↪
--disable-multi-display-layout ⊗	Disables the multiple display layout UI. ↪
--disable-namespace-sandbox ⊗	Disables usage of the namespace sandbox. ↪
--disable-native-gpu-memory-buffers ⊗	Disables native GPU memory buffer support. ↪
--disable-network-portal-notification ⊗	Disables notifications about captive portals in session. ↪
--disable-new-channel-switcher-ui ⊗	Disables new channel switcher UI. ↪
--disable-new-korean-ime ⊗	Disables the new Korean IME in chrome://settings/languages. ↪
--disable-new-virtual-keyboard-behavior ⊗	Disable new window behavior for virtual keyboard (do not change work area in non-sticky mode). ↪
--disable-new-zip-unpacker ⊗	Disables the new File System Provider API based ZIP unpacker. ↪
--disable-notifications ⊗	Disables the Web Notification and the Push APIs. ↪
--disable-ntp-most-likely-favicons-from-server ⊗	Disables the new Google favicon server for fetching favicons for Most Likely tiles on the New Tab Page. ↪
--disable-ntp-popular-sites ⊗	Disables showing popular sites on the NTP. ↪
--disable-nv12-dxgi-video ⊗	Disables the video decoder from drawing to an NV12 textures instead of ARGB. ↪
--disable-offer-store-unmasked-wallet-cards ⊗	Force hiding the local save checkbox in the autofill dialog box for getting the full credit card number for a wallet card. The card will never be stored locally. ↪
--disable-offer-upload-credit-cards ⊗	Disables offering to upload credit cards. ↪
--disable-office-editing-component-extension ⊗	Disables Office Editing for Docs, Sheets & Slides component app so handlers won't be registered, making it possible to install another version for testing. ↪
--disable-offline-auto-reload ⊗	Disable auto-reload of error pages if offline. ↪
--disable-offline-auto-reload-visible-only ⊗	Disable only auto-reloading error pages when the tab is visible. ↪
--disable-origin-trial-controlled-blink-features ⊗	Disables all RuntimeEnabledFeatures that can be enabled via OriginTrials. ↪
--disable-overscroll-edge-effect[6] ⊗	Disable overscroll edge effects like those found in Android views. ↪
--disable-panel-fitting[8] ⊗	Disables panel fitting (used for mirror mode). ↪
--disable-partial-raster ⊗	Disable partial raster in the renderer. Disabling this switch also disables the use of persistent gpu memory buffers. ↪
--disable-password-generation ⊗	Disables password generation when we detect that the user is going through account creation. ↪
--disable-pepper-3d ⊗	Disable Pepper3D. ↪
--disable-pepper-3d-image-chromium ⊗	Disable Image Chromium for Pepper 3d. ↪
--disable-per-user-timezone ⊗	Disables per-user timezone. ↪
--disable-permission-action-reporting ⊗	Disables permission action reporting to Safe Browsing servers for opted in users. ↪
--disable-permissions-api ⊗	Disables the Permissions API. ↪
--disable-physical-keyboard-autocorrect ⊗	Disables suggestions while typing on a physical keyboard. ↪
--disable-pinch ⊗	Disables compositor-accelerated touch-screen pinch gestures. ↪
--disable-pnacl-crash-throttling ⊗	Disables crash throttling for Portable Native Client. ↪
--disable-popup-blocking ⊗	Disable pop-up blocking. ↪
--disable-prefer-compositing-to-lcd-text ⊗	Disable the creation of compositing layers when it would prevent LCD text. ↪
--disable-presentation-api ⊗	Disables the Presentation API. ↪
--disable-print-preview ⊗	Disables print preview (For testing, and for users who don't like us. :[ ) ↪
--disable-prompt-on-repost ⊗	Normally when the user attempts to navigate to a page that was the result of a post we prompt to make sure they want to. This switch may be used to disable that check. This switch is used during automated testing. ↪
--disable-proximity-auth-bluetooth-low-energy-discovery ⊗	Disables discovery of the phone over Bluetooth Low Energy. ↪
--disable-pull-to-refresh-effect[6] ⊗	Disable the pull-to-refresh effect when vertically overscrolling content. ↪
--disable-push-api-background-mode ⊗	Enable background mode for the Push API. ↪
--disable-reading-from-canvas ⊗	Taints all <canvas> elements, regardless of origin. ↪
--disable-remote-core-animation[11] ⊗	Disable use of cross-process CALayers to display content directly from the GPU process on Mac. ↪
--disable-remote-fonts ⊗	Disables remote web font support. SVG font should always work whether this option is specified or not. ↪
--disable-remote-playback-api ⊗	Disables the RemotePlayback API. ↪
--disable-renderer-accessibility ⊗	Turns off the accessibility in the renderer. ↪
--disable-renderer-backgrounding ⊗	Prevent renderer process backgrounding when set. ↪
--disable-renderer-priority-management ⊗	No not manage renderer process priority at all when set. ↪
--disable-resize-lock ⊗	Whether the resize lock is disabled. Default is false. This is generally only useful for tests that want to force disabling. ↪
--disable-rgba-4444-textures ⊗	Disables RGBA_4444 textures. ↪
--disable-rollback-option ⊗	Disables rollback option on reset screen. ↪
--disable-rtc-smoothness-algorithm ⊗	Disables the new rendering algorithm for webrtc, which is designed to improve the rendering smoothness. ↪
--disable-screen-orientation-lock[6] ⊗	Disable the locking feature of the screen orientation API. ↪
--disable-search-geolocation-disclosure ⊗	Disables showing the search geolocation disclosure UI. Used for perf testing. ↪
--disable-seccomp-filter-sandbox ⊗	Disable the seccomp filter sandbox (seccomp-bpf) (Linux only). ↪
--disable-setuid-sandbox ⊗	Disable the setuid sandbox (Linux only). ↪
--disable-shader-name-hashing ⊗	Turn off user-defined name hashing in shaders. ↪
--disable-shared-workers ⊗	Disable shared workers. ↪
--disable-signin-promo ⊗	Disables sign-in promo. ↪
--disable-signin-scoped-device-id ⊗	Disables sending signin scoped device id to LSO with refresh token request. ↪
--disable-single-click-autofill ⊗	The "disable" flag for kEnableSingleClickAutofill. ↪
--disable-skia-runtime-opts ⊗	Do not use runtime-detected high-end CPU optimizations in Skia. This is useful for forcing a baseline code path for e.g. layout tests. ↪
--disable-slim-navigation-manager ⊗	Disables the WKBackForwardList based navigation manager experiment. ↪
--disable-slimming-paint-invalidation ⊗	Disable paint invalidation based on slimming paint. See kEnableSlimmingPaintInvalidation. ↪
--disable-smooth-scrolling ⊗	Disable smooth scrolling for testing. ↪
--disable-software-rasterizer ⊗	Disables the use of a 3D software rasterizer. ↪
--disable-speech-api ⊗	Disables the Web Speech API. ↪
--disable-suggestions-ui ⊗	Disables the Suggestions UI ↪
--disable-surface-references ⊗	Disable surface lifetime management using surface references. This enables adding surface sequences and disables adding temporary references. ↪
--disable-sync ⊗	Disables syncing browser data to a Google Account. ↪
--disable-sync-app-list ⊗	No description ↪
--disable-sync-types ⊗	Disables syncing one or more sync data types that are on by default. See sync/base/model_type.h for possible types. Types should be comma separated, and follow the naming convention for string representation of model types, e.g.: --disable-synctypes='Typed URLs, Bookmarks, Autofill Profiles' ↪
--disable-system-timezone-automatic-detection ⊗	Disables SystemTimezoneAutomaticDetection policy. ↪
--disable-tab-for-desktop-share ⊗	Enables tab for desktop sharing. ↪
--disable-third-party-keyboard-workaround ⊗	Disables the 3rd party keyboard omnibox workaround. ↪
--disable-threaded-animation ⊗	No description ↪
--disable-threaded-compositing ⊗	Disable multithreaded GPU compositing of web content. ↪
--disable-threaded-scrolling ⊗	Disable multithreaded, compositor scrolling of web content. ↪
--disable-timeouts-for-profiling[6] ⊗	Disable timeouts that may cause the browser to die when running slowly. This is useful if running with profiling (such as debug malloc). ↪
--disable-touch-adjustment ⊗	Disables touch adjustment. ↪
--disable-touch-drag-drop ⊗	Disables touch event based drag and drop. ↪
--disable-translate-new-ux[7] ⊗	Disables Translate experimental new UX which replaces the infobar. ↪
--disable-usb-keyboard-detect[1] ⊗	Disables the USB keyboard detection for blocking the OSK on Win8+. ↪
--disable-v8-idle-tasks ⊗	Disable V8 idle tasks. ↪
--disable-vaapi-accelerated-video-encode[8] ⊗	Disables VA-API accelerated video encode. ↪
--disable-virtual-keyboard-overscroll ⊗	No description ↪
--disable-voice-input ⊗	No description ↪
--disable-volume-adjust-sound ⊗	Disables volume adjust sound. ↪
--disable-wake-on-wifi ⊗	Disables wake on wifi features. ↪
--disable-web-notification-custom-layouts ⊗	Disables Web Notification custom layouts. ↪
--disable-web-security ⊗	Don't enforce the same-origin policy. (Used by people testing their sites.) ↪
--disable-webgl ⊗	Disable experimental WebGL support. ↪
--disable-webgl-image-chromium ⊗	Disables WebGL rendering into a scanout buffer for overlay support. ↪
--disable-webrtc-encryption[13] ⊗	Disables encryption of RTP Media for WebRTC. When Chrome embeds Content, it ignores this switch on its stable and beta channels. ↪
--disable-webrtc-hw-decoding[13] ⊗	Disables HW decode acceleration for WebRTC. ↪
--disable-webrtc-hw-encoding[13] ⊗	Disables HW encode acceleration for WebRTC. ↪
--disable-win32k-lockdown[1] ⊗	Disables the Win32K process mitigation policy for child processes. ↪
--disable-xss-auditor ⊗	Disables Blink's XSSAuditor. The XSSAuditor mitigates reflective XSS. ↪
--disable-zero-browsers-open-for-tests ⊗	Some tests seem to require the application to close when the last browser window is closed. Thus, we need a switch to force this behavior for ChromeOS Aura, disable "zero window mode". TODO(pkotwicz): Investigate if this bug can be removed. (http://crbug.com/119175) ↪
--disable-zero-copy ⊗	Disable rasterizer that writes directly to GPU memory associated with tiles. ↪
--disable-zero-copy-dxgi-video ⊗	Disable the video decoder from drawing directly to a texture. ↪
--disabled ⊗	disabled: touch events are disabled. ↪
--disabled-new-style-notification ⊗	No description ↪
--disallow-non-exact-resource-reuse ⊗	Disable re-use of non-exact resources to fulfill ResourcePool requests. Intended only for use in layout or pixel tests to reduce noise. ↪
--disk-cache-dir ⊗	Use a specific disk cache location, rather than one derived from the UserDatadir. ↪
--disk-cache-size ⊗	Forces the maximum disk space to be used by the disk cache, in bytes. ↪
--display[14] ⊗	Which X11 display to connect to. Emulates the GTK+ "--display=" command line argument. ↪
--dmg-device[7] ⊗	When switches::kProcessType is switches::kRelauncherProcess, if this switch is also present, the relauncher process will unmount and eject a mounted disk image and move its disk image file to the trash. The argument's value must be a BSD device name of the form "diskN" or "diskNsM". ↪
--dns-log-details ⊗	No description ↪
--document-user-activation-required ⊗	Autoplay policy that requires a document user activation. ↪
--dom-automation ⊗	Specifies if the |DOMAutomationController| needs to be bound in the renderer. This binding happens on per-frame basis and hence can potentially be a performance bottleneck. One should only enable it when automating dom based tests. ↪
--draft ⊗	No description ↪
--draw-view-bounds-rects ⊗	Draws a semitransparent rect to indicate the bounds of each view. ↪
--duck-flash[4] ⊗	This value is used as an option for |kEnableAudioFocus|. Flash will be ducked when losing audio focus. ↪
--dump-blink-runtime-call-stats ⊗	Logs Runtime Call Stats for Blink. --single-process also needs to be used along with this for the stats to be logged. ↪
--dump-browser-histograms ⊗	Requests that a running browser process dump its collected histograms to a given file. The file is overwritten if it exists. ↪
--dump-dom ⊗	Instructs headless_shell to print document.body.innerHTML to stdout. ↪
--eafe-path ⊗	EAFE path to use for Easy bootstrapping. ↪
--eafe-url ⊗	EAFE URL to use for Easy bootstrapping. ↪
--easy-unlock-app-path ⊗	Overrides the path of Easy Unlock component app. ↪
--edge-touch-filtering[15] ⊗	Tells Chrome to do edge touch filtering. Useful for convertible tablet. ↪
--egl ⊗	No description ↪
--elevate ⊗	No description ↪
--embedded-extension-options ⊗	Enables extension options to be embedded in chrome://extensions rather than a new tab. ↪
--emphasize-titles-in-omnibox-dropdown ⊗	Causes the omnibox dropdown to emphasize the titles of URL suggestions for query-like inputs. ↪
--emulate-shader-precision ⊗	Emulate ESSL lowp and mediump float precisions by mutating the shaders to round intermediate values in ANGLE. ↪
--enable-accelerated-2d-canvas ⊗	Enable accelerated 2D canvas. ↪
--enable-accelerated-vpx-decode[1] ⊗	Enables experimental hardware acceleration for VP8/VP9 video decoding. Bitmask - 0x1=Microsoft, 0x2=AMD, 0x03=Try all. ↪
--enable-accessibility-tab-switcher[6] ⊗	Enable the accessibility tab switcher. ↪
--enable-adaptive-selection-handle-orientation[6] ⊗	Enable inverting of selection handles so that they are not clipped by the viewport boundaries. ↪
--enable-aggressive-domstorage-flushing ⊗	Enable the aggressive flushing of DOM Storage to minimize data loss. ↪
--enable-android-wallpapers-app ⊗	Enables the Android Wallpapers App as the default app on Chrome OS. ↪
--enable-app-info-dialog-mac[7] ⊗	Enable the toolkit-views App Info dialog for Mac. This is accessible from chrome://apps and chrome://extensions and is already enabled on non-mac. ↪
--enable-app-list ⊗	If set, the app list will be enabled as if enabled from CWS. ↪
--enable-app-window-cycling[7] ⊗	Enables custom Cmd+` window cycling for platform apps and hosted apps. ↪
--enable-appcontainer ⊗	Enable or disable appcontainer/lowbox for renderer on Win8+ platforms. ↪
--enable-arc ⊗	DEPRECATED. Please use --arc-availability=officially-supported. Enables starting the ARC instance upon session start. ↪
--enable-arc-oobe-optin ⊗	Enables ARC OptIn flow in OOBE. ↪
--enable-async-event-targeting ⊗	WindowServer uses the asynchronous event targeting logic. ↪
--enable-audio-debug-recordings-from-extension ⊗	If the WebRTC logging private API is active, enables audio debug recordings. ↪
--enable-audio-focus[16] ⊗	Enable a internal audio focus management between tabs in such a way that two tabs can't play on top of each other. The allowed values are: "" (empty) or |kEnableAudioFocusDuckFlash|. ↪
--enable-automation ⊗	Inform users that their browser is being controlled by an automated test. ↪
--enable-background-blur ⊗	If set, the app list will have background blur. ↪
--enable-benchmarking ⊗	TODO(asvitkine): Consider removing or renaming this functionality. Enables the benchmarking extensions. ↪
--enable-ble-advertising-in-apps ⊗	Enable BLE Advertisiing in apps. ↪
--enable-blink-features ⊗	Enable one or more Blink runtime-enabled features. Use names from RuntimeEnabledFeatures.json5, separated by commas. Applied before kDisableBlinkFeatures, and after other flags that change these features. ↪
--enable-bookmark-reordering ⊗	Enables bookmark reordering. ↪
--enable-bookmark-undo ⊗	Enables the multi-level undo system for bookmarks. ↪
--enable-browser-side-navigation ⊗	PlzNavigate: Use the experimental browser-side navigation path. ↪
--enable-browser-task-scheduler ⊗	No description ↪
--enable-cast-receiver ⊗	Enables the Cast Receiver. ↪
--enable-checker-imaging ⊗	Enables defering image decodes to the image decode service. ↪
--enable-chromevox-arc-support ⊗	Enables native ChromeVox support for Arc. ↪
--enable-clear-browsing-data-counters ⊗	Enables data volume counters in the Clear Browsing Data dialog. ↪
--enable-cloud-print-proxy ⊗	This applies only when the process type is "service". Enables the Cloud Print Proxy component within the service process. ↪
--enable-cloud-print-xps[1] ⊗	Fallback to XPS. By default connector uses CDD. ↪
--enable-consumer-kiosk ⊗	Enables consumer kiosk mode for Chrome OS. ↪
--enable-contextual-search ⊗	Enables Contextual Search. ↪
--enable-crash-reporter ⊗	Enable chrash reporter for headless. ↪
--enable-crash-reporter-for-testing[17] ⊗	Used for turning on Breakpad crash reporting in a debug environment where crash reporting is typically compiled but disabled. ↪
--enable-crx-hash-check ⊗	Enable package hash check: the .crx file sha256 hash sum should be equal to the one received from update manifest. ↪
--enable-data-reduction-proxy-bypass-warning ⊗	Enable the data reduction proxy bypass warning. ↪
--enable-data-reduction-proxy-force-pingback ⊗	Enables sending a pageload metrics pingback after every page load. ↪
--enable-data-reduction-proxy-lite-page ⊗	Enables lite page from the data reduction proxy. This means a lite page should be requested instead of placeholders whenever Lo-Fi mode is on. Lo-fi must also be enabled via a flag or field trial. ↪
--enable-data-reduction-proxy-savings-promo ⊗	Enables a 1 MB savings promo for the data reduction proxy. ↪
--enable-datasaver-prompt ⊗	Enables Data Saver prompt on cellular networks. ↪
--enable-device-discovery-notifications ⊗	Enable device discovery notifications. ↪
--enable-devtools-experiments ⊗	If true devtools experimental settings are enabled. ↪
--enable-direct-composition-layers ⊗	Enables using DirectComposition layers, even if hardware overlays aren't supported. ↪
--enable-display-list-2d-canvas ⊗	Enables display list based 2d canvas implementation. Options: 1. Enable: allow browser to use display list for 2d canvas (browser makes decision). 2. Force: browser always uses display list for 2d canvas. ↪
--enable-distance-field-text ⊗	Enables using signed distance fields when rendering text. Only valid if GPU rasterization is enabled as well. ↪
--enable-distillability-service ⊗	No description ↪
--enable-dom-distiller ⊗	No description ↪
--enable-domain-reliability ⊗	Enables Domain Reliability Monitoring. ↪
--enable-drive-search-in-app-launcher ⊗	Enable/disable drive search in chrome launcher. ↪
--enable-drm-atomic ⊗	Try to enable drm atomic. This works only with drm platform. ↪
--enable-embedded-extension-options ⊗	Hack so that feature switch can work with about_flags. See kEnableScriptsRequireAction. ↪
--enable-encryption-migration ⊗	Enables encryption migration for user's cryptohome to run latest Arc. ↪
--enable-encryption-selection[9] ⊗	Enables the feature of allowing the user to disable the backend via a setting. ↪
--enable-es3-apis ⊗	Enable OpenGL ES 3 APIs. ↪
--enable-exclusive-audio[1] ⊗	Use exclusive mode audio streaming for Windows Vista and higher. Leads to lower latencies for audio streams which uses the AudioParameters::AUDIO_PCM_LOW_LATENCY audio path. See http://msdn.microsoft.com/en-us/library/windows/desktop/dd370844.aspx for details. ↪
--enable-experimental-accessibility-features ⊗	Shows additional checkboxes in Settings to enable Chrome OS accessibility features that haven't launched yet. ↪
--enable-experimental-canvas-features ⊗	Enable experimental canvas features, e.g. canvas 2D context attributes ↪
--enable-experimental-extension-apis ⊗	Enables extension APIs that are in development. ↪
--enable-experimental-fullscreen-exit-ui ⊗	Enables an experimental full screen exit UI to allow exiting fullscreen from mouse or touch. ↪
--enable-experimental-input-view-features ⊗	No description ↪
--enable-experimental-web-platform-features ⊗	Enables Web Platform features that are in development. ↪
--enable-extension-activity-log-testing ⊗	No description ↪
--enable-extension-activity-logging ⊗	Enables logging for extension activity. ↪
--enable-extension-assets-sharing ⊗	Enables sharing assets for installed default apps. ↪
--enable-fast-unload ⊗	Enable the fast unload controller, which speeds up tab/window close by running a tab's onunload js handler independently of the GUI - crbug.com/142458 . ↪
--enable-features ⊗	Lists separated by commas the name of features to disable. See base::FeatureList::InitializeFromCommandLine for details. ↪
--enable-file-manager-touch-mode ⊗	No description ↪
--enable-first-run-ui-transitions ⊗	Enables animated transitions during first-run tutorial. ↪
--enable-floating-virtual-keyboard ⊗	No description ↪
--enable-font-antialiasing ⊗	Enable font antialiasing for pixel tests. ↪
--enable-fullscreen-app-list ⊗	If set, fullscreen app list will be enabled as if the feature flag was set. ↪
--enable-fullscreen-tab-detaching[7] ⊗	Enables tab detaching in fullscreen mode on Mac. ↪
--enable-fullscreen-toolbar-reveal[7] ⊗	Enables the fullscreen toolbar to reveal itself for tab strip changes. ↪
--enable-google-branded-context-menu[18] ⊗	Shows a Google icon next to context menu items powered by Google services. ↪
--enable-gpu-async-worker-context ⊗	Makes the GL worker context run asynchronously by using a separate stream. ↪
--enable-gpu-benchmarking ⊗	Enables the GPU benchmarking extension ↪
--enable-gpu-client-logging ⊗	Enable GPU client logging. ↪
--enable-gpu-client-tracing ⊗	Enables TRACE for GL calls in the renderer. ↪
--enable-gpu-command-logging ⊗	Turn on Logging GPU commands. ↪
--enable-gpu-debugging ⊗	Turn on Calling GL Error after every command. ↪
--enable-gpu-driver-debug-logging ⊗	Enable logging of GPU driver debug messages. ↪
--enable-gpu-memory-buffer-compositor-resources ⊗	Specify that all compositor resources should be backed by GPU memory buffers. ↪
--enable-gpu-memory-buffer-video-frames ⊗	Enable GpuMemoryBuffer backed VideoFrames. ↪
--enable-gpu-rasterization ⊗	Allow heuristics to determine when a layer tile should be drawn with the Skia GPU backend. Only valid with GPU accelerated compositing + impl-side painting. ↪
--enable-gpu-service-logging ⊗	Turns on GPU logging (debug build only). ↪
--enable-gpu-service-tracing ⊗	Turns on calling TRACE for every GL call. ↪
--enable-hardware-overlays ⊗	Enable compositing individual elements via hardware overlays when permitted by device. Setting the flag to "single-fullscreen" will try to promote a single fullscreen overlay and use it as main framebuffer where possible. ↪
--enable-harfbuzz-rendertext[7] ⊗	Enables the HarfBuzz port of RenderText on Mac (it's already used only for text editing; this enables it for everything else). ↪
--enable-heap-profiling ⊗	Makes memory allocators keep track of their allocations and context, so a detailed breakdown of memory usage can be presented in chrome://tracing when the memory-infra category is enabled. ↪
--enable-hosted-app-quit-notification[7] ⊗	Shows a notification when quitting Chrome with hosted apps running. Default behavior is to also quit all hosted apps. ↪
--enable-hosted-apps-in-windows[7] ⊗	Allows hosted apps to be opened in windows on Mac. ↪
--enable-hotword-hardware ⊗	Enables experimental hotword features specific to always-on. ↪
--enable-hung-renderer-infobar[6] ⊗	Enables a hung renderer InfoBar allowing the user to close or wait on unresponsive web content. ↪
--enable-inband-text-tracks ⊗	Enables support for inband text tracks in media content. ↪
--enable-internal-media-session[19] ⊗	Turns on the internal media session backend. This should be used by embedders that want to control the media playback with the media session interfaces. ↪
--enable-ios-handoff-to-other-devices ⊗	Enables support for Handoff from Chrome on iOS to the default browser of other Apple devices. ↪
--enable-ios-physical-web ⊗	Enables Physical Web scanning for nearby URLs. ↪
--enable-layer-lists ⊗	Switches cc machinery to use layer lists instead of layer trees ↪
--enable-lcd-text ⊗	Enables LCD text. ↪
--enable-leak-detection ⊗	Enables the leak detection of loading webpages. This allows us to check whether or not reloading a webpage releases web-related objects correctly. ↪
--enable-local-file-accesses ⊗	Enable file accesses. It should not be enabled for most Cast devices. ↪
--enable-local-sync-backend ⊗	Enabled the local sync backend implemented by the LoopbackServer. ↪
--enable-lock-screen-apps ⊗	Enables action handler apps (e.g. creating new notes) on lock screen. ↪
--enable-logging ⊗	Controls whether console logging is enabled and optionally configures where it's routed. ↪
--enable-longpress-drag-selection[6] ⊗	Enable drag manipulation of longpress-triggered text selections. ↪
--enable-low-end-device-mode ⊗	Force low-end device mode when set. ↪
--enable-low-res-tiling ⊗	When using CPU rasterizing generate low resolution tiling. Low res tiles may be displayed during fast scrolls especially on slower devices. ↪
--enable-mac-views-native-app-windows[7] ⊗	Enables use of toolkit-views based native app windows. ↪
--enable-main-frame-before-activation ⊗	Enables sending the next BeginMainFrame before the previous commit activates. ↪
--enable-md-feedback ⊗	Enables the Material Design feedback form. ↪
--enable-media-suspend ⊗	Suspend media pipeline on background tabs. ↪
--enable-merge-key-char-events[1] ⊗	Enables merging the key event (WM_KEY*) with the char event (WM_CHAR). ↪
--enable-message-center-always-scroll-up-upon-notification-removal ⊗	Enables message center to always move other notifications upwards when a notification is removed, no matter whether the message center is displayed top down or not. ↪
--enable-nacl ⊗	Runs the Native Client inside the renderer process and enables GPU plugin (internally adds lEnableGpuPlugin to the command line). ↪
--enable-nacl-debug ⊗	Enables debugging via RSP over a socket. ↪
--enable-nacl-nonsfi-mode ⊗	Enables Non-SFI mode, in which programs can be run without NaCl's SFI sandbox. ↪
--enable-native-gpu-memory-buffers ⊗	Enable native GPU memory buffer support when available. ↪
--enable-natural-scroll-default ⊗	Enables natural scroll by default. ↪
--enable-navigation-tracing ⊗	Enables tracing for each navigation. It will attempt to trace each navigation for 10s, until the buffer is full, or until the next navigation. It only works if a URL was provided by --trace-upload-url. ↪
--enable-net-benchmarking ⊗	Enables the network-related benchmarking extensions. ↪
--enable-network-information-downlink-max ⊗	Enables the type, downlinkMax attributes of the NetInfo API. Also, enables triggering of change attribute of the NetInfo API when there is a change in the connection type. ↪
--enable-network-portal-notification ⊗	Enables notifications about captive portals in session. ↪
--enable-ntp-most-likely-favicons-from-server ⊗	Enables the new Google favicon server for fetching favicons for Most Likely tiles on the New Tab Page. ↪
--enable-ntp-popular-sites ⊗	Enables showing popular sites on the NTP. ↪
--enable-ntp-search-engine-country-detection ⊗	Enables using the default search engine country to show country specific popular sites on the NTP. ↪
--enable-offer-store-unmasked-wallet-cards ⊗	Force showing the local save checkbox in the autofill dialog box for getting the full credit card number for a wallet card. ↪
--enable-offer-upload-credit-cards ⊗	Enables offering to upload credit cards. ↪
--enable-offline-auto-reload ⊗	Enable auto-reload of error pages if offline. ↪
--enable-offline-auto-reload-visible-only ⊗	Only auto-reload error pages when the tab is visible. ↪
--enable-osk-overscroll[6] ⊗	Enables overscrolling for the OSK on Android. ↪
--enable-override-bookmarks-ui ⊗	Enables extensions to hide bookmarks UI elements. ↪
--enable-partial-raster ⊗	Enable partial raster in the renderer. ↪
--enable-password-generation ⊗	Enables password generation when we detect that the user is going through account creation. ↪
--enable-pepper-testing ⊗	Enables the testing interface for PPAPI. ↪
--enable-permission-action-reporting ⊗	Enables permission action reporting to Safe Browsing servers for opted in users. ↪
--enable-physical-keyboard-autocorrect ⊗	Enables suggestions while typing on a physical keyboard. ↪
--enable-picture-in-picture ⊗	Enables the picture in picture feature for videos. ↪
--enable-pinch ⊗	Enables compositor-accelerated touch-screen pinch gestures. ↪
--enable-pixel-canvas-recording ⊗	If enabled, all draw commands recorded on canvas are done in pixel aligned measurements. This also enables scaling of all elements in views and layers to be done via corner points. See https://goo.gl/Dqig5s ↪
--enable-pixel-output-in-tests ⊗	Forces tests to produce pixel output when they normally wouldn't. ↪
--enable-plugin-placeholder-testing ⊗	Enables testing features of the Plugin Placeholder. For internal use only. ↪
--enable-potentially-annoying-security-features ⊗	Enables a number of potentially annoying security features (strict mixed content mode, powerful feature restrictions, etc.) ↪
--enable-power-overlay ⊗	Enables the Power overlay in Settings. ↪
--enable-precise-memory-info ⊗	Make the values returned to window.performance.memory more granular and more up to date in shared worker. Without this flag, the memory information is still available, but it is bucketized and updated less frequently. This flag also applys to workers. ↪
--enable-prefer-compositing-to-lcd-text ⊗	Enable the creation of compositing layers when it would prevent LCD text. ↪
--enable-print-browser ⊗	Enables PrintBrowser mode, in which everything renders as though printed. ↪
--enable-print-preview-register-promos ⊗	Enables showing unregistered printers in print preview ↪
--enable-profile-shortcut-manager[1] ⊗	Force-enables the profile shortcut manager. This is needed for tests since they use a custom-user-data-dir which disables this. ↪
--enable-profiling ⊗	Enables tracking of tasks in profiler for viewing via about:profiler. To predominantly disable tracking (profiling), use the command line switch: --enable-profiling=0 Some tracking will still take place at startup, but it will be turned off during chrome_browser_main. ↪
--enable-push-api-background-mode ⊗	Enable background mode for the Push API. ↪
--enable-reader-mode-toolbar-icon ⊗	Enables context-sensitive reader mode button in the toolbar. ↪
--enable-request-tablet-site ⊗	Enables request of tablet site (via user agent override). ↪
--enable-rgba-4444-textures ⊗	Enables RGBA_4444 textures. ↪
--enable-sandbox ⊗	Enables the sandbox on this process. ↪
--enable-sandbox-logging ⊗	Cause the OS X sandbox write to syslog every time an access to a resource is denied by the sandbox. ↪
--enable-screenshot-testing-with-mode ⊗	Enables using screenshots in tests and seets mode. ↪
--enable-scripts-require-action ⊗	FeatureSwitch and about_flags don't play nice. Feature switch expects either --enable-<feature> or --<feature>=1, but about_flags expects the command line argument to enable it (or a selection). Hack this in, so enabling it in about_flags enables the feature. Appending this flag has the same effect as --scripts-require-action=1. ↪
--enable-scroll-prediction ⊗	Enable scroll prediction for scroll update events. ↪
--enable-service-manager-tracing ⊗	Enable the tracing service. ↪
--enable-sgi-video-sync ⊗	Enable use of the SGI_video_sync extension, which can have driver/sandbox/window manager compatibility issues. ↪
--enable-signin-promo ⊗	Enables sign-in promo. ↪
--enable-single-click-autofill ⊗	Enables/disables suggestions without typing anything (on first click). ↪
--enable-site-settings ⊗	Enables the site settings all sites list and site details pages in the Chrome settings UI. ↪
--enable-skia-benchmarking ⊗	Enables the Skia benchmarking extension ↪
--enable-slim-navigation-manager ⊗	Enables the WKBackForwardList based navigation manager experiment. ↪
--enable-slimming-paint-invalidation ⊗	Enables paint invalidation based on slimming paint but without the full slimming paint v2 compositing code. See: https://goo.gl/eQczQW ↪
--enable-slimming-paint-v2 ⊗	Enables slimming paint phase 2: http://www.chromium.org/blink/slimming-paint ↪
--enable-smooth-scrolling ⊗	On platforms that support it, enables smooth scroll animation. ↪
--enable-spatial-navigation ⊗	Enable spatial navigation ↪
--enable-spdy-proxy-auth ⊗	Enable the data reduction proxy. ↪
--enable-speech-dispatcher[20] ⊗	Allows sending text-to-speech requests to speech-dispatcher, a common Linux speech service. Because it's buggy, the user must explicitly enable it so that visiting a random webpage can't cause instability. ↪
--enable-spelling-feedback-field-trial[21] ⊗	Enables participation in the field trial for user feedback to spelling service. ↪
--enable-spotlight-actions ⊗	Enables the Spotlight actions. ↪
--enable-stats-collection-bindings ⊗	Specifies if the |StatsCollectionController| needs to be bound in the renderer. This binding happens on per-frame basis and hence can potentially be a performance bottleneck. One should only enable it when running a test that needs to access the provided statistics. ↪
--enable-stats-table ⊗	Enables StatsTable, logging statistics to a global named shared memory table. ↪
--enable-strict-mixed-content-checking ⊗	Blocks all insecure requests from secure contexts, and prevents the user from overriding that decision. ↪
--enable-strict-powerful-feature-restrictions ⊗	Blocks insecure usage of a number of powerful features (device orientation, for example) that we haven't yet deprecated for the web at large. ↪
--enable-suggestions-ui ⊗	Enables the Suggestions UI ↪
--enable-suggestions-with-substring-match ⊗	Enables suggestions with substring matching instead of prefix matching. ↪
--enable-supervised-user-managed-bookmarks-folder ⊗	Enables the supervised user managed bookmarks folder. ↪
--enable-surface-synchronization ⊗	Enables multi-client Surface synchronization. In practice, this indicates that LayerTreeHost expects to be given a valid viz::LocalSurfaceId provided by the parent compositor. ↪
--enable-swap-buffers-with-bounds ⊗	Enables SwapBuffersWithBounds if it is supported. ↪
--enable-sync-app-list ⊗	Enable/disable syncing of the app list independent of extensions. ↪
--enable-sync-articles ⊗	No description ↪
--enable-tab-audio-muting ⊗	Enables user control over muting tab audio from the tab strip. ↪
--enable-tablet-splitview ⊗	Enables the split view on tablet mode. ↪
--enable-tcp-fastopen ⊗	Enable use of experimental TCP sockets API for sending data in the SYN packet. ↪
--enable-third-party-keyboard-workaround ⊗	Enables the 3rd party keyboard omnibox workaround. ↪
--enable-threaded-compositing ⊗	Enabled threaded compositing for layout tests. ↪
--enable-threaded-texture-mailboxes ⊗	Simulates shared textures when share groups are not available. Not available everywhere. ↪
--enable-tile-compression ⊗	Compress tile textures for GPUs supporting it. ↪
--enable-touch-calibration-setting ⊗	Enables the touch calibration option in MD settings UI for valid touch displays. ↪
--enable-touch-drag-drop ⊗	Enables touch event based drag and drop. ↪
--enable-touchpad-three-finger-click ⊗	Enables touchpad three-finger-click as middle button. ↪
--enable-touchview ⊗	Enables the observation of accelerometer events to enter touch-view mode. ↪
--enable-trace-app-source ⊗	Pass launch source to platform apps. ↪
--enable-tracing ⊗	Enable tracing during the execution of browser tests. ↪
--enable-tracing-output ⊗	The filename to write the output of the test tracing to. ↪
--enable-translate-new-ux[7] ⊗	Enables Translate experimental new UX which replaces the infobar. ↪
--enable-ui-devtools ⊗	Enables DevTools server for UI (mus, ash, etc). Value should be the port the server is started on. Default port is 9332. ↪
--enable-use-zoom-for-dsf ⊗	Enable the mode that uses zooming to implment device scale factor behavior. ↪
--enable-user-metrics[7] ⊗	Enable user metrics from within the installer. ↪
--enable-usermedia-screen-capturing ⊗	Enable screen capturing support for MediaStream API. ↪
--enable-video-player-chromecast-support ⊗	Enables the chromecast support for video player app. ↪
--enable-viewport ⊗	Enables the use of the @viewport CSS rule, which allows pages to control aspects of their own layout. This also turns on touch-screen pinch gestures. ↪
--enable-virtual-keyboard ⊗	No description ↪
--enable-voice-interaction ⊗	Enables the VoiceInteraction support. ↪
--enable-vtune-support ⊗	Enable the Vtune profiler support. ↪
--enable-vulkan ⊗	Enable Vulkan support, must also have ENABLE_VULKAN defined. ↪
--enable-wayland-server[22] ⊗	Enables Wayland display server support. ↪
--enable-web-notification-custom-layouts ⊗	Enables Web Notification custom layouts. ↪
--enable-webfonts-intervention-trigger ⊗	Enable WebFonts intervention and trigger the signal always. ↪
--enable-webfonts-intervention-v2 ⊗	WebFonts intervention v2 flag and values. ↪
--enable-webgl-draft-extensions ⊗	Enables WebGL extensions not yet approved by the community. ↪
--enable-webgl-image-chromium ⊗	Enables WebGL rendering into a scanout buffer for overlay support. ↪
--enable-webrtc-event-logging-from-extension ⊗	If the WebRTC logging private API is active, enables WebRTC event logging. ↪
--enable-webrtc-srtp-aes-gcm[13] ⊗	Enables negotiation of GCM cipher suites from RFC 7714 for SRTP in WebRTC. See https://tools.ietf.org/html/rfc7714 for further information. ↪
--enable-webrtc-stun-origin[13] ⊗	Enables Origin header in Stun messages for WebRTC. ↪
--enable-webview-variations ⊗	No description ↪
--enable-webvr ⊗	Enables interaction with virtual reality devices. ↪
--enable-wifi-credential-sync ⊗	Enables synchronizing WiFi credentials across devices, using Chrome Sync. ↪
--enable-win7-webrtc-hw-h264-decoding[1] ⊗	Enables H264 HW decode acceleration for WebRtc on Win 7. ↪
--enable-zero-copy ⊗	Enable rasterizer that writes directly to GPU memory associated with tiles. ↪
--enable-zip-archiver-on-file-manager ⊗	Enables zip archiver. ↪
--enabled ⊗	enabled: touch events always enabled. ↪
--enabled-2g ⊗	No description ↪
--enabled-3g ⊗	No description ↪
--enabled-new-style-notification ⊗	Flag to enable or disable new-style notification. This flag will be removed once the feature gets stable. ↪
--enabled-slow2g ⊗	No description ↪
--encode-binary ⊗	Encode binary layout test results (images, audio) using base64. ↪
--enforce ⊗	No description ↪
--enforce-gl-minimums ⊗	Enforce GL minimums. ↪
--enforce-webrtc-ip-permission-check[13] ⊗	Enforce IP Permission check. TODO(guoweis): Remove this once the feature is not under finch and becomes the default. ↪
--enforce_strict ⊗	No description ↪
--enterprise-disable-arc ⊗	Disables ARC for managed accounts. ↪
--enterprise-enable-forced-re-enrollment ⊗	Whether to enable forced enterprise re-enrollment. ↪
--enterprise-enable-license-type-selection ⊗	Enables license type selection by user during enrollment. ↪
--enterprise-enable-zero-touch-enrollment ⊗	Enables the zero-touch enterprise enrollment flow. ↪
--enterprise-enrollment-initial-modulus ⊗	Power of the power-of-2 initial modulus that will be used by the auto-enrollment client. E.g. "4" means the modulus will be 2^4 = 16. ↪
--enterprise-enrollment-modulus-limit ⊗	Power of the power-of-2 maximum modulus that will be used by the auto-enrollment client. ↪
--error-console ⊗	Allows the ErrorConsole to collect runtime and manifest errors, and display them in the chrome:extensions page. ↪
--evaluate-type ⊗	No description ↪
--evaluate_capability ⊗	No description ↪
--experiment ⊗	No description ↪
--explicitly-allowed-ports ⊗	Explicitly allows additional ports using a comma-separated list of port numbers. ↪
--expose-internals-for-testing ⊗	Exposes the window.internals object to JavaScript for interactive development and debugging of layout tests that rely on it. ↪
--extension-content-verification ⊗	Name of the command line flag to force content verification to be on in one of various modes. ↪
--extension-process ⊗	Marks a renderer as extension process. ↪
--extensions-install-verification ⊗	Turns on extension install verification if it would not otherwise have been turned on. ↪
--extensions-multi-account ⊗	Enables multiple account versions of chrome.identity APIs. ↪
--extensions-not-webstore ⊗	Specifies a comma-separated list of extension ids that should be forced to be treated as not from the webstore when doing install verification. ↪
--extensions-on-chrome-urls ⊗	Enables extensions running scripts on chrome:// URLs. Extensions still need to explicitly request access to chrome:// URLs in the manifest. ↪
--extensions-update-frequency ⊗	Frequency in seconds for Extensions auto-update. ↪
--extra-search-query-params ⊗	Additional query params to insert in the search and instant URLs. Useful for testing. ↪
--fake-variations-channel ⊗	Fakes the channel of the browser for purposes of Variations filtering. This is to be used for testing only. Possible values are "stable", "beta", "dev" and "canary". Note that this only applies if the browser's reported channel is UNKNOWN. ↪
--false ⊗	Value indicating whether flag from command line switch is false. ↪
--fast ⊗	Defines that Material Design visual feedback animations should be fast. ↪
--fast-start ⊗	If this flag is present then this command line is being delegated to an already running chrome process via the fast path, ie: before chrome.dll is loaded. It is useful to tell the difference for tracking purposes. ↪
--feedback-server ⊗	Alternative feedback server to use when submitting user feedback ↪
--field-trial-handle ⊗	Handle to the shared memory segment containing field trial state that is to be shared between processes. The argument to this switch is the handle id (pointer on Windows) as a string, followed by a comma, then the size of the shared memory segment as a string. ↪
--first-exec-after-boot ⊗	Passed to Chrome the first time that it's run after the system boots. Not passed on restart after sign out. ↪
--flag-switches-begin ⊗	These two flags are added around the switches about:flags adds to the command line. This is useful to see which switches were added by about:flags on about:version. They don't have any effect. ↪
--flag-switches-end ⊗	No description ↪
--font-cache-shared-handle[1] ⊗	DirectWrite FontCache is shared by browser to renderers using shared memory. This switch allows us to pass the shared memory handle to the renderer. ↪
--force-android-app-mode ⊗	Forces Android application mode. This hides certain system UI elements and forces the app to be installed if it hasn't been already. ↪
--force-app-mode ⊗	Forces application mode. This hides certain system UI elements and forces the app to be installed if it hasn't been already. ↪
--force-clamshell-power-button ⊗	Forces non-tablet-style power button behavior even if the device has a convertible form factor. ↪
--force-color-profile ⊗	Force all monitors to be treated as though they have the specified color profile. Accepted values are "srgb" and "generic-rgb" (currently used by Mac layout tests) and "color-spin-gamma24" (used by layout tests). ↪
--force-desktop-ios-promotion ⊗	Forces Desktop to iOS promotion to appear in windows whenever an entrypoint is triggered. ↪
--force-dev-mode-highlighting ⊗	Whether to force developer mode extensions highlighting. ↪
--force-device-scale-factor ⊗	Overrides the device scale factor for the browser UI and the contents. ↪
--force-display-list-2d-canvas ⊗	No description ↪
--force-effective-connection-type ⊗	Forces Network Quality Estimator (NQE) to return a specific effective connection type. ↪
--force-enable-metrics-reporting ⊗	Forces metrics reporting to be enabled. ↪
--force-enable-stylus-tools ⊗	Enables the stylus tools next to the status area. ↪
--force-fieldtrial-params ⊗	This option can be used to force parameters of field trials when testing changes locally. The argument is a param list of (key, value) pairs prefixed by an associated (trial, group) pair. You specify the param list for multiple (trial, group) pairs with a comma separator. Example: "Trial1.Group1:k1/v1/k2/v2,Trial2.Group2:k3/v3/k4/v4" Trial names, groups names, parameter names, and value should all be URL escaped for all non-alphanumeric characters. ↪
--force-fieldtrials ⊗	This option can be used to force field trials when testing changes locally. The argument is a list of name and value pairs, separated by slashes. If a trial name is prefixed with an asterisk, that trial will start activated. For example, the following argument defines two trials, with the second one activated: "GoogleNow/Enable/*MaterialDesignNTP/Default/" This option can also be used by the browser process to send the list of trials to a non-browser process, using the same format. See FieldTrialList::CreateTrialsFromString() in field_trial.h for details. ↪
--force-first-run ⊗	Displays the First Run experience when the browser is started, regardless of whether or not it's actually the First Run (this overrides kNoFirstRun). ↪
--force-first-run-ui ⊗	Forces first-run UI to be shown for every login. ↪
--force-gpu-mem-available-mb ⊗	Sets the total amount of memory that may be allocated for GPU resources ↪
--force-gpu-rasterization ⊗	Always use the Skia GPU backend for drawing layer tiles. Only valid with GPU accelerated compositing + impl-side painting. Overrides the kEnableGpuRasterization flag. ↪
--force-happiness-tracking-system ⊗	Force enables the Happiness Tracking System for the device. This ignores user profile check and time limits and shows the notification every time for any type of user. Should be used only for testing. ↪
--force-load-easy-unlock-app-in-tests ⊗	Force easy unlock app loading in test. TODO(xiyuan): Remove this when app could be bundled with Chrome. ↪
--force-local-ntp ⊗	Forces Chrome to use localNTP instead of server (GWS) NTP. ↪
--force-login-manager-in-tests ⊗	Usually in browser tests the usual login manager bringup is skipped so that tests can change how it's brought up. This flag disables that. ↪
--force-mediafoundation[1] ⊗	Force the use of MediaFoundation for video capture. This is only supported in Windows 7 and above. Used, like |kForceDirectShowVideoCapture|, to troubleshoot problems in Windows platforms. ↪
--force-overlay-fullscreen-video ⊗	Forces use of hardware overlay for fullscreen video playback. Useful for testing the Android overlay fullscreen functionality on other platforms. ↪
--force-password-reauth ⊗	Enables forcing the user to reauth with their password after X hours (e.g. 20) without password entry. ↪
--force-pnacl-subzero ⊗	Force use of the Subzero as the PNaCl translator instead of LLC. ↪
--force-presentation-receiver-for-testing ⊗	This forces pages to be loaded as presentation receivers. Useful for testing behavior specific to presentation receivers. Spec: https://www.w3.org/TR/presentation-api/#interface-presentationreceiver ↪
--force-renderer-accessibility ⊗	Force renderer accessibility to be on instead of enabling it on demand when a screen reader is detected. The disable-renderer-accessibility switch overrides this if present. ↪
--force-show-update-menu-badge[6] ⊗	Forces the update menu badge to show. ↪
--force-show-update-menu-item[6] ⊗	Forces the update menu item to show. ↪
--force-system-compositor-mode ⊗	Force system compositor mode when set. ↪
--force-tablet-mode ⊗	Enables required things for the selected UI mode, regardless of whether the Chromebook is currently in the selected UI mode. ↪
--force-text-direction ⊗	Force the text rendering to a specific direction. Valid values are "ltr" (left-to-right) and "rtl" (right-to-left). Only tested meaningfully with RTL. ↪
--force-ui-direction ⊗	Force the UI to a specific direction. Valid values are "ltr" (left-to-right) and "rtl" (right-to-left). ↪
--force-variation-ids ⊗	Forces additional Chrome Variation Ids that will be sent in X-Client-Data header, specified as a 64-bit encoded list of numeric experiment ids. Ids prefixed with the character "t" will be treated as Trigger Variation Ids. ↪
--force-video-overlays ⊗	Force media player using SurfaceView instead of SurfaceTexture on Android. ↪
--force-wave-audio[1] ⊗	Use Windows WaveOut/In audio API even if Core Audio is supported. ↪
--force-webrtc-ip-handling-policy[13] ⊗	Override WebRTC IP handling policy to mimic the behavior when WebRTC IP handling policy is specified in Preferences. ↪
--full-memory-crash-report ⊗	Generates full memory crash dump. ↪
--gaia-url ⊗	No description ↪
--gcm-checkin-url ⊗	Sets the checkin service endpoint that will be used for performing Google Cloud Messaging checkins. ↪
--gcm-mcs-endpoint ⊗	Sets the Mobile Connection Server endpoint that will be used for Google Cloud Messaging. ↪
--gcm-registration-url ⊗	Sets the registration endpoint that will be used for creating new Google Cloud Messaging registrations. ↪
--generate-accessibility-test-expectations ⊗	For development / testing only. When running content_browsertests, saves output of failing accessibility tests to their expectations files in content/test/data/accessibility/, overwriting existing file content. ↪
--gl ⊗	No description ↪
--gl-composited-overlay-candidate-quad-border ⊗	TODO(dcastagna): Draw debug quad borders only when it is actually an overlay candidate. Renders a border around GL composited overlay candidate quads to help debug and study overlay support. ↪
--gl-shader-interm-output ⊗	Include ANGLE's intermediate representation (AST) output in shader compilation info logs. ↪
--gles ⊗	No description ↪
--golden-screenshots-dir ⊗	Screenshot testing: specifies the directory where the golden screenshots are stored. ↪
--google-apis-url ⊗	No description ↪
--google-base-url ⊗	Specifies an alternate URL to use for speaking to Google. Useful for testing. ↪
--google-doodle-url ⊗	Overrides the URL used to fetch the current Google Doodle. Example: https://www.google.com/async/ddljson ↪
--google-url ⊗	No description ↪
--gpu-active-device-id ⊗	Passes active gpu device id from browser process to GPU process. ↪
--gpu-active-vendor-id ⊗	Passes active gpu vendor id from browser process to GPU process. ↪
--gpu-device-id ⊗	Passes gpu device_id from browser process to GPU process. ↪
--gpu-driver-bug-workarounds ⊗	Pass a set of GpuDriverBugWorkaroundType ids, seperated by ','. ↪
--gpu-driver-date ⊗	Passes gpu driver_date from browser process to GPU process. ↪
--gpu-driver-vendor ⊗	Passes gpu driver_vendor from browser process to GPU process. ↪
--gpu-driver-version ⊗	Passes gpu driver_version from browser process to GPU process. ↪
--gpu-launcher ⊗	Extra command line options for launching the GPU process (normally used for debugging). Use like renderer-cmd-prefix. ↪
--gpu-no-complete-info-collection ⊗	Testing switch to not launch the gpu process for full gpu info collection. ↪
--gpu-no-context-lost ⊗	Inform Chrome that a GPU context will not be lost in power saving mode, screen saving mode, etc. Note that this flag does not ensure that a GPU context will never be lost in any situations, say, a GPU reset. ↪
--gpu-process ⊗	Makes this process a GPU sub-process. ↪
--gpu-program-cache-size-kb ⊗	Sets the maximum size of the in-memory gpu program cache, in kb ↪
--gpu-rasterization-msaa-sample-count ⊗	The number of multisample antialiasing samples for GPU rasterization. Requires MSAA support on GPU to have an effect. 0 disables MSAA. ↪
--gpu-sandbox-allow-sysv-shm ⊗	Allows shmat() system call in the GPU sandbox. ↪
--gpu-sandbox-failures-fatal ⊗	Makes GPU sandbox failures fatal. ↪
--gpu-sandbox-start-early ⊗	Starts the GPU sandbox before creating a GL context. ↪
--gpu-secondary-device-ids ⊗	Passes secondary gpu device ids from browser process to GPU process. ↪
--gpu-secondary-vendor-ids ⊗	Passes secondary gpu vendor ids from browser process to GPU process. ↪
--gpu-startup-dialog ⊗	Causes the GPU process to display a dialog on launch. ↪
--gpu-testing-device-id ⊗	Override gpu device id from the GpuInfoCollector. ↪
--gpu-testing-driver-date ⊗	Override gpu driver date from the GpuInfoCollector. ↪
--gpu-testing-gl-renderer ⊗	Override gl renderer from the GpuInfoCollector. ↪
--gpu-testing-gl-vendor ⊗	Override gl vendor from the GpuInfoCollector. ↪
--gpu-testing-gl-version ⊗	Override gl version from the GpuInfoCollector. ↪
--gpu-testing-os-version ⊗	Override os version from GpuControlList::MakeDecision. ↪
--gpu-testing-secondary-device-ids ⊗	Override secondary gpu device ids from the GpuInfoCollector. ↪
--gpu-testing-secondary-vendor-ids ⊗	Override secondary gpu vendor ids from the GpuInfoCollector. ↪
--gpu-testing-vendor-id ⊗	Override gpu vendor id from the GpuInfoCollector. ↪
--gpu-vendor-id ⊗	Passes gpu vendor_id from browser process to GPU process. ↪
--guest-wallpaper-large ⊗	Large wallpaper to use in guest mode (as path to trusted, non-user-writable JPEG file). ↪
--guest-wallpaper-small ⊗	Small wallpaper to use in guest mode (as path to trusted, non-user-writable JPEG file). ↪
--h[9] ⊗	No description ↪
--has-chromeos-diamond-key ⊗	If true, the Chromebook has a keyboard with a diamond key. ↪
--has-chromeos-keyboard ⊗	If set, the system is a Chromebook with a "standard Chrome OS keyboard", which generally means one with a Search key in the standard Caps Lock location above the Left Shift key. It should be unset for Chromebooks with both Search and Caps Lock keys (e.g. stout) and for devices like Chromeboxes that only use external keyboards. ↪
--has-internal-stylus ⊗	Whether this device has an internal stylus. ↪
--headless ⊗	Run in headless mode, i.e., without a UI or display server dependencies. ↪
--help ⊗	No description ↪
--hide ⊗	"Hide" value for kCrosRegionsMode (VPD values are hidden). ↪
--hide-icons[1] ⊗	Makes Windows happy by allowing it to show "Enable access to this program" checkbox in Add/Remove Programs->Set Program Access and Defaults. This only shows an error box because the only way to hide Chrome is by uninstalling it. ↪
--hide-scrollbars ⊗	Hide scrollbars from screenshots. ↪
--history-entry-requires-user-gesture ⊗	Don't allow content to arbitrarily append to the back/forward list. The page must prcoess a user gesture before an entry can be added. ↪
--homedir ⊗	Defines user homedir. This defaults to primary user homedir. ↪
--homepage ⊗	Specifies which page will be displayed in newly-opened tabs. We need this for testing purposes so that the UI tests don't depend on what comes up for http://google.com. ↪
--host ⊗	No description ↪
--host-pairing-oobe ⊗	With this switch, start remora OOBE with the pairing screen. ↪
--host-resolver-rules ⊗	These mappings only apply to the host resolver. ↪
--icu-data-dir ⊗	The path where ICU initialization data can be found. If not provided, the service binary's directory is assumed. ↪
--ignore-autocomplete-off-autofill ⊗	Ignores autocomplete="off" for Autofill data (profiles + credit cards). ↪
--ignore-autoplay-restrictions ⊗	Ignores all autoplay restrictions. It will ignore the current autoplay policy and all restrictions such as playback in a background tab. It should only be enabled for testing. ↪
--ignore-certificate-errors ⊗	Ignores certificate-related errors. ↪
--ignore-certificate-errors-spki-list ⊗	A set of public key hashes for which to ignore certificate-related errors. If the certificate chain presented by the server does not validate, and one or more certificates have public key hashes that match a key from this list, the error is ignored. The switch value must a be a comma-separated list of Base64-encoded SHA-256 SPKI Fingerprints (RFC 7469, Section 2.4). This switch has no effect unless --user-data-dir (as defined by the content embedder) is also present. ↪
--ignore-gpu-blacklist ⊗	Ignores GPU blacklist. ↪
--ignore-urlfetcher-cert-requests ⊗	Causes net::URLFetchers to ignore requests for SSL client certificates, causing them to attempt an unauthenticated SSL/TLS session. This is intended for use when testing various service URLs (eg: kPromoServerURL, kSbURLPrefix, kSyncServiceURL, etc). ↪
--ignore-user-profile-mapping-for-tests ⊗	If true, profile selection in UserManager will always return active user's profile. TODO(nkostlyev): http://crbug.com/364604 - Get rid of this switch after we turn on multi-profile feature on ChromeOS. ↪
--in-process-gpu ⊗	Run the GPU process as a thread in the browser process. ↪
--incognito ⊗	Causes the browser to launch directly in incognito mode. ↪
--input ⊗	No description ↪
--install-chrome-app ⊗	Causes Chrome to initiate an installation flow for the given app. ↪
--install-supervised-user-whitelists ⊗	A list of whitelists to install for a supervised user, for testing. The list is of the following form: <id>[:<name>],[<id>[:<name>],...] ↪
--instant-process ⊗	Marks a renderer as an Instant process. ↪
--invalidation-use-gcm-channel ⊗	Invalidation service should use GCM network channel even if experiment is not enabled. ↪
--ipc-connection-timeout ⊗	Overrides the timeout, in seconds, that a child process waits for a connection from the browser before killing itself. ↪
--ipc-dump-directory[23] ⊗	Dumps IPC messages sent from renderer processes to the browser process to the given directory. Used primarily to gather samples for IPC fuzzing. ↪
--ipc-fuzzer-testcase[23] ⊗	Specifies the testcase used by the IPC fuzzer. ↪
--is-running-in-mash ⊗	Chrome is running in Mash. ↪
--isolate-origins ⊗	Require dedicated processes for a set of origins, specified as a comma-separated list. For example: --isolate-origins=https://www.foo.com,https://www.bar.com ↪
--isolate-sites-for-testing ⊗	Enable site isolation (--site-per-process style isolation) for a subset of sites. The argument is a wildcard pattern which will be matched against the site URL to determine which sites to isolate. This can be used to isolate just one top-level domain, or just one scheme. Example usages: --isolate-sites-for-testing=*.com --isolate-sites-for-testing=https://* ↪
--javascript-harmony ⊗	Enables experimental Harmony (ECMAScript 6) features. ↪
--js-flags ⊗	Specifies the flags passed to JS engine ↪
--keep-alive-for-test ⊗	Used for testing - keeps browser alive after last browser window closes. ↪
--kiosk ⊗	Enable kiosk mode. Please note this is not Chrome OS kiosk mode. ↪
--kiosk-printing ⊗	Enable automatically pressing the print button in print preview. ↪
--lang ⊗	The language file that we want to try to open. Of the form language[-country] where language is the 2 letter code from ISO-639. ↪
--last-launched-app ⊗	Pass the app id information to the renderer process, to be used for logging. last-launched-app should be the app that just launched and is spawning the renderer. ↪
--layer ⊗	No description ↪
--light_muted ⊗	No description ↪
--light_vibrant ⊗	No description ↪
--limit-fps ⊗	Limits the compositor to output a certain number of frames per second, maximum. ↪
--load-and-launch-app ⊗	Loads an app from the specified directory and launches it. ↪
--load-apps ⊗	Comma-separated list of paths to apps to load at startup. The first app in the list will be launched. ↪
--load-extension ⊗	Comma-separated list of paths to extensions to load at startup. ↪
--load-media-router-component-extension ⊗	Loads the Media Router component extension on startup. ↪
--local-heuristics-only-for-password-generation ⊗	Removes the requirement that we recieved a ping from the autofill servers and that the user doesn't have the given form blacklisted. Used in testing. ↪
--local-ntp-reload[24] ⊗	Enables a live-reload for local NTP resources. This only works when Chrome is running from a Chrome source directory. ↪
--local-sync-backend-dir ⊗	Specifies the local sync backend directory. The name is chosen to mimic user-data-dir etc. This flag only matters if the enable-local-sync-backend flag is present. ↪
--log-gpu-control-list-decisions ⊗	Logs GPU control list decisions when enforcing blacklist rules. ↪
--log-level ⊗	Sets the minimum log level. Valid values are from 0 to 3: INFO = 0, WARNING = 1, LOG_ERROR = 2, LOG_FATAL = 3. ↪
--log-net-log ⊗	Enables saving net log events to a file and sets the file name to use. ↪
--login-manager ⊗	Enables Chrome-as-a-login-manager behavior. ↪
--login-profile ⊗	Specifies the profile to use once a chromeos user is logged in. This parameter is ignored if user goes through login screen since user_id hash defines which profile directory to use. In case of browser restart within active session this parameter is used to pass user_id hash for primary user. ↪
--login-user ⊗	Specifies the user which is already logged in. ↪
--loopback-i2s-bits ⊗	Used to pass configuration for the I2S input to enable loopback for AEC. ↪
--loopback-i2s-bus-name ⊗	No description ↪
--loopback-i2s-channels ⊗	No description ↪
--loopback-i2s-rate-hz ⊗	No description ↪
--lso-url ⊗	No description ↪
--ltr ⊗	No description ↪
--main-frame-resizes-are-orientation-changes ⊗	Resizes of the main frame are caused by changing between landscape and portrait mode (i.e. Android) so the page should be rescaled to fit. ↪
--make-chrome-default[7] ⊗	Indicates whether Chrome should be set as the default browser during installation. ↪
--make-default-browser ⊗	Makes Chrome default browser ↪
--managed-user-id ⊗	Sets the supervised user ID for any loaded or newly created profile to the given value. Pass an empty string to mark the profile as non-supervised. Used for testing. ↪
--managed-user-sync-token ⊗	Used to authenticate requests to the Sync service for supervised users. Setting this switch also causes Sync to be set up for a supervised user. ↪
--mark-non-secure-as ⊗	Use to opt-in to marking HTTP as non-secure. ↪
--market-url-for-testing[6] ⊗	Sets the market URL for Chrome for use in testing. ↪
--mash[25] ⊗	Used to enable Mus+ash. ↪
--material ⊗	Material design mode for the |kTopChromeMD| switch. ↪
--material-design-ink-drop-animation-speed ⊗	Defines the speed of Material Design visual feedback animations. ↪
--material-hybrid ⊗	Material design hybrid mode for the |kTopChromeMD| switch. Targeted for mouse/touch hybrid devices. ↪
--max-gum-fps[13] ⊗	Override the maximum framerate as can be specified in calls to getUserMedia. This flag expects a value. Example: --max-gum-fps=17.5 ↪
--max-output-volume-dba1m ⊗	Calibrated max output volume dBa for voice content at 1 meter, if known. ↪
--max-untiled-layer-height ⊗	Sets the width and height above which a composited layer will get tiled. ↪
--max-untiled-layer-width ⊗	No description ↪
--media-cache-size ⊗	Forces the maximum disk space to be used by the media cache, in bytes. ↪
--mem-pressure-system-reserved-kb ⊗	Some platforms typically have very little 'free' memory, but plenty is available in buffers+cached. For such platforms, configure this amount as the portion of buffers+cached memory that should be treated as unavailable. If this switch is not used, a simple pressure heuristic based purely on free memory will be used. ↪
--memlog[3] ⊗	Enables the out-of-process memory logging. ↪
--memory-pressure-off ⊗	No description ↪
--memory-pressure-thresholds ⊗	The memory pressure threshold selection which is used to decide whether and when a memory pressure event needs to get fired. ↪
--memory-pressure-thresholds-mb[1] ⊗	Sets the free memory thresholds below which the system is considered to be under moderate and critical memory pressure. Used in the browser process, and ignored if invalid. Specified as a pair of comma separated integers. See base/win/memory_pressure_monitor.cc for defaults. ↪
--message-center-changes-while-open ⊗	Flag to enable or disable notification changes while the message center opens. This flag will be removed once the feature gets stable. ↪
--method ⊗	No description ↪
--metrics-client-id[7] ⊗	This is how the metrics client ID is passed from the browser process to its children. With Crashpad, the metrics client ID is distinct from the crash client ID. ↪
--metrics-recording-only ⊗	Enables the recording of metrics reports but disables reporting. In contrast to kDisableMetrics, this executes all the code that a normal client would use for reporting, except the report is dropped rather than sent to the server. This is useful for finding issues in the metrics code during UI and performance tests. ↪
--mhtml-generator-option ⊗	Sets options for MHTML generator to skip no-store resources: "skip-nostore-main" - fails to save a page if main frame is 'no-store' "skip-nostore-all" - also skips no-store subresources. ↪
--mirror[2] ⊗	Values for the kAccountConsistency flag. ↪
--mock ⊗	No description ↪
--mojo-local-storage ⊗	Use a Mojo-based LocalStorage implementation. ↪
--mojo-pipe-token ⊗	No description ↪
--monitoring-destination-id ⊗	Allows setting a different destination ID for connection-monitoring GCM messages. Useful when running against a non-prod management server. ↪
--mse-audio-buffer-size-limit ⊗	Allows explicitly specifying MSE audio/video buffer sizes. Default values are 150M for video and 12M for audio. ↪
--mse-video-buffer-size-limit ⊗	No description ↪
--mus[25] ⊗	Used to enable mus as a separate process, but chrome+ash still together. ↪
--mus-config[25] ⊗	This is added to child processes launched from mash or mus. The value of this switch is either kMus or kMash. For example, if chrome is run with '--mash' then the child process representing ash is launched with the switch '--mus-config=mash'. ↪
--mute-audio ⊗	Mutes audio sent to the audio device so it is not audible during automated testing. ↪
--nacl-broker ⊗	Value for --type that causes the process to run as a NativeClient broker (used for launching NaCl loader processes on 64-bit Windows). ↪
--nacl-dangerous-no-sandbox-nonsfi ⊗	Disable sandbox even for non SFI mode. This is particularly unsafe as non SFI NaCl heavily relies on the seccomp sandbox. ↪
--nacl-debug-mask ⊗	Uses NaCl manifest URL to choose whether NaCl program will be debugged by debug stub. Switch value format: [!]pattern1,pattern2,...,patternN. Each pattern uses the same syntax as patterns in Chrome extension manifest. The only difference is that * scheme matches all schemes instead of matching only http and https. If the value doesn't start with !, a program will be debugged if manifest URL matches any pattern. If the value starts with !, a program will be debugged if manifest URL does not match any pattern. ↪
--nacl-gdb ⊗	Native Client GDB debugger that will be launched automatically when needed. ↪
--nacl-gdb-script ⊗	GDB script to pass to the nacl-gdb debugger at startup. ↪
--nacl-loader ⊗	Value for --type that causes the process to run as a NativeClient loader for SFI mode. ↪
--nacl-loader-nonsfi ⊗	Value for --type that causes the process to run as a NativeClient loader for non SFI mode. ↪
--native ⊗	Report native (walk the stack) allocation traces. By default pseudo stacks derived from trace events are reported. ↪
--native-crx-bindings ⊗	Enables the use of C++-based extension bindings (instead of JS generation). ↪
--need-arc-migration-policy-check ⊗	If present, the device needs to check the policy to see if the migration to ext4 for ARC is allowed. It should be present only on devices that have been initially issued with ecrypfs encryption and have ARC (N+) available. For the devices in other categories this flag must be missing. ↪
--net-log-capture-mode ⊗	Sets the granularity of events to capture in the network log. The mode can be set to one of the following values: "Default" "IncludeCookiesAndCredentials" "IncludeSocketBytes" See the functions of the corresponding name in net_log_capture_mode.h for a description of their meaning. ↪
--netifs-to-ignore ⊗	List of network interfaces to ignore. Ignored interfaces will not be used for network connectivity. ↪
--network-country-iso[6] ⊗	The telephony region (ISO country code) to use in phone number detection. ↪
--network-settings-config ⊗	Enables Settings based network config in MD Settings. ↪
--new-window ⊗	Launches URL in new browser window. ↪
--no-default-browser-check ⊗	Disables the default browser check. Useful for UI/browser tests where we want to avoid having the default browser info-bar displayed. ↪
--no-experiments ⊗	Disables all experiments set on about:flags. Does not disable about:flags itself. Useful if an experiment makes chrome crash at startup: One can start chrome with --no-experiments, disable the problematic lab at about:flags and then restart chrome without this switch again. ↪
--no-first-run ⊗	Skip First Run tasks, whether or not it's actually the First Run. Overridden by kForceFirstRun. This does not drop the First Run sentinel and thus doesn't prevent first run from occuring the next time chrome is launched without this flag. ↪
--no-managed-user-acknowledgment-check ⊗	Disables checking whether we received an acknowledgment when registering a supervised user. Also disables the timeout during registration that waits for the ack. Useful when debugging against a server that does not support notifications. ↪
--no-network-profile-warning[1] ⊗	Whether or not the browser should warn if the profile is on a network share. This flag is only relevant for Windows currently. ↪
--no-pings ⊗	Don't send hyperlink auditing pings ↪
--no-proxy-server ⊗	Don't use a proxy server, always make direct connections. Overrides any other proxy server flags that are passed. ↪
--no-referrers ⊗	Don't send HTTP-Referer headers. ↪
--no-sandbox ⊗	Disables the sandbox for all process types that are normally sandboxed. ↪
--no-service-autorun ⊗	Disables the service process from adding itself as an autorun process. This does not delete existing autorun registrations, it just prevents the service from registering a new one. ↪
--no-session-id ⊗	No description ↪
--no-startup-window ⊗	Does not automatically open a browser window on startup (used when launching Chrome for the purpose of hosting background apps). ↪
--no-user-gesture-required ⊗	Autoplay policy that does not require any user gesture. ↪
--no-wifi ⊗	Disable features that require WiFi management. ↪
--no-zygote ⊗	Disables the use of a zygote process for forking child processes. Instead, child processes will be forked and exec'd directly. Note that --no-sandbox should also be used together with this flag because the sandbox needs the zygote to work. ↪
--noerrdialogs ⊗	Suppresses all error dialogs when present. ↪
--non-material ⊗	Classic, non-material, mode for the |kTopChromeMD| switch. ↪
--non-secure ⊗	No description ↪
--non-secure-after-editing ⊗	No description ↪
--non-secure-while-incognito ⊗	No description ↪
--non-secure-while-incognito-or-editing ⊗	No description ↪
--none ⊗	No description ↪
--normal_muted ⊗	No description ↪
--normal_vibrant ⊗	No description ↪
--note-taking-app-ids ⊗	An optional comma-separated list of IDs of apps that can be used to take notes. If unset, a hardcoded list is used instead. ↪
--ntp-snippets-add-incomplete ⊗	If this flag is set, we will add downloaded snippets that are missing some critical data to the list. ↪
--ntp-switch-to-existing-tab[6] ⊗	Switch to an existing tab for a suggestion opened from the New Tab Page. ↪
--null ⊗	No description ↪
--num-raster-threads ⊗	Number of worker threads used to rasterize content. ↪
--oauth2-client-id ⊗	No description ↪
--oauth2-client-secret ⊗	No description ↪
--off ⊗	No description ↪
--on ⊗	No description ↪
--oobe-bootstrapping-master ⊗	Indicates that if we should start bootstrapping Master OOBE. ↪
--oobe-force-show-screen ⊗	Forces OOBE/login to force show a comma-separated list of screens from chromeos::kScreenNames in oobe_screen.cc. Supported screens are: user-image ↪
--oobe-guest-session ⊗	Indicates that a guest session has been started before OOBE completion. ↪
--oobe-skip-postlogin ⊗	Skips all other OOBE pages after user login. ↪
--oobe-timer-interval ⊗	Interval at which we check for total time on OOBE. ↪
--open-ash[26] ⊗	No description ↪
--opengraph ⊗	No description ↪
--origin-trial-disabled-features ⊗	Contains a list of feature names for which origin trial experiments should be disabled. Names should be separated by "|" characters. ↪
--origin-trial-disabled-tokens ⊗	Contains a list of token signatures for which origin trial experiments should be disabled. Tokens should be separated by "|" characters. ↪
--origin-trial-public-key ⊗	Overrides the default public key for checking origin trial tokens. ↪
--original-process-start-time ⊗	The time that a new chrome process which is delegating to an already running chrome process started. (See ProcessSingleton for more details.) ↪
--osmesa ⊗	No description ↪
--output ⊗	No description ↪
--override ⊗	"Override" value for kCrosRegionsMode (region's data is read first). ↪
--override-metrics-upload-url ⊗	Override the URL to which metrics logs are sent for debugging. ↪
--override-plugin-power-saver-for-testing ⊗	Override the behavior of plugin throttling for testing. By default the throttler is only enabled for a hard-coded list of plugins. Set the value to 'always' to always throttle every plugin instance. Set the value to 'never' to disable throttling. ↪
--override-use-software-gl-for-tests ⊗	Forces the use of software GL instead of hardware gpu. ↪
--overscroll-history-navigation ⊗	Controls the behavior of history navigation in response to horizontal overscroll. Set the value to '0' to disable. Set the value to '1' to enable the behavior where pages slide in and out in response to the horizontal overscroll gesture and a screenshot of the target page is shown. Set the value to '2' to enable the simplified overscroll UI where a navigation arrow slides in from the side of the screen in response to the horizontal overscroll gesture. Defaults to '1'. ↪
--overscroll-start-threshold ⊗	Controls the value of the threshold to start horizontal overscroll relative to the default value. E.g. set the value to '133' to have the overscroll start threshold be 133% of the default threshold. ↪
--ozone-dump-file ⊗	Specify location for image dumps. ↪
--ozone-platform ⊗	Specify ozone platform implementation to use. ↪
--pack-extension ⊗	Packages an extension to a .crx installable file from a given directory. ↪
--pack-extension-key ⊗	Optional PEM private key to use in signing packaged .crx. ↪
--parent-profile ⊗	Specifies the path to the user data folder for the parent profile. ↪
--parent-window ⊗	No description ↪
--passive-listeners-default ⊗	Override the default value for the 'passive' field in javascript addEventListener calls. Values are defined as: 'documentonlytrue' to set the default be true only for document level nodes. 'true' to set the default to be true on all nodes (when not specified). 'forcealltrue' to force the value on all nodes. ↪
--password-store[9] ⊗	Specifies which encryption storage backend to use. Possible values are kwallet, kwallet5, gnome, gnome-keyring, gnome-libsecret, basic. Any other value will lead to Chrome detecting the best backend automatically. TODO(crbug.com/571003): Once PasswordStore no longer uses the Keyring or KWallet for storing passwords, rename this flag to stop referencing passwords. Do not rename it sooner, though; developers and testers might rely on it keeping large amounts of testing passwords out of their Keyrings or KWallets. ↪
--permission-request-api-scope ⊗	Development flag for permission request API. This flag is needed until the API is finalized. TODO(bauerb): Remove when this flag is not needed anymore. ↪
--permission-request-api-url ⊗	Development flag for permission request API. This flag is needed until the API is finalized. TODO(bauerb): Remove when this flag is not needed anymore. ↪
--ppapi ⊗	Argument to the process type that indicates a PPAPI plugin process type. ↪
--ppapi-antialiased-text-enabled[1] ⊗	The boolean value (0/1) of FontRenderParams::antialiasing to be passed to Ppapi processes. ↪
--ppapi-broker ⊗	Argument to the process type that indicates a PPAPI broker process type. ↪
--ppapi-flash-args ⊗	"Command-line" arguments for the PPAPI Flash; used for debugging options. ↪
--ppapi-flash-path ⊗	Use the PPAPI (Pepper) Flash found at the given path. ↪
--ppapi-flash-version ⊗	Report the given version for the PPAPI (Pepper) Flash. The version should be numbers separated by '.'s (e.g., "12.3.456.78"). If not specified, it defaults to "10.2.999.999". ↪
--ppapi-in-process ⊗	Runs PPAPI (Pepper) plugins in-process. ↪
--ppapi-plugin-launcher ⊗	Specifies a command that should be used to launch the ppapi plugin process. Useful for running the plugin process through purify or quantify. Ex: --ppapi-plugin-launcher="path\to\purify /Run=yes" ↪
--ppapi-startup-dialog ⊗	Causes the PPAPI sub process to display a dialog on launch. Be sure to use --no-sandbox as well or the sandbox won't allow the dialog to display. ↪
--ppapi-subpixel-rendering-setting[1] ⊗	The enum value of FontRenderParams::subpixel_rendering to be passed to Ppapi processes. ↪
--prerender-from-omnibox ⊗	Triggers prerendering of pages from suggestions in the omnibox. Only has an effect when Instant is either disabled or restricted to search, and when prerender is enabled. ↪
--previous-app ⊗	previous-app should be the app that was running when last-launched-app started. ↪
--primary ⊗	No description ↪
--print-to-pdf ⊗	Save a pdf file of the loaded page. ↪
--privet-ipv6-only ⊗	Use IPv6 only for privet HTTP. ↪
--process-per-site ⊗	Enable the "Process Per Site" process model for all domains. This mode consolidates same-site pages so that they share a single process. More details here: - http://www.chromium.org/developers/design-documents/process-models - The class comment in site_instance.h, listing the supported process models. IMPORTANT: This isn't to be confused with --site-per-process (which is about isolation, not consolidation). You probably want the other one. ↪
--process-per-tab ⊗	Runs each set of script-connected tabs (i.e., a BrowsingInstance) in its own renderer process. We default to using a renderer process for each site instance (i.e., group of pages from the same registered domain with script connections to each other). TODO(creis): This flag is currently a no-op. We should refactor it to avoid "unnecessary" process swaps for cross-site navigations but still swap when needed for security (e.g., isolated origins). ↪
--product-version ⊗	Outputs the product version information and quit. Used as an internal api to detect the installed version of Chrome on Linux. ↪
--profile-directory ⊗	Selects directory of profile to associate with the first browser launched. ↪
--profiler-timing ⊗	Configure whether chrome://profiler will contain timing information. This option is enabled by default. A value of "0" will disable profiler timing, while all other values will enable it. ↪
--profiling-at-start ⊗	Starts the sampling based profiler for the browser process at startup. This will only work if chrome has been built with the gyp variable profiling=1. The output will go to the value of kProfilingFile. ↪
--profiling-file ⊗	Specifies a location for profiling output. This will only work if chrome has been built with the gyp variable profiling=1 or gn arg enable_profiling=true. {pid} if present will be replaced by the pid of the process. {count} if present will be incremented each time a profile is generated for this process. The default is chrome-profile-{pid} for the browser and test-profile-{pid} for tests. ↪
--profiling-flush ⊗	Controls whether profile data is periodically flushed to a file. Normally the data gets written on exit but cases exist where chrome doesn't exit cleanly (especially when using single-process). A time in seconds can be specified. ↪
--progress-bar-animation[6] ⊗	Specifies Android phone page loading progress bar animation. ↪
--progress-bar-completion[6] ⊗	When blink should declare a load "done" for the purpose of the progress bar. ↪
--prompt-for-external-extensions[27] ⊗	Should we prompt the user before allowing external extensions to install? This flag is available on Chromium for testing purposes. ↪
--proxy-auto-detect ⊗	Forces proxy auto-detection. ↪
--proxy-bypass-list ⊗	Specifies a list of hosts for whom we bypass proxy settings and use direct connections. Ignored unless --proxy-server is also specified. This is a comma-separated list of bypass rules. See: "net/proxy/proxy_bypass_rules.h" for the format of these rules. ↪
--proxy-pac-url ⊗	Uses the pac script at the given URL ↪
--proxy-server ⊗	Uses a specified proxy server, overrides system settings. This switch only affects HTTP and HTTPS requests. ↪
--pull-to-refresh ⊗	Enables or disables pull-to-refresh gesture in response to vertical overscroll. Set the value to '1' to enable the feature, and set to '0' to disable. Defaults to disabled. ↪
--rdp_desktop_session ⊗	No description ↪
--reader-mode-feedback ⊗	No description ↪
--reader-mode-heuristics ⊗	No description ↪
--rebaseline-pixel-tests[4] ⊗	Makes browser pixel tests overwrite the reference if it does not match. ↪
--record-type ⊗	No description ↪
--reduce-security-for-testing ⊗	Enables more web features over insecure connections. Designed to be used for testing purposes only. ↪
--reduced-referrer-granularity ⊗	Reduce the default `referer` header's granularity. ↪
--register-font-files ⊗	Registers additional font files on Windows (for fonts outside the usual %WINDIR%\Fonts location). Multiple files can be used by separating them with a semicolon (;). ↪
--register-pepper-plugins ⊗	Register Pepper plugins (see pepper_plugin_list.cc for its format). ↪
--relauncher[7] ⊗	A process type (switches::kProcessType) that relaunches the browser. See chrome/browser/mac/relauncher.h. ↪
--remote-debugging-address ⊗	Use the given address instead of the default loopback for accepting remote debugging connections. Should be used together with --remote-debugging-port. Note that the remote debugging protocol does not perform any authentication, so exposing it too widely can be a security risk. ↪
--remote-debugging-port ⊗	Enables remote debug over HTTP on the specified port. ↪
--remote-debugging-socket-fd ⊗	The given value is the fd of a socket already opened by the parent process. This allows automation to provide a listening socket for clients to connect to before chrome is fully fired up. In particular, a parent process can open the port, exec headles chrome, and connect to the devtools port immediately. Waiting for chrome to be ready is then handled by the first read from the port, which will block until chrome is ready. No polling is needed. ↪
--remote-debugging-socket-name[6] ⊗	Enables remote debug over HTTP on the specified socket name. ↪
--remote-debugging-targets ⊗	Porvides a list of addresses to discover DevTools remote debugging targets. The format is <host>:<port>,...,<host>:port. ↪
--renderer ⊗	Causes the process to run as renderer instead of as browser. ↪
--renderer-client-id ⊗	No description ↪
--renderer-cmd-prefix ⊗	The contents of this flag are prepended to the renderer command line. Useful values might be "valgrind" or "xterm -e gdb --args". ↪
--renderer-process-limit ⊗	Overrides the default/calculated limit to the number of renderer processes. Very high values for this setting can lead to high memory/resource usage or instability. ↪
--renderer-startup-dialog ⊗	Causes the renderer process to display a dialog on launch. Passing this flag also adds kNoSandbox on Windows non-official builds, since that's needed to show a dialog. ↪
--renderer-wait-for-java-debugger[6] ⊗	Block ChildProcessMain thread of the renderer's ChildProcessService until a Java debugger is attached. ↪
--renderpass ⊗	No description ↪
--repl ⊗	Runs a read-eval-print loop that allows the user to evaluate Javascript expressions. ↪
--report-vp9-as-an-unsupported-mime-type ⊗	Force to report VP9 as an unsupported MIME type. ↪
--require-audio-hardware-for-testing ⊗	When running tests on a system without the required hardware or libraries, this flag will cause the tests to fail. Otherwise, they silently succeed. ↪
--reset-app-list-install-state ⊗	If set, the app list will forget it has been installed on startup. Note this doesn't prevent the app list from running, it just makes Chrome think the app list hasn't been enabled (as in kEnableAppList) yet. ↪
--reset-variation-state ⊗	Forces a reset of the one-time-randomized FieldTrials on this client, also known as the Chrome Variations state. ↪
--restore-last-session ⊗	Indicates the last session should be restored on startup. This overrides the preferences value. Note that this does not force automatic session restore following a crash, so as to prevent a crash loop. This switch is used to implement support for OS-specific "continue where you left off" functionality on OS X and Windows. ↪
--root-layer-scrolls ⊗	Handles frame scrolls via the root RenderLayer instead of the FrameView. ↪
--rtl ⊗	No description ↪
--run-all-compositor-stages-before-draw ⊗	Effectively disables pipelining of compositor frame production stages by waiting for each stage to finish before completing a frame. ↪
--run-layout-test ⊗	Request the render trees of pages to be dumped as text once they have finished loading. ↪
--safebrowsing-disable-auto-update ⊗	If present, safebrowsing only performs update when SafeBrowsingProtocolManager::ForceScheduleNextUpdate() is explicitly called. This is used for testing only. ↪
--safebrowsing-disable-download-protection ⊗	TODO(lzheng): Remove this flag once the feature works fine (http://crbug.com/74848). Disables safebrowsing feature that checks download url and downloads content's hash to make sure the content are not malicious. ↪
--safebrowsing-disable-extension-blacklist ⊗	Disables safebrowsing feature that checks for blacklisted extensions. ↪
--safebrowsing-manual-download-blacklist ⊗	List of comma-separated sha256 hashes of executable files which the download-protection service should treat as "dangerous." For a file to show a warning, it also must be considered a dangerous filetype and not be whitelisted otherwise (by signature or URL) and must be on a supported OS. Hashes are in hex. This is used for manual testing when looking for ways to by-pass download protection. ↪
--SafeSites ⊗	No description ↪
--sandbox-ipc ⊗	Causes the process to run as a sandbox IPC subprocess. ↪
--save-page-as-mhtml ⊗	Disable saving pages as HTML-only, disable saving pages as HTML Complete (with a directory of sub-resources). Enable only saving pages as MHTML. See http://crbug.com/120416 for how to remove this switch. ↪
--screen-config ⊗	Specifies the initial screen configuration, or state of all displays, for FakeDisplayDelegate, see class for format details. ↪
--screenshot ⊗	Save a screenshot of the loaded page. ↪
--scripts-require-action ⊗	Notify the user and require consent for extensions running scripts. Appending --scripts-require-action=1 has the same effect as --enable-scripts-require-action (see below). ↪
--search-provider-logo-url ⊗	Use a static URL for the logo of the default search engine. Example: https://www.google.com/branding/logo.png ↪
--secondary ⊗	No description ↪
--secondary-display-layout ⊗	Specifies the layout mode and offsets for the secondary display for testing. The format is "<t|r|b|l>,<offset>" where t=TOP, r=RIGHT, b=BOTTOM and L=LEFT. For example, 'r,-100' means the secondary display is positioned on the right with -100 offset. (above than primary) ↪
--secondary-ui-md ⊗	Applies the material design mode passed via --top-chrome-md to elements throughout Chrome (not just top Chrome). ↪
--service ⊗	The process type value which causes a process to run as a cloud print service process. DO NOT CHANGE THIS VALUE. Cloud printing relies on an external binary launching Chrome with this process type. ↪
--service-manager ⊗	The value of the |kProcessType| switch which tells the executable to assume the role of a standalone Service Manager instance. ↪
--service-name ⊗	Specified on the command line of service processes to indicate which service should be run. Useful when the service process binary may act as one of many different embedded services. ↪
--service-pipe-token ⊗	Provides a child process with a token string they can exchange for a message pipe whose other end is bound to a service_manager::Service binding in the Service Manager. ↪
--service-request-channel-token ⊗	The token to use to construct the message pipe for a service in a child process. ↪
--service-runner ⊗	The value of the |kProcessType| switch which tells the executable to assume the role of a service instance. ↪
--shared-files ⊗	Describes the file descriptors passed to a child process in the following list format: <file_id>:<descriptor_id>,<file_id>:<descriptor_id>,... where <file_id> is an ID string from the manifest of the service being launched and <descriptor_id> is the numeric identifier of the descriptor for the child process can use to retrieve the file descriptor from the global descriptor table. ↪
--shill-stub ⊗	Overrides network stub behavior. By default, ethernet, wifi and vpn are enabled, and transitions occur instantaneously. Multiple options can be comma separated (no spaces). Note: all options are in the format 'foo=x'. Values are case sensitive and based on Shill names in service_constants.h. See FakeShillManagerClient::SetInitialNetworkState for implementation. Examples: 'clear=1' - Clears all default configurations 'wifi=on' - A wifi network is initially connected ('1' also works) 'wifi=off' - Wifi networks are all initially disconnected ('0' also works) 'wifi=disabled' - Wifi is initially disabled 'wifi=none' - Wifi is unavailable 'wifi=portal' - Wifi connection will be in Portal state 'cellular=1' - Cellular is initially connected 'cellular=LTE' - Cellular is initially connected, technology is LTE 'interactive=3' - Interactive mode, connect/scan/etc requests take 3 secs ↪
--show-app-list ⊗	If true the app list will be shown. ↪
--show-autofill-signatures ⊗	Annotates forms and fields with Autofill signatures. ↪
--show-autofill-type-predictions ⊗	Annotates forms with Autofill field type predictions. ↪
--show-cert-link ⊗	If true the Certificate link will be shown in Page Info for HTTPS pages. ↪
--show-component-extension-options ⊗	Makes component extensions appear in chrome://settings/extensions. ↪
--show-composited-layer-borders ⊗	Renders a border around compositor layers to help debug and study layer compositing. ↪
--show-fps-counter ⊗	Draws a heads-up-display showing Frames Per Second as well as GPU memory usage. If you also use --enable-logging=stderr --vmodule="head*=1" then FPS will also be output to the console log. ↪
--show-icons[1] ⊗	See kHideIcons. ↪
--show-layer-animation-bounds ⊗	Renders a border that represents the bounding box for the layer's animation. ↪
--show-login-dev-overlay ⊗	If true, the developer tool overlay will be shown for the login/lock screen. This makes it easier to test layout logic. ↪
--show-mac-overlay-borders[11] ⊗	Show borders around CALayers corresponding to overlays and partial damage. ↪
--show-md-login ⊗	If true, the views-based md login and lock screens will be shown. ↪
--show-non-md-login ⊗	If true, the non-md login and lock screens will be shown. ↪
--show-overdraw-feedback ⊗	Visualize overdraw by color-coding elements based on if they have other elements drawn underneath. This is good for showing where the UI might be doing more rendering work than necessary. The colors are hinting at the amount of overdraw on your screen for each pixel, as follows: True color: No overdraw. Blue: Overdrawn once. Green: Overdrawn twice. Pink: Overdrawn three times. Red: Overdrawn four or more times. ↪
--show-paint-rects ⊗	Visibly render a border around paint rects in the web page to help debug and study painting behavior. ↪
--show-property-changed-rects ⊗	Show rects in the HUD around layers whose properties have changed. ↪
--show-saved-copy ⊗	Command line flag offering a "Show saved copy" option to the user if offline. The various modes are disabled, primary, or secondary. Primary/secondary refers to button placement (for experiment). ↪
--show-screenspace-rects ⊗	Show rects in the HUD around the screen-space transformed bounds of every layer. ↪
--show-surface-damage-rects ⊗	Show rects in the HUD around damage as it is recorded into each render surface. ↪
--silent-debugger-extension-api ⊗	Does not show an infobar when an extension attaches to a page using chrome.debugger page. Required to attach to extension background pages. ↪
--silent-launch ⊗	Causes Chrome to launch without opening any windows by default. Useful if one wishes to use Chrome as an ash server. ↪
--simulate-critical-update ⊗	Simulates a critical update being available. ↪
--simulate-elevated-recovery ⊗	Simulates that elevation is needed to recover upgrade channel. ↪
--simulate-outdated ⊗	Simulates that current version is outdated. ↪
--simulate-outdated-no-au ⊗	Simulates that current version is outdated and auto-update is off. ↪
--simulate-upgrade ⊗	Simulates an update being available. ↪
--single-process ⊗	Runs the renderer and plugins in the same process as the browser ↪
--site-per-process ⊗	Enforces a one-site-per-process security policy: * Each renderer process, for its whole lifetime, is dedicated to rendering pages for just one site. * Thus, pages from different sites are never in the same process. * A renderer process's access rights are restricted based on its site. * All cross-site navigations force process swaps. * <iframe>s are rendered out-of-process whenever the src= is cross-site. More details here: - http://www.chromium.org/developers/design-documents/site-isolation - http://www.chromium.org/developers/design-documents/process-models - The class comment in site_instance.h, listing the supported process models. IMPORTANT: this isn't to be confused with --process-per-site (which is about process consolidation, not isolation). You probably want this one. ↪
--skip-gpu-data-loading ⊗	Skip gpu info collection, blacklist loading, and blacklist auto-update scheduling at browser startup time. Therefore, all GPU features are available, and about:gpu page shows empty content. The switch is intended only for layout tests. TODO(gab): Get rid of this switch entirely. ↪
--skip-nostore-all ⊗	No description ↪
--skip-nostore-main ⊗	No description ↪
--skip-reencoding-on-skp-capture ⊗	Skips reencoding bitmaps as PNGs when the encoded data is unavailable during SKP capture. This allows for obtaining an accurate sample of the types of images on the web, rather than being weighted towards PNGs that we have encoded ourselves. ↪
--slow ⊗	Defines that Material Design visual feedback animations should be slow. ↪
--slow-connections-only ⊗	No description ↪
--slow-down-raster-scale-factor ⊗	Re-rasters everything multiple times to simulate a much slower machine. Give a scale factor to cause raster to take that many times longer to complete, such as --slow-down-raster-scale-factor=25. ↪
--sms-test-messages ⊗	Sends test messages on first call to RequestUpdate (stub only). ↪
--spdy-proxy-auth-fallback ⊗	The origin of the data reduction proxy fallback. ↪
--spdy-proxy-auth-origin ⊗	The origin of the data reduction proxy. ↪
--spdy-proxy-auth-value ⊗	A test key for data reduction proxy authentication. ↪
--spelling-service-feedback-interval-seconds[21] ⊗	Specifies the number of seconds between sending batches of feedback to spelling service. The default is 30 minutes. The minimum is 5 seconds. This switch is for temporary testing only. TODO(rouslan): Remove this flag when feedback testing is complete. Revisit by August 2013. ↪
--spelling-service-feedback-url[21] ⊗	Specifies the URL where spelling service feedback data will be sent instead of the default URL. This switch is for temporary testing only. TODO(rouslan): Remove this flag when feedback testing is complete. Revisit by August 2013. ↪
--spurious-power-button-accel-count ⊗	Number of recent acceleration samples that must meet or exceed the threshold in order for a power button event to be considered spurious. ↪
--spurious-power-button-keyboard-accel ⊗	Threshold (in m/s^2, disregarding gravity) that keyboard acceleration must meet or exceed for a power button event to be considered spurious. ↪
--spurious-power-button-lid-angle-change ⊗	Change in lid angle (i.e. hinge between keyboard and screen) that must be exceeded for a power button event to be considered spurious. ↪
--spurious-power-button-screen-accel ⊗	Threshold (in m/s^2, disregarding gravity) that screen acceleration must meet or exceed for a power button event to be considered spurious. ↪
--spurious-power-button-window ⊗	Number of recent accelerometer samples to examine to determine if a power button event was spurious. ↪
--ssl-key-log-file ⊗	Causes SSL key material to be logged to the specified file for debugging purposes. See https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/Key_Log_Format for the format. ↪
--ssl-version-max ⊗	Specifies the maximum SSL/TLS version ("tls1", "tls1.1", "tls1.2", or "tls1.3"). ↪
--ssl-version-min ⊗	Specifies the minimum SSL/TLS version ("tls1", "tls1.1", "tls1.2", or "tls1.3"). ↪
--stable-release-mode ⊗	This makes us disable some web-platform runtime features so that we test content_shell as if it was a stable release. It is only followed when kRunLayoutTest is set. For the features' level, see http://dev.chromium.org/blink/runtime-enabled-features. ↪
--start-fullscreen ⊗	Specifies if the browser should start in fullscreen mode, like if the user had pressed F11 right after startup. ↪
--start-maximized ⊗	Starts the browser maximized, regardless of any previous settings. ↪
--start-stack-profiler ⊗	Starts the stack sampling profiler in the child process. ↪
--started ⊗	Value for kTestCrosGaiaIdMigration indicating that migration is started (i.e. all stored user keys will be converted to GaiaId) ↪
--stub ⊗	No description ↪
--stub-cros-settings ⊗	Indicates that a stub implementation of CrosSettings that stores settings in memory without signing should be used, treating current user as the owner. This also modifies OwnerSettingsServiceChromeOS::HandlesSetting such that no settings are handled by OwnerSettingsServiceChromeOS. This option is for testing the chromeos build of chrome on the desktop only. ↪
--supports-dual-gpus ⊗	Indicates whether the dual GPU switching is supported or not. ↪
--surface ⊗	No description ↪
--swiftshader ⊗	No description ↪
--swiftshader-webgl ⊗	No description ↪
--sync-allow-insecure-xmpp-connection ⊗	Allows insecure XMPP connections for sync (for testing). ↪
--sync-deferred-startup-timeout-seconds ⊗	Allows overriding the deferred init fallback timeout. ↪
--sync-disable-deferred-startup ⊗	Enables deferring sync backend initialization until user initiated changes occur. ↪
--sync-enable-get-update-avoidance ⊗	Enables feature to avoid unnecessary GetUpdate requests. ↪
--sync-notification-host-port ⊗	Overrides the default host:port used for notifications. ↪
--sync-on-draw-hardware ⊗	No description ↪
--sync-short-initial-retry-override ⊗	This flag causes sync to retry very quickly (see polling_constants.h) the when it encounters an error, as the first step towards exponential backoff. ↪
--sync-short-nudge-delay-for-test ⊗	This flag significantly shortens the delay between nudge cycles. Its primary purpose is to speed up integration tests. The normal delay allows coalescing and prevention of server overload, so don't use this unless you're really sure that it's what you want. ↪
--sync-url ⊗	Overrides the default server used for profile sync. ↪
--system-developer-mode ⊗	Indicates that the system is running in dev mode. The dev mode probing is done by session manager. ↪
--system-log-upload-frequency ⊗	Frequency in Milliseconds for system log uploads. Should only be used for testing purposes. ↪
--tab-management-experiment-type-disabled[6] ⊗	Specifies a particular tab management experiment to enable. ↪
--tab-management-experiment-type-elderberry[6] ⊗	No description ↪
--task-manager-show-extra-renderers ⊗	Sets the task manager to track extra renderer processes that might not normally be displayed in the task manager. ↪
--task-profiler ⊗	Report per-task heap usage and churn in the task profiler. Does not keep track of individual allocations unlike the default and native mode. Keeps only track of summarized churn stats in the task profiler (chrome://profiler). ↪
--team-drives ⊗	Enables or disables Team Drives integration. ↪
--test-auto-update-ui ⊗	Enables testing for auto update UI. ↪
--test-child-process ⊗	When running certain tests that spawn child processes, this switch indicates to the test framework that the current process is a child process. ↪
--test-cros-gaia-id-migration ⊗	Controls CrOS GaiaId migration for tests ("" is default). ↪
--test-do-not-initialize-icu ⊗	When running certain tests that spawn child processes, this switch indicates to the test framework that the current process should not initialize ICU to avoid creating any scoped handles too early in startup. ↪
--test-encryption-migration-ui ⊗	Enables testing for encryption migration UI. ↪
--test-gl-lib ⊗	Flag used for Linux tests: for desktop GL bindings, try to load this GL library first, but fall back to regular library if loading fails. ↪
--test-name ⊗	Passes the name of the current running automated test to Chrome. ↪
--test-type ⊗	Type of the current test harness ("browser" or "ui"). ↪
--testing-fixed-http-port ⊗	Allows for forcing socket connections to http/https to use fixed ports. ↪
--testing-fixed-https-port ⊗	No description ↪
--tether-stub ⊗	Overrides Tether with stub service. Provide integer arguments for the number of fake networks desired, e.g. 'tether-stub=2'. ↪
--timeout ⊗	Issues a stop after the specified number of milliseconds. This cancels all navigation and causes the DOMContentLoaded event to fire. ↪
--tls1 ⊗	These values aren't switches, but rather the values that kSSLVersionMax and kSSLVersionMin can have. ↪
--tls1.1 ⊗	No description ↪
--tls1.2 ⊗	No description ↪
--tls1.3 ⊗	No description ↪
--tls13-variant ⊗	Specifies the enabled TLS 1.3 variant ("disabled", "draft", "experiment"). ↪
--top-chrome-md ⊗	Enables top Chrome material design elements. ↪
--top-controls-hide-threshold ⊗	Percentage of the browser controls need to be hidden before they will auto hide. ↪
--top-controls-show-threshold ⊗	Percentage of the browser controls need to be shown before they will auto show. ↪
--touch-calibration[15] ⊗	The calibration factors given as "<left>,<right>,<top>,<bottom>". ↪
--touch-devices[28] ⊗	Tells chrome to interpret events from these devices as touch events. Only available with XInput 2 (i.e. X server 1.8 or above). The id's of the devices can be retrieved from 'xinput list'. ↪
--touch-events ⊗	Enable support for touch event feature detection. ↪
--touch-noise-filtering[15] ⊗	Tells Chrome to do additional touch noise filtering. Should only be used if the driver level filtering is insufficient. ↪
--touch-selection-strategy ⊗	Controls how text selection granularity changes when touch text selection handles are dragged. Should be "character" or "direction". If not specified, the platform default is used. ↪
--touch_view ⊗	No description ↪
--trace-config-file ⊗	Causes TRACE_EVENT flags to be recorded from startup. This flag will be ignored if --trace-startup or --trace-shutdown is provided. ↪
--trace-export-events-to-etw[1] ⊗	Enables the exporting of the tracing events to ETW. This is only supported on Windows Vista and later. ↪
--trace-shutdown ⊗	Causes TRACE_EVENT flags to be recorded beginning with shutdown. Optionally, can specify the specific trace categories to include (e.g. --trace-shutdown=base,net) otherwise, all events are recorded. --trace-shutdown-file can be used to control where the trace log gets stored to since there is otherwise no way to access the result. ↪
--trace-shutdown-file ⊗	If supplied, sets the file which shutdown tracing will be stored into, if omitted the default will be used "chrometrace.log" in the current directory. Has no effect unless --trace-shutdown is also supplied. Example: --trace-shutdown --trace-shutdown-file=/tmp/trace_event.log ↪
--trace-startup ⊗	Causes TRACE_EVENT flags to be recorded from startup. Optionally, can specify the specific trace categories to include (e.g. --trace-startup=base,net) otherwise, all events are recorded. Setting this flag results in the first call to BeginTracing() to receive all trace events since startup. In Chrome, you may find --trace-startup-file and --trace-startup-duration to control the auto-saving of the trace (not supported in the base-only TraceLog component). ↪
--trace-startup-duration ⊗	Sets the time in seconds until startup tracing ends. If omitted a default of 5 seconds is used. Has no effect without --trace-startup, or if --startup-trace-file=none was supplied. ↪
--trace-startup-file ⊗	If supplied, sets the file which startup tracing will be stored into, if omitted the default will be used "chrometrace.log" in the current directory. Has no effect unless --trace-startup is also supplied. Example: --trace-startup --trace-startup-file=/tmp/trace_event.log As a special case, can be set to 'none' - this disables automatically saving the result to a file and the first manually recorded trace will then receive all events since startup. ↪
--trace-to-console ⊗	Sends a pretty-printed version of tracing info to the console. ↪
--trace-to-file ⊗	Sends trace events from these categories to a file. --trace-to-file on its own sends to default categories. ↪
--trace-to-file-name ⊗	Specifies the file name for --trace-to-file. If unspecified, it will go to a default file name. ↪
--trace-upload-url ⊗	Sets the target URL for uploading tracing data. ↪
--translate-ranker-model-url ⊗	Overrides the URL from which the translate ranker model is downloaded. ↪
--translate-script-url ⊗	Overrides the default server used for Google Translate. ↪
--translate-security-origin ⊗	Overrides security-origin with which Translate runs in an isolated world. ↪
--true ⊗	Value indicating whether flag from command line switch is true. ↪
--trusted-download-sources ⊗	Identifies a list of download sources as trusted, but only if proper group policy is set. ↪
--try-chrome-again ⊗	Experimental. Shows a dialog asking the user to try chrome. This flag is to be used only by the upgrade process. ↪
--try-supported-channel-layouts[1] ⊗	Instead of always using the hardware channel layout, check if a driver supports the source channel layout. Avoids outputting empty channels and permits drivers to enable stereo to multichannel expansion. Kept behind a flag since some drivers lie about supported layouts and hang when used. See http://crbug.com/259165 for more details. ↪
--type ⊗	Indicates the type of process to run. This may be "service-manager", "service-runner", or any other arbitrary value supported by the embedder. ↪
--ui-disable-partial-swap ⊗	Disable partial swap which is needed for some OpenGL drivers / emulators. ↪
--ui-enable-layer-lists ⊗	No description ↪
--ui-enable-rgba-4444-textures ⊗	No description ↪
--ui-enable-zero-copy ⊗	No description ↪
--ui-prioritize-in-gpu-process ⊗	Prioritizes the UI's command stream in the GPU process ↪
--ui-show-composited-layer-borders ⊗	No description ↪
--ui-show-fps-counter ⊗	No description ↪
--ui-show-layer-animation-bounds ⊗	No description ↪
--ui-show-paint-rects ⊗	No description ↪
--ui-show-property-changed-rects ⊗	No description ↪
--ui-show-screenspace-rects ⊗	No description ↪
--ui-show-surface-damage-rects ⊗	No description ↪
--ui-slow-animations ⊗	No description ↪
--uninstall[1] ⊗	Runs un-installation steps that were done by chrome first-run. ↪
--unlimited-storage ⊗	Overrides per-origin quota settings to unlimited storage for any apps/origins. This should be used only for testing purpose. ↪
--unsafe-pac-url ⊗	Pass the full https:// URL to PAC (Proxy Auto Config) scripts. As opposed to the default behavior which strips path and query components before passing to the PAC scripts. ↪
--unsafely-allow-protected-media-identifier-for-domain ⊗	For automated testing of protected content, this switch allows specific domains (e.g. example.com) to skip asking the user for permission to share the protected media identifier. In this context, domain does not include the port number. User's content settings will not be affected by enabling this switch. Reference: http://crbug.com/718608 Example: --unsafely-allow-protected-media-identifier-for-domain=a.com,b.ca ↪
--unsafely-treat-insecure-origin-as-secure ⊗	Treat given (insecure) origins as secure origins. Multiple origins can be supplied. Has no effect unless --user-data-dir is also supplied. Example: --unsafely-treat-insecure-origin-as-secure=http://a.test,http://b.test --user-data-dir=/test/only/profile/dir ↪
--use-angle ⊗	Select which ANGLE backend to use. Options are: default: Attempts several ANGLE renderers until one successfully initializes, varying ES support by platform. d3d9: Legacy D3D9 renderer, ES2 only. d3d11: D3D11 renderer, ES2 and ES3. warp: D3D11 renderer using software rasterization, ES2 and ES3. gl: Desktop GL renderer, ES2 and ES3. gles: GLES renderer, ES2 and ES3. ↪
--use-cras[29] ⊗	Use CRAS, the ChromeOS audio server. ↪
--use-double-buffering ⊗	No description ↪
--use-fake-device-for-media-stream ⊗	Use fake device for Media Stream to replace actual camera and microphone. ↪
--use-fake-jpeg-decode-accelerator ⊗	Use fake device for accelerated decoding of JPEG. This allows, for example, testing of the communication to the GPU service without requiring actual accelerator hardware to be present. ↪
--use-fake-ui-for-media-stream ⊗	Bypass the media stream infobar by selecting the default device for media streams (e.g. WebRTC). Works with --use-fake-device-for-media-stream. ↪
--use-file-for-fake-audio-capture ⊗	Play a .wav file as the microphone. Note that for WebRTC calls we'll treat the bits as if they came from the microphone, which means you should disable audio processing (lest your audio file will play back distorted). The input file is converted to suit Chrome's audio buses if necessary, so most sane .wav files should work. You can pass either <path> to play the file looping or <path>%noloop to stop after playing the file to completion. ↪
--use-file-for-fake-video-capture ⊗	Use an .y4m file to play as the webcam. See the comments in media/capture/video/file_video_capture_device.h for more details. ↪
--use-first-display-as-internal ⊗	Uses the 1st display in --ash-host-window-bounds as internal display. This is for debugging on linux desktop. ↪
--use-gl ⊗	Select which implementation of GL the GPU process should use. Options are: desktop: whatever desktop OpenGL the user has installed (Linux and Mac default). egl: whatever EGL / GLES2 the user has installed (Windows default - actually ANGLE). osmesa: The OSMesa software renderer. swiftshader: The SwiftShader software renderer. ↪
--use-gpu-in-tests ⊗	Use hardware gpu, if available, for tests. ↪
--use-ime-service ⊗	By default we use classic IME (i.e. InputMethodChromeOS) in kMus. This flag enables the IME service (i.e. InputMethodMus) instead. ↪
--use-mobile-user-agent ⊗	Set when Chromium should use a mobile user agent. ↪
--use-mock-keychain[7] ⊗	No description ↪
--use-passthrough-cmd-decoder ⊗	Use the Pass-through command decoder, skipping all validation and state tracking. ↪
--use-skia-renderer ⊗	Use SkiaRenderer instead of GLRenderer for direct rendering. ↪
--use-system-default-printer[30] ⊗	Uses the system default printer as the initially selected destination in print preview, instead of the most recently used destination. ↪
--use-test-config ⊗	Initializes X11 in threaded mode, and sets the |override_redirect| flag when creating X11 windows. Also, exposes the WindowServerTest interface to clients when launched with this flag. ↪
--use-viz-hit-test ⊗	WindowServer uses the viz hit-test logic (HitTestAggregator and HitTestQuery). ↪
--user-agent ⊗	A string used to override the default user agent with a custom one. ↪
--user-always-affiliated ⊗	Always treat user as affiliated. TODO(antrim): Remove once test servers correctly produce affiliation ids. ↪
--user-data-dir ⊗	Directory where the browser stores the user profile. ↪
--user-gesture-required ⊗	Autoplay policy to require a user gesture in order to play. ↪
--user-gesture-required-for-cross-origin ⊗	Autoplay policy to require a user gesture in ordor to play for cross origin iframes. ↪
--utility ⊗	Causes the process to run as a utility subprocess. ↪
--utility-allowed-dir ⊗	When utility process is sandboxed, there is still access to one directory. This flag specifies the directory that can be accessed. ↪
--utility-cmd-prefix ⊗	The contents of this flag are prepended to the utility process command line. Useful values might be "valgrind" or "xterm -e gdb --args". ↪
--utility-run-elevated ⊗	No description ↪
--utility-sandbox-type ⊗	Type of sandbox to apply to the utility process. Options are "none", "network", or "utility" (the default). ↪
--utility-startup-dialog ⊗	Causes the utility process to display a dialog on launch. ↪
--v ⊗	Gives the default maximal active V-logging level; 0 is the default. Normally positive values are used for V-logging levels. ↪
--v2-sandbox[7] ⊗	Enable the V2 sandbox during the helper executable initialization. ↪
--v2-sandbox-enabled[7] ⊗	The command line paramter indicating that the v2 sandbox is enabled. This must be different than the "v2-sandbox" flag to avoid endless re-executing. The flag tells the sandbox initialization code inside Chrome that the sandbox should already be enabled. TODO(kerrnel): Remove this once the V2 sandbox migration is complete, as processes will be assumed to run under the V2 sandbox. ↪
--v8-cache-options ⊗	Set options to cache V8 data. (off, preparse data, or code) ↪
--v8-cache-strategies-for-cache-storage ⊗	Set strategies to cache V8 data in CacheStorage. (off, normal, or aggressive) ↪
--validate-crx ⊗	Examines a .crx for validity and prints the result. ↪
--validate-input-event-stream ⊗	In debug builds, asserts that the stream of input events is valid. ↪
--variations-override-country ⊗	Allows overriding the country used for evaluating variations. This is similar to the "Override Variations Country" entry on chrome://translate-internals, but is exposed as a command-line flag to allow testing First Run scenarios. Additionally, unlike chrome://translate-internals, the value isn't persisted across sessions. ↪
--variations-server-url ⊗	Specifies a custom URL for the server which reports variation data to the client. Specifying this switch enables the Variations service on unofficial builds. See variations_service.cc. ↪
--version ⊗	No description ↪
--video-image-texture-target ⊗	Texture target for CHROMIUM_image backed video frame textures. ↪
--video-threads ⊗	Set number of threads to use for video decoding. ↪
--video-underflow-threshold-ms ⊗	Allows clients to override the threshold for when the media renderer will declare the underflow state for the video stream when audio is present. TODO(dalecurtis): Remove once experiments for http://crbug.com/470940 finish. ↪
--virtual-time-budget ⊗	If set the system waits the specified number of virtual milliseconds before deeming the page to be ready. For determinism virtual time does not advance while there are pending network fetches (i.e no timers will fire). Once all network fetches have completed, timers fire and if the system runs out of virtual time is fastforwarded so the next timer fires immediatley, until the specified virtual time budget is exhausted. ↪
--vmodule ⊗	Gives the per-module maximal V-logging levels to override the value given by --v. E.g. "my_module=2,foo*=3" would change the logging level for all code in source files "my_module.*" and "foo*.*" ("-inl" suffixes are also disregarded for this matching). Any pattern containing a forward or backward slash will be tested against the whole pathname and not just the module. E.g., "*/foo/bar/*=2" would change the logging level for all code in source files under a "foo/bar" directory. ↪
--voice-interaction-supported-locales ⊗	List of locales supported by voice interaction. ↪
--wait-for-debugger ⊗	Will wait for 60 seconds for a debugger to come to attach to the process. ↪
--wait-for-debugger-children ⊗	Will add kWaitForDebugger to every child processes. If a value is passed, it will be used as a filter to determine if the child process should have the kWaitForDebugger flag passed on or not. ↪
--wake-on-wifi-packet ⊗	Enables wake on wifi packet feature, which wakes the device on the receipt of network packets from whitelisted sources. ↪
--wallet-service-use-sandbox ⊗	Use the sandbox Online Wallet service URL (for developer testing). ↪
--watcher[1] ⊗	Causes the process to run as a watcher process. ↪
--waveout-buffers[1] ⊗	Number of buffers to use for WaveOut. ↪
--webapk-server-url[6] ⊗	Custom WebAPK server URL for the sake of testing. ↪
--webrtc-stun-probe-trial[13] ⊗	Renderer process parameter for WebRTC Stun probe trial to determine the interval. Please see SetupStunProbeTrial in chrome_browser_field_trials_desktop.cc for more detail. ↪
--webview-enable-safebrowsing-support ⊗	used to enable safebrowsing functionality in webview ↪
--webview-sandboxed-renderer ⊗	No description ↪
--whitelisted-extension-id ⊗	Adds the given extension ID to all the permission whitelists. ↪
--win-jumplist-action ⊗	Specifies which category option was clicked in the Windows Jumplist that resulted in a browser startup. ↪
--window-position ⊗	Specify the initial window position: --window-position=x,y ↪
--window-size ⊗	Sets the initial window size. Provided as string in the format "800,600". ↪
--window-workspace ⊗	Specify the initial window workspace: --window-workspace=id ↪
--windows10-custom-titlebar[1] ⊗	Enables custom-drawing the titlebar and tabstrip background so that it's not a garish #FFFFFF like it is by default on Windows 10. ↪
--winhttp-proxy-resolver ⊗	Uses WinHTTP to fetch and evaluate PAC scripts. Otherwise the default is to use Chromium's network stack to fetch, and V8 to evaluate. ↪
--wm-window-animations-disabled ⊗	If present animations are disabled. ↪
--yield-between-content-script-runs ⊗	Whether to split content script injections into multiple tasks. ↪
--zygote ⊗	Causes the process to run as a renderer zygote. ↪


# pranks
set
chrome://restart/../%s./../
as default search engine

chrome://-alkuisissa
chrome://-nettadresser
chrome://-webbadresser
chrome://ChromeTestChromeWebUIControllerFactory
chrome://DummyURL
chrome://URLs
chrome://about
chrome://accessibility
chrome://anything
chrome://app-list
chrome://appcache-internals
chrome://apps
chrome://badala
chrome://badcastcrash
chrome://bar
chrome://blah
chrome://blank
chrome://blob-internals
chrome://bluetooth-pairing
chrome://bogus
chrome://bookmarks
chrome://browser
chrome://certificate-manager
chrome://choose-mobile-network
chrome://chrome
chrome://chrome-signin
chrome://chrome-urls
chrome://components
chrome://conflicts
chrome://constrained-test
chrome://consumer-management
chrome://contextual-search-promo
chrome://cookieset
chrome://copresence
chrome://crash
chrome://crashdump
chrome://crashes
chrome://credits
chrome://credits-
chrome://cryptohome
chrome://device-emulator
chrome://device-log
chrome://devices
chrome://discards
chrome://dns
chrome://dom-distiller
chrome://domain-reliability-internals
chrome://downloads
chrome://drive
chrome://drive-internals
chrome://example
chrome://extension
chrome://extension-crash
chrome://extension-icon
chrome://extensions
chrome://extensions-frame
chrome://extensions-kohdassa
chrome://external-file
chrome://f
chrome://fallback-icon
chrome://favicon
chrome://fblahblahblah
chrome://fg
chrome://fileicon
chrome://first-run
chrome://fl
chrome://flag
chrome://flagg
chrome://flags
chrome://flash
chrome://foo
chrome://gcm-internals
chrome://gesture
chrome://gpu
chrome://gpuclean
chrome://gpucrash
chrome://gpuhang
chrome://hang
chrome://help
chrome://help-frame
chrome://histograms
chrome://historik
chrome://history
chrome://history-frame
chrome://host
chrome://http
chrome://identity-internals
chrome://imageburner
chrome://indexeddb-internals
chrome://inducebrowsercrashforrealz
chrome://inspect
chrome://instant
chrome://internal
chrome://interstitials
chrome://invalidations
chrome://javascript
chrome://kasko
chrome://keyboard
chrome://keyboardoverlay
chrome://kill
chrome://large-icon
chrome://linux-proxy-config
chrome://local-state
chrome://make-metro
chrome://managed-user-passphrase
chrome://md-policy
chrome://md-settings
chrome://measurepageloadtimeextension
chrome://media-internals
chrome://media-router
chrome://memory
chrome://memory-internals
chrome://memory-redirect
chrome://mobilesetup
chrome://mojo-web-ui
chrome://most_visited
chrome://nacl
chrome://navigate
chrome://net
chrome://net-export
chrome://net-internals
chrome://network
chrome://network-error
chrome://network-errors
chrome://newprofile
chrome://newtab
chrome://newtab2
chrome://newtab3
chrome://nfc-debug
chrome://omaha
chrome://omnibox
chrome://oobe
chrome://options
chrome://os-credits
chrome://os_credits
chrome://password-manager-internals
chrome://path
chrome://peripheral-battery
chrome://plugins
chrome://pnacl-translator
chrome://policy
chrome://popular-sites-internals
chrome://power
chrome://ppapiflashcrash
chrome://ppapiflashhang
chrome://predictors
chrome://preferences
chrome://print
chrome://profile-signin-confirmation
chrome://profiler
chrome://proximity-auth
chrome://proximity_auth
chrome://proxy-settings
chrome://quit
chrome://quit-with-apps
chrome://quota-internals
chrome://recent-tabs
chrome://resources
chrome://restart
chrome://s
chrome://salsa
chrome://sandbox
chrome://screen
chrome://screenlock-icon
chrome://screenshot
chrome://serviceworker-internals
chrome://session
chrome://set-time
chrome://settings
chrome://settings-frame
chrome://setupfortesting
chrome://shorthang
chrome://sign-in
chrome://signin
chrome://signin-internals
chrome://sim-unlock
chrome://site-engagement
chrome://slow
chrome://slow_trace
chrome://somepage
chrome://source_name
chrome://stylesheet
chrome://suggestions
chrome://supervised-user-internals
chrome://sync-internals
chrome://syncfs-internals
chrome://syncresources
chrome://system
chrome://tab-modal-confirm-dialog
chrome://tcmalloc
chrome://terms
chrome://test
chrome://test-page
chrome://theme
chrome://thumb
chrome://thumbnail
chrome://thumbnails
chrome://thumbs
chrome://tracing
chrome://trailing2blah
chrome://translate-internals
chrome://uber-frame
chrome://ui-alternatives
chrome://uithreadhang
chrome://user
chrome://user-actions
chrome://user-chooser
chrome://user-manager
chrome://userimage
chrome://usr
chrome://ve
chrome://version
chrome://view-cert
chrome://view-cert-dialog
chrome://view-http-cache
chrome://voicesearch
chrome://webrtc-device-provider
chrome://webrtc-internals
chrome://webrtc-logs
chrome://webui
chrome://welcome
chrome://youtube


# policies
* policies policy https://www.chromium.org/administrators/policy-list-3
* policy https://chromeenterprise.google/policies/

## Accessibility settings
AccessibilityShortcutsEnabled
AutoclickEnabled
CaretHighlightEnabled
ColorCorrectionEnabled
CursorHighlightEnabled
DeviceLoginScreenAccessibilityShortcutsEnabled
DeviceLoginScreenAutoclickEnabled
DeviceLoginScreenCaretHighlightEnabled
DeviceLoginScreenCursorHighlightEnabled
DeviceLoginScreenDefaultHighContrastEnabled
DeviceLoginScreenDefaultLargeCursorEnabled
DeviceLoginScreenDefaultScreenMagnifierType
DeviceLoginScreenDefaultSpokenFeedbackEnabled
DeviceLoginScreenDefaultVirtualKeyboardEnabled
DeviceLoginScreenDictationEnabled
DeviceLoginScreenHighContrastEnabled
DeviceLoginScreenKeyboardFocusHighlightEnabled
DeviceLoginScreenLargeCursorEnabled
DeviceLoginScreenMonoAudioEnabled
DeviceLoginScreenScreenMagnifierType
DeviceLoginScreenSelectToSpeakEnabled
DeviceLoginScreenShowOptionsInSystemTrayMenu
DeviceLoginScreenSpokenFeedbackEnabled
DeviceLoginScreenStickyKeysEnabled
DeviceLoginScreenVirtualKeyboardEnabled
DictationEnabled
EnhancedNetworkVoicesInSelectToSpeakAllowed
FloatingAccessibilityMenuEnabled
HighContrastEnabled
KeyboardDefaultToFunctionKeys
KeyboardFocusHighlightEnabled
LargeCursorEnabled
MonoAudioEnabled
ScreenMagnifierType
SelectToSpeakEnabled
ShowAccessibilityOptionsInSystemTrayMenu
SpokenFeedbackEnabled
StickyKeysEnabled
VirtualKeyboardEnabled
VirtualKeyboardFeatures

## Allow or deny screen capture
SameOriginTabCaptureAllowedByOrigins
ScreenCaptureAllowed
ScreenCaptureAllowedByOrigins
TabCaptureAllowedByOrigins
WindowCaptureAllowedByOrigins

## Android settings
AppRecommendationZeroStateEnabled
ArcAppInstallEventLoggingEnabled
ArcAppToWebAppSharingEnabled
ArcBackupRestoreEnabled
ArcBackupRestoreServiceEnabled
ArcCertificatesSyncMode
ArcEnabled
ArcGoogleLocationServicesEnabled
ArcLocationServiceEnabled
ArcPolicy
DeviceArcDataSnapshotHours
UnaffiliatedArcAllowed
UnaffiliatedDeviceArcAllowed

## Borealis
DeviceBorealisAllowed
UserBorealisAllowed

## Certificate management settings
RequiredClientCertificateForDevice
RequiredClientCertificateForUser

## Cloud Reporting
CloudExtensionRequestEnabled
CloudReportingEnabled
CloudReportingUploadFrequency
LegacyTechReportAllowlist
ReportSafeBrowsingData

## Content settings
AutoSelectCertificateForUrls
ClipboardAllowedForUrls
ClipboardBlockedForUrls
CookiesAllowedForUrls
CookiesBlockedForUrls
CookiesSessionOnlyForUrls
DataUrlInSvgUseEnabled
DefaultClipboardSetting
DefaultCookiesSetting
DefaultFileHandlingGuardSetting
DefaultFileSystemReadGuardSetting
DefaultFileSystemWriteGuardSetting
DefaultGeolocationSetting
DefaultImagesSetting
DefaultInsecureContentSetting
DefaultJavaScriptJitSetting
DefaultJavaScriptSetting
DefaultKeygenSetting
DefaultLocalFontsSetting
DefaultMediaStreamSetting
DefaultNotificationsSetting
DefaultPluginsSetting
DefaultPopupsSetting
DefaultSensorsSetting
DefaultSerialGuardSetting
DefaultThirdPartyStoragePartitioningSetting
DefaultWebBluetoothGuardSetting
DefaultWebHidGuardSetting
DefaultWebUsbGuardSetting
DefaultWindowManagementSetting
DefaultWindowPlacementSetting
FileHandlingAllowedForUrls
FileHandlingBlockedForUrls
FileSystemReadAskForUrls
FileSystemReadBlockedForUrls
FileSystemSyncAccessHandleAsyncInterfaceEnabled
FileSystemWriteAskForUrls
FileSystemWriteBlockedForUrls
GetDisplayMediaSetSelectAllScreensAllowedForUrls
ImagesAllowedForUrls
ImagesBlockedForUrls
InsecureContentAllowedForUrls
InsecureContentBlockedForUrls
JavaScriptAllowedForUrls
JavaScriptBlockedForUrls
JavaScriptJitAllowedForSites
JavaScriptJitBlockedForSites
KeygenAllowedForUrls
KeygenBlockedForUrls
LegacySameSiteCookieBehaviorEnabled
LegacySameSiteCookieBehaviorEnabledForDomainList
LocalFontsAllowedForUrls
LocalFontsBlockedForUrls
NotificationsAllowedForUrls
NotificationsBlockedForUrls
PdfLocalFileAccessAllowedForDomains
PluginsAllowedForUrls
PluginsBlockedForUrls
PopupsAllowedForUrls
PopupsBlockedForUrls
RegisteredProtocolHandlers
SensorsAllowedForUrls
SensorsBlockedForUrls
SerialAllowAllPortsForUrls
SerialAllowUsbDevicesForUrls
SerialAskForUrls
SerialBlockedForUrls
ThirdPartyStoragePartitioningBlockedForOrigins
WebHidAllowAllDevicesForUrls
WebHidAllowDevicesForUrls
WebHidAllowDevicesWithHidUsagesForUrls
WebHidAskForUrls
WebHidBlockedForUrls
WebUsbAllowDevicesForUrls
WebUsbAskForUrls
WebUsbBlockedForUrls
WindowManagementAllowedForUrls
WindowManagementBlockedForUrls
WindowPlacementAllowedForUrls
WindowPlacementBlockedForUrls

## Date and time
CalendarIntegrationEnabled
SystemTimezone
SystemTimezoneAutomaticDetection
SystemUse24HourClock

## Default search provider
DefaultSearchProviderAlternateURLs
DefaultSearchProviderEnabled
DefaultSearchProviderEncodings
DefaultSearchProviderIconURL
DefaultSearchProviderImageURL
DefaultSearchProviderImageURLPostParams
DefaultSearchProviderInstantURL
DefaultSearchProviderInstantURLPostParams
DefaultSearchProviderKeyword
DefaultSearchProviderName
DefaultSearchProviderNewTabURL
DefaultSearchProviderSearchTermsReplacementKey
DefaultSearchProviderSearchURL
DefaultSearchProviderSearchURLPostParams
DefaultSearchProviderSuggestURL
DefaultSearchProviderSuggestURLPostParams

## Desk Connector Settings
DeskAPIThirdPartyAccessEnabled
DeskAPIThirdPartyAllowlist

## Device update settings
ChromeOsReleaseChannel
ChromeOsReleaseChannelDelegated
DeviceAutoUpdateDisabled
DeviceAutoUpdateP2PEnabled
DeviceAutoUpdateTimeRestrictions
DeviceMinimumVersion
DeviceMinimumVersionAueMessage
DeviceQuickFixBuildToken
DeviceRollbackAllowedMilestones
DeviceRollbackToTargetVersion
DeviceTargetVersionPrefix
DeviceTargetVersionSelector
DeviceUpdateAllowedConnectionTypes
DeviceUpdateHttpDownloadsEnabled
DeviceUpdateScatterFactor
DeviceUpdateStagingSchedule
MinimumRequiredChromeVersion
RebootAfterUpdate

## Display
DeviceDisplayResolution
DisplayRotationDefault

## Drive
DriveDisabled
DriveDisabledOverCellular
DriveFileSyncAvailable

## Extensions
BlockExternalExtensions
ChromeAppsWebViewPermissiveBehaviorAllowed
DeviceLoginScreenExtensionManifestV2Availability
ExtensionAllowInsecureUpdates
ExtensionAllowedTypes
ExtensionExtendedBackgroundLifetimeForPortConnectionsToUrls
ExtensionInstallAllowlist
ExtensionInstallBlocklist
ExtensionInstallForcelist
ExtensionInstallSources
ExtensionInstallTypeBlocklist
ExtensionManifestV2Availability
ExtensionOAuthRedirectUrls
ExtensionSettings
ExtensionUnpublishedAvailability
MandatoryExtensionsForIncognitoNavigation

## First-Party Sets Settings
FirstPartySetsEnabled
FirstPartySetsOverrides

## Gaia user identity management settings
GaiaOfflineSigninTimeLimitDays

## Google Assistant
AssistantVoiceMatchEnabledDuringOobe
AssistantWebEnabled
VoiceInteractionContextEnabled
VoiceInteractionHotwordEnabled
VoiceInteractionQuickAnswersEnabled

## Google Cast
EnableMediaRouter
MediaRouterCastAllowAllIPs
ShowCastIconInToolbar
ShowCastSessionsStartedByOtherDevices

## HTTP authentication
AllHttpAuthSchemesAllowedForOrigins
AllowCrossOriginAuthPrompt
AuthAndroidNegotiateAccountType
AuthNegotiateDelegateAllowlist
AuthNegotiateDelegateByKdcPolicy
AuthSchemes
AuthServerAllowlist
BasicAuthOverHttpEnabled
DisableAuthNegotiateCnameLookup
EnableAuthNegotiatePort
GSSAPILibraryName
IntegratedWebAuthenticationAllowed
NtlmV2Enabled

## Idle Browser Actions
IdleTimeout
IdleTimeoutActions

## Kerberos
KerberosAccounts
KerberosAddAccountsAllowed
KerberosCustomPrefilledConfig
KerberosDomainAutocomplete
KerberosEnabled
KerberosRememberPasswordEnabled
KerberosUseCustomPrefilledConfig

## Kiosk settings
AllowKioskAppControlChromeVersion
DeviceLocalAccountAutoLoginBailoutEnabled
DeviceLocalAccountAutoLoginDelay
DeviceLocalAccountAutoLoginId
DeviceLocalAccountPromptForNetworkWhenOffline
DeviceLocalAccounts
KioskTroubleshootingToolsEnabled
NewWindowsInKioskAllowed

## Legacy Browser Support
AlternativeBrowserParameters
AlternativeBrowserPath
BrowserSwitcherChromeParameters
BrowserSwitcherChromePath
BrowserSwitcherDelay
BrowserSwitcherEnabled
BrowserSwitcherExternalGreylistUrl
BrowserSwitcherExternalSitelistUrl
BrowserSwitcherKeepLastChromeTab
BrowserSwitcherParsingMode
BrowserSwitcherUrlGreylist
BrowserSwitcherUrlList
BrowserSwitcherUseIeSitelist

## Linux container
CrostiniAllowed
CrostiniAnsiblePlaybook
CrostiniExportImportUIAllowed
CrostiniPortForwardingAllowed
DeviceUnaffiliatedCrostiniAllowed
SystemTerminalSshAllowed
VirtualMachinesAllowed

## Locally managed users settings
SupervisedUserContentProviderEnabled
SupervisedUserCreationEnabled
SupervisedUsersEnabled

## Microsoft® Active Directory® management settings
ChromadToCloudMigrationEnabled
CloudAPAuthEnabled
DeviceAuthDataCacheLifetime
DeviceGpoCacheLifetime
DeviceKerberosEncryptionTypes
DeviceMachinePasswordChangeRate
DeviceUserPolicyLoopbackProcessingMode

## Miscellaneous
AbusiveExperienceInterventionEnforce
AccessCodeCastDeviceDuration
AccessCodeCastEnabled
AccessibilityImageLabelsEnabled
AccessibilityPerformanceFilteringAllowed
AdditionalDnsQueryTypesEnabled
AdsSettingForIntrusiveAdsSites
AdvancedProtectionAllowed
AdvancedProtectionDeepScanningEnabled
AllowBackForwardCacheForCacheControlNoStorePageEnabled
AllowDeletingBrowserHistory
AllowDinosaurEasterEgg
AllowFileSelectionDialogs
AllowNativeNotifications
AllowOutdatedPlugins
AllowPopupsDuringPageUnload
AllowScreenLock
AllowSyncXHRInPageDismissal
AllowSystemNotifications
AllowWebAuthnWithBrokenTlsCerts
AllowedDomainsForApps
AllowedInputMethods
AllowedLanguages
AlternateErrorPagesEnabled
AlwaysAuthorizePlugins
AlwaysOpenPdfExternally
AmbientAuthenticationInPrivateModesEnabled
AppCacheForceEnabled
AppLaunchAutomation
AppStoreRatingEnabled
ApplicationLocaleValue
ArcVmDataMigrationStrategy
AttestationExtensionWhitelist
AudioCaptureAllowed
AudioCaptureAllowedUrls
AudioOutputAllowed
AudioProcessHighPriorityEnabled
AudioSandboxEnabled
AuthNegotiateDelegateWhitelist
AuthServerWhitelist
AutoCleanUpStrategy
AutoFillEnabled
AutoLaunchProtocolsFromOrigins
AutoOpenAllowedForURLs
AutoOpenFileTypes
AutofillAddressEnabled
AutofillCreditCardEnabled
AutoplayAllowed
AutoplayAllowlist
AutoplayWhitelist
BackForwardCacheEnabled
BackgroundModeEnabled
BatterySaverModeAvailability
BeforeunloadEventCancelByPreventDefaultEnabled
BlockThirdPartyCookies
BookmarkBarEnabled
BrowserAddPersonEnabled
BrowserContextAwareAccessSignalsAllowlist
BrowserGuestModeEnabled
BrowserGuestModeEnforced
BrowserLabsEnabled
BrowserLegacyExtensionPointsBlocked
BrowserNetworkTimeQueriesEnabled
BrowserSignin
BrowserThemeColor
BrowsingDataLifetime
BuiltInDnsClientEnabled
BuiltinCertificateVerifierEnabled
CACertificateManagementAllowed
CCTToSDialogEnabled
CECPQ2Enabled
CORSNonWildcardRequestHeadersSupport
CaptivePortalAuthenticationIgnoresProxy
CertificateTransparencyEnforcementDisabledForCas
CertificateTransparencyEnforcementDisabledForLegacyCas
CertificateTransparencyEnforcementDisabledForUrls
ChromeAppsEnabled
ChromeCleanupEnabled
ChromeCleanupReportingEnabled
ChromeOsLockOnIdleSuspend
ChromeOsMultiProfileUserBehavior
ChromeRootStoreEnabled
ChromeVariations
ClearBrowsingDataOnExitList
ClearSiteDataOnExit
ClickToCallEnabled
ClientCertificateManagementAllowed
CloudManagementEnrollmentMandatory
CloudManagementEnrollmentToken
CloudPolicyOverridesPlatformPolicy
CloudUserPolicyMerge
CloudUserPolicyOverridesCloudMachinePolicy
CommandLineFlagSecurityWarningsEnabled
ComponentUpdatesEnabled
ContextAwareAccessSignalsAllowlist
ContextMenuPhotoSharingSettings
ContextualSearchEnabled
ContextualSuggestionsEnabled
CopyPreventionSettings
CorsLegacyModeEnabled
CorsMitigationList
CreatePasskeysInICloudKeychain
CredentialProviderPromoEnabled
CrossOriginWebAssemblyModuleSharingEnabled
DHEEnabled
DNSInterceptionChecksEnabled
DataCompressionProxyEnabled
DataLeakPreventionClipboardCheckSizeLimit
DataLeakPreventionReportingEnabled
DataLeakPreventionRulesList
DefaultBrowserSettingEnabled
DefaultDownloadDirectory
DefaultHandlersForFileExtensions
DefaultSearchProviderContextMenuAccessAllowed
DesktopSharingHubEnabled
DeveloperToolsAvailability
DeveloperToolsDisabled
DeviceAllowBluetooth
DeviceAllowMGSToStoreDisplayProperties
DeviceAllowRedeemChromeOsRegistrationOffers
DeviceAllowedBluetoothServices
DeviceAppPack
DeviceAttributesAllowedForOrigins
DeviceAuthenticationURLAllowlist
DeviceAuthenticationURLBlocklist
DeviceBlockDevmode
DeviceChromeVariations
DeviceDebugPacketCaptureAllowed
DeviceEcryptfsMigrationStrategy
DeviceEncryptedReportingPipelineEnabled
DeviceEphemeralNetworkPoliciesEnabled
DeviceI18nShortcutsEnabled
DeviceIdleLogoutTimeout
DeviceIdleLogoutWarningDuration
DeviceKeyboardBacklightColor
DeviceKeylockerForStorageEncryptionEnabled
DeviceLocalAccountManagedSessionEnabled
DeviceLoginScreenContextAwareAccessSignalsAllowlist
DeviceLoginScreenGeolocationAccessLevel
DeviceLoginScreenPrimaryMouseButtonSwitch
DeviceLoginScreenSaverId
DeviceLoginScreenSaverTimeout
DeviceLoginScreenWebHidAllowDevicesForUrls
DeviceLoginScreenWebUsbAllowDevicesForUrls
DeviceNativePrintersBlacklist
DeviceNativePrintersWhitelist
DeviceOffHours
DevicePciPeripheralDataAccessEnabled
DevicePolicyRefreshRate
DevicePowerwashAllowed
DeviceQuirksDownloadEnabled
DeviceRebootOnUserSignout
DeviceReleaseLtsTag
DeviceRestrictedManagedGuestSessionEnabled
DeviceScheduledReboot
DeviceScheduledUpdateCheck
DeviceShowLowDiskSpaceNotification
DeviceStartUpUrls
DeviceSystemWideTracingEnabled
DeviceUserWhitelist
Disable3DAPIs
DisablePluginFinder
DisableSSLRecordSplitting
DisableScreenshots
DisableSpdy
DisabledPlugins
DisabledPluginsExceptions
DisabledSchemes
DiskCacheDir
DiskCacheSize
DisplayCapturePermissionsPolicyEnabled
DnsOverHttpsMode
DnsOverHttpsTemplates
DnsPrefetchingEnabled
DomainReliabilityAllowed
DownloadBubbleEnabled
DownloadDirectory
DownloadRestrictions
EasyUnlockAllowed
EcheAllowed
EcryptfsMigrationStrategy
EditBookmarksEnabled
EmojiPickerGifSupportEnabled
EmojiSuggestionEnabled
EnableCommonNameFallbackForLocalAnchors
EnableDeprecatedPrivetPrinting
EnableDeprecatedWebBasedSignin
EnableDeprecatedWebPlatformFeatures
EnableExperimentalPolicies
EnableOnlineRevocationChecks
EnableSha1ForLocalAnchors
EnableSymantecLegacyInfrastructure
EnableSyncConsent
EnabledPlugins
EncryptedClientHelloEnabled
EnforceLocalAnchorConstraintsEnabled
EnterpriseAuthenticationAppLinkPolicy
EnterpriseHardwarePlatformAPIEnabled
EnterpriseProfileCreationKeepBrowsingData
EnterpriseRealTimeUrlCheckMode
EnterpriseWebStoreName
EnterpriseWebStoreURL
EventPathEnabled
ExemptDomainFileTypePairsFromFileTypeDownloadWarnings
ExplicitlyAllowedNetworkPorts
ExtensionCacheSize
ExtensionInstallBlacklist
ExtensionInstallEventLoggingEnabled
ExtensionInstallWhitelist
ExternalPrintServersWhitelist
ExternalProtocolDialogShowAlwaysOpenCheckbox
ExternalStorageDisabled
ExternalStorageReadOnly
FastPairEnabled
FeedbackSurveysEnabled
FetchKeepaliveDurationSecondsOnShutdown
FileOrDirectoryPickerWithoutGestureAllowedForOrigins
FloatingWorkspaceEnabled
ForceBrowserSignin
ForceEnablePepperVideoDecoderDevAPI
ForceEphemeralProfiles
ForceGoogleSafeSearch
ForceLegacyDefaultReferrerPolicy
ForceLogoutUnauthenticatedUserEnabled
ForceMajorVersionToMinorPositionInUserAgent
ForceMaximizeOnFirstRun
ForceNetworkInProcess
ForcePermissionPolicyUnloadDefaultEnabled
ForceSafeSearch
ForceYouTubeRestrict
ForceYouTubeSafetyMode
ForcedLanguages
FullRestoreEnabled
FullscreenAlertEnabled
FullscreenAllowed
GaiaLockScreenOfflineSigninTimeLimitDays
GhostWindowEnabled
GloballyScopeHTTPAuthCacheEnabled
GoogleSearchSidePanelEnabled
HSTSPolicyBypassList
HardwareAccelerationModeEnabled
HeadlessMode
HideWebStoreIcon
HideWebStorePromo
HighEfficiencyModeEnabled
HistoryClustersVisible
Http09OnNonDefaultPortsEnabled
HttpAllowlist
HttpsOnlyMode
HttpsUpgradesEnabled
ImportAutofillFormData
ImportBookmarks
ImportHistory
ImportHomepage
ImportSavedPasswords
ImportSearchEngine
IncognitoEnabled
IncognitoModeAvailability
InsecureFormsWarningsEnabled
InsecureHashesInTLSHandshakesEnabled
InsightsExtensionEnabled
InstantEnabled
InstantTetheringAllowed
IntensiveWakeUpThrottlingEnabled
IntranetRedirectBehavior
IsolateOrigins
IsolateOriginsAndroid
JavascriptEnabled
KeepFullscreenWithoutNotificationUrlAllowList
KeyPermissions
LacrosAllowed
LacrosAvailability
LacrosDataBackwardMigrationMode
LacrosSecondaryProfilesAllowed
LacrosSelection
LensCameraAssistedSearchEnabled
LensDesktopNTPSearchEnabled
LensRegionSearchEnabled
LoadCryptoTokenExtension
LocalDiscoveryEnabled
LockIconInAddressBarEnabled
LockScreenMediaPlaybackEnabled
LoginDisplayPasswordButtonEnabled
LookalikeWarningAllowlistDomains
MachineLevelUserCloudPolicyEnrollmentToken
ManagedAccountsSigninRestriction
ManagedBookmarks
ManagedConfigurationPerOrigin
ManagedGuestSessionAutoLaunchNotificationReduced
ManagedGuestSessionPrivacyWarningsEnabled
MaxConnectionsPerProxy
MaxInvalidationFetchDelay
MediaCacheSize
MediaRecommendationsEnabled
MetricsReportingEnabled
MixedContentAutoupgradeEnabled
NTPCardsVisible
NTPContentSuggestionsEnabled
NTPCustomBackgroundEnabled
NTPMiddleSlotAnnouncementVisible
NativeClientForceAllowed
NativeHostsExecutablesLaunchDirectly
NativeMessagingBlacklist
NativeMessagingWhitelist
NativePrintersBulkBlacklist
NativePrintersBulkWhitelist
NativeWindowOcclusionEnabled
NearbyShareAllowed
NetworkPredictionOptions
NetworkServiceSandboxEnabled
NewBaseUrlInheritanceBehaviorAllowed
NoteTakingAppsLockScreenAllowlist
NoteTakingAppsLockScreenWhitelist
OffsetParentNewSpecBehaviorEnabled
OnBulkDataEntryEnterpriseConnector
OnFileAttachedEnterpriseConnector
OnFileDownloadedEnterpriseConnector
OnFileTransferEnterpriseConnector
OnPrintEnterpriseConnector
OnSecurityEventEnterpriseConnector
OpenNetworkConfiguration
OptimizationGuideFetchingEnabled
OriginAgentClusterDefaultEnabled
OsColorMode
OverrideSecurityRestrictionsOnInsecureOrigin
PPAPISharedImagesForVideoDecoderAllowed
PPAPISharedImagesSwapChainAllowed
PacHttpsUrlStrippingEnabled
ParcelTrackingEnabled
PaymentMethodQueryEnabled
PdfAnnotationsEnabled
PdfUseSkiaRendererEnabled
PerAppTimeLimitsWhitelist
PersistentQuotaEnabled
PhoneHubAllowed
PhoneHubCameraRollAllowed
PhoneHubNotificationsAllowed
PhoneHubTaskContinuationAllowed
PhysicalKeyboardAutocorrect
PhysicalKeyboardPredictiveWriting
PinnedLauncherApps
PolicyAtomicGroupsEnabled
PolicyDictionaryMultipleSourceMergeList
PolicyListMultipleSourceMergeList
PolicyRefreshRate
PolicyScopeDetection
PostQuantumKeyAgreementEnabled
PrefixedStorageInfoEnabled
PrimaryMouseButtonSwitch
PrintingAPIExtensionsWhitelist
ProfilePickerOnStartupAvailability
PromotionalTabsEnabled
PromptForDownloadLocation
PromptOnMultipleMatchingCertificates
ProxySettings
QuicAllowed
QuickOfficeForceFileDownloadEnabled
QuickUnlockModeWhitelist
RC4Enabled
RSAKeyUsageForLocalAnchorsEnabled
RelaunchHeadsUpPeriod
RelaunchNotification
RelaunchNotificationPeriod
RelaunchWindow
RemoteDebuggingAllowed
RendererAppContainerEnabled
RendererCodeIntegrityEnabled
ReportCrostiniUsageEnabled
RequireOnlineRevocationChecksForLocalAnchors
RestrictAccountsToPatterns
RestrictSigninToPattern
RestrictedManagedGuestSessionExtensionCleanupExemptList
RoamingProfileLocation
RoamingProfileSupportEnabled
RunAllFlashInAllowMode
SSLErrorOverrideAllowed
SSLErrorOverrideAllowedForOrigins
SSLVersionFallbackMin
SSLVersionMax
SSLVersionMin
SafeBrowsingExtendedReportingOptInAllowed
SafeBrowsingForTrustedSourcesEnabled
SafeBrowsingWhitelistDomains
SafeSitesFilterBehavior
SamlLockScreenOfflineSigninTimeLimitDays
SandboxExternalProtocolBlocked
SavingBrowserHistoryDisabled
SchedulerConfiguration
ScreenCaptureWithoutGestureAllowedForOrigins
ScrollToTextFragmentEnabled
SearchSuggestEnabled
SecondaryGoogleAccountSigninAllowed
SecondaryGoogleAccountUsage
SecurityKeyPermitAttestation
SecurityTokenSessionBehavior
SecurityTokenSessionNotificationSeconds
SendMouseEventsDisabledFormControlsEnabled
SessionLengthLimit
SessionLocales
SetTimeoutWithout1MsClampEnabled
SharedArrayBufferUnrestrictedAccessAllowed
SharedClipboardEnabled
ShelfAlignment
ShelfAutoHideBehavior
ShoppingListEnabled
ShowAppsShortcutInBookmarkBar
ShowDisplaySizeScreenEnabled
ShowFullUrlsInAddressBar
ShowLogoutButtonInTray
ShowTouchpadScrollScreenEnabled
SideSearchEnabled
SignedHTTPExchangeEnabled
SigninAllowed
SigninInterceptionEnabled
SitePerProcess
SitePerProcessAndroid
SmartLockSigninAllowed
SmsMessagesAllowed
SpellCheckServiceEnabled
SpellcheckEnabled
SpellcheckLanguage
SpellcheckLanguageBlacklist
SpellcheckLanguageBlocklist
StartupBrowserWindowLaunchSuppressed
StrictMimetypeCheckForWorkerScriptsEnabled
StricterMixedContentTreatmentEnabled
SuggestLogoutAfterClosingLastWindow
SuggestedContentEnabled
SuppressDifferentOriginSubframeDialogs
SuppressUnsupportedOSWarning
SyncDisabled
SyncTypesListDisabled
SystemFeaturesDisableList
SystemFeaturesDisableMode
SystemProxySettings
TLS13HardeningForLocalAnchorsEnabled
TPMFirmwareUpdateSettings
TabDiscardingExceptions
TabFreezingEnabled
TabUnderAllowed
TargetBlankImpliesNoOpener
TaskManagerEndProcessEnabled
TermsOfServiceURL
ThirdPartyBlockingEnabled
ThrottleNonVisibleCrossOriginIframesAllowed
TosDialogBehavior
TotalMemoryLimitMb
TouchVirtualKeyboardEnabled
TranslateEnabled
TrashEnabled
TripleDESEnabled
U2fSecurityKeyApiEnabled
URLAllowlist
URLBlacklist
URLBlocklist
URLWhitelist
UnifiedDesktopEnabledByDefault
UnmanagedDeviceSignalsConsentFlowEnabled
UnsafelyTreatInsecureOriginAsSecure
UnthrottledNestedTimeoutEnabled
UrlKeyedAnonymizedDataCollectionEnabled
UrlParamFilterEnabled
UsbDetachableAllowlist
UsbDetachableWhitelist
UsbDetectorNotificationEnabled
UseLegacyFormControls
UseMojoVideoDecoderForPepperAllowed
UserAgentClientHintsEnabled
UserAgentClientHintsGREASEUpdateEnabled
UserAgentReduction
UserAvatarCustomizationSelectorsEnabled
UserAvatarImage
UserContextAwareAccessSignalsAllowlist
UserDataDir
UserDataSnapshotRetentionLimit
UserDisplayName
UserFeedbackAllowed
VideoCaptureAllowed
VideoCaptureAllowedUrls
VirtualKeyboardResizesLayoutByDefault
VmManagementCliAllowed
VpnConfigAllowed
WPADQuickCheckEnabled
WallpaperGooglePhotosIntegrationEnabled
WallpaperImage
WarnBeforeQuittingEnabled
WebAppInstallForceList
WebAppSettings
WebAuthnFactors
WebComponentsV0Enabled
WebDriverOverridesIncompatiblePolicies
WebRtcAllowLegacyTLSProtocols
WebRtcEventLogCollectionAllowed
WebRtcIPHandling
WebRtcLocalIpsAllowedUrls
WebRtcTextLogCollectionAllowed
WebRtcUdpPortRange
WebSQLAccess
WebSQLInThirdPartyContextEnabled
WebSQLNonSecureContextEnabled
WebXRImmersiveArEnabled
WelcomePageOnOSUpgradeEnabled
WifiSyncAndroidAllowed
WindowOcclusionEnabled

## Native Messaging
NativeMessagingAllowlist
NativeMessagingBlocklist
NativeMessagingUserLevelHosts

## Network File Shares settings
NTLMShareAuthenticationEnabled
NetBiosShareDiscoveryEnabled
NetworkFileSharesAllowed
NetworkFileSharesPreconfiguredShares

## Network settings
AccessControlAllowMethodsInCORSPreflightSpecConformant
BlockTruncatedCookies
CompressionDictionaryTransportEnabled
DeviceDataRoamingEnabled
DeviceDockMacAddressSource
DeviceHostnameTemplate
DeviceHostnameUserConfigurable
DeviceOpenNetworkConfiguration
DeviceWiFiAllowed
DeviceWiFiFastTransitionEnabled
DnsOverHttpsSalt
DnsOverHttpsTemplatesWithIdentifiers
IPv6ReachabilityOverrideEnabled
NetworkThrottlingEnabled
OutOfProcessSystemDnsResolutionEnabled
ZstdContentEncodingEnabled

## Parental supervision settings
EduCoexistenceToSVersion
ParentAccessCodeConfig
PerAppTimeLimits
PerAppTimeLimitsAllowlist
UsageTimeLimit

## Password manager
PasswordDismissCompromisedAlertEnabled
PasswordLeakDetectionEnabled
PasswordManagerAllowShowPasswords
PasswordManagerEnabled
PasswordSharingEnabled

## PluginVm
PluginVmAllowed
PluginVmDataCollectionAllowed
PluginVmImage
PluginVmLicenseKey
PluginVmRequiredFreeDiskSpace
PluginVmUserId
UserPluginVmAllowed

## Power and shutdown
DeviceLoginScreenPowerManagement
DeviceRebootOnShutdown
UptimeLimit

## Power management
AllowScreenWakeLocks
AllowWakeLocks
DeviceAdvancedBatteryChargeModeDayConfig
DeviceAdvancedBatteryChargeModeEnabled
DeviceBatteryChargeCustomStartCharging
DeviceBatteryChargeCustomStopCharging
DeviceBatteryChargeMode
DeviceBootOnAcEnabled
DeviceChargingSoundsEnabled
DeviceLowBatterySoundEnabled
DevicePowerAdaptiveChargingEnabled
DevicePowerPeakShiftBatteryThreshold
DevicePowerPeakShiftDayConfig
DevicePowerPeakShiftEnabled
DeviceUsbPowerShareEnabled
IdleAction
IdleActionAC
IdleActionBattery
IdleDelayAC
IdleDelayBattery
IdleWarningDelayAC
IdleWarningDelayBattery
LidCloseAction
PowerManagementIdleSettings
PowerManagementUsesAudioActivity
PowerManagementUsesVideoActivity
PowerSmartDimEnabled
PresentationIdleDelayScale
PresentationScreenDimDelayScale
ScreenBrightnessPercent
ScreenDimDelayAC
ScreenDimDelayBattery
ScreenLockDelayAC
ScreenLockDelayBattery
ScreenLockDelays
ScreenOffDelayAC
ScreenOffDelayBattery
UserActivityScreenDimDelayScale
WaitForInitialUserActivity

## Printing
CloudPrintProxyEnabled
CloudPrintSubmitEnabled
CloudPrintWarningsSuppressed
DefaultPrinterSelection
DeletePrintJobHistoryAllowed
DeviceExternalPrintServers
DeviceExternalPrintServersAllowlist
DeviceNativePrinters
DeviceNativePrintersAccessMode
DevicePrinters
DevicePrintersAccessMode
DevicePrintersAllowlist
DevicePrintersBlocklist
DevicePrintingClientNameTemplate
DisablePrintPreview
ExternalPrintServers
ExternalPrintServersAllowlist
NativePrinters
NativePrintersBulkAccessMode
NativePrintersBulkConfiguration
PrintHeaderFooter
PrintJobHistoryExpirationPeriod
PrintPdfAsImageAvailability
PrintPdfAsImageDefault
PrintPostScriptMode
PrintPreviewUseSystemDefaultPrinter
PrintRasterizationMode
PrintRasterizePdfDpi
PrinterTypeDenyList
Printers
PrintersBulkAccessMode
PrintersBulkAllowlist
PrintersBulkBlocklist
PrintersBulkConfiguration
PrintingAPIExtensionsAllowlist
PrintingAllowedBackgroundGraphicsModes
PrintingAllowedColorModes
PrintingAllowedDuplexModes
PrintingAllowedPinModes
PrintingBackgroundGraphicsDefault
PrintingColorDefault
PrintingDuplexDefault
PrintingEnabled
PrintingMaxSheetsAllowed
PrintingPaperSizeDefault
PrintingPinDefault
PrintingSendUsernameAndFilenameEnabled
UserNativePrintersAllowed
UserPrintersAllowed

## Privacy Sandbox policies
PrivacySandboxAdMeasurementEnabled
PrivacySandboxAdTopicsEnabled
PrivacySandboxPromptEnabled
PrivacySandboxSiteEnabledAdsEnabled

## Privacy screen settings
DeviceLoginScreenPrivacyScreenEnabled
PrivacyScreenEnabled

## Private network request settings
InsecurePrivateNetworkRequestsAllowed
InsecurePrivateNetworkRequestsAllowedForUrls
PrivateNetworkAccessRestrictionsEnabled

## Proxy server
ProxyBypassList
ProxyMode
ProxyPacUrl
ProxyServer
ProxyServerMode

## Quick Answers
QuickAnswersDefinitionEnabled
QuickAnswersEnabled
QuickAnswersTranslationEnabled
QuickAnswersUnitConversionEnabled

## Quick unlock
PinUnlockAutosubmitEnabled
PinUnlockMaximumLength
PinUnlockMinimumLength
PinUnlockWeakPinsAllowed
QuickUnlockModeAllowlist
QuickUnlockTimeout

## Related Website Sets Settings
RelatedWebsiteSetsEnabled
RelatedWebsiteSetsOverrides

## Remote access
RemoteAccessClientFirewallTraversal
RemoteAccessHostAllowClientPairing
RemoteAccessHostAllowEnterpriseFileTransfer
RemoteAccessHostAllowEnterpriseRemoteSupportConnections
RemoteAccessHostAllowFileTransfer
RemoteAccessHostAllowRelayedConnection
RemoteAccessHostAllowRemoteAccessConnections
RemoteAccessHostAllowRemoteSupportConnections
RemoteAccessHostAllowUiAccessForRemoteAssistance
RemoteAccessHostClientDomain
RemoteAccessHostClientDomainList
RemoteAccessHostClipboardSizeBytes
RemoteAccessHostDebugOverridePolicies
RemoteAccessHostDomain
RemoteAccessHostDomainList
RemoteAccessHostFirewallTraversal
RemoteAccessHostMatchUsername
RemoteAccessHostMaximumSessionDurationMinutes
RemoteAccessHostRequireCurtain
RemoteAccessHostRequireTwoFactor
RemoteAccessHostTalkGadgetPrefix
RemoteAccessHostUdpPortRange

## Remote attestation
AttestationEnabledForDevice
AttestationEnabledForUser
AttestationExtensionAllowlist
AttestationForContentProtectionEnabled
DeviceWebBasedAttestationAllowedUrls

## Safe Browsing settings
DisableSafeBrowsingProceedAnyway
PasswordProtectionChangePasswordURL
PasswordProtectionLoginURLs
PasswordProtectionWarningTrigger
SafeBrowsingAllowlistDomains
SafeBrowsingDeepScanningEnabled
SafeBrowsingEnabled
SafeBrowsingExtendedReportingEnabled
SafeBrowsingProtectionLevel
SafeBrowsingProxiedRealTimeChecksAllowed
SafeBrowsingSurveysEnabled

## Saml user identity management settings
LockScreenReauthenticationEnabled
SAMLOfflineSigninTimeLimit
SamlInSessionPasswordChangeEnabled
SamlPasswordExpirationAdvanceWarningDays

## Screencast
ProjectorDogfoodForFamilyLinkEnabled
ProjectorEnabled

## Screensaver Settings
DeviceScreensaverLoginScreenEnabled
DeviceScreensaverLoginScreenIdleTimeoutSeconds
DeviceScreensaverLoginScreenImageDisplayIntervalSeconds
DeviceScreensaverLoginScreenImages
ScreensaverLockScreenEnabled
ScreensaverLockScreenIdleTimeoutSeconds
ScreensaverLockScreenImageDisplayIntervalSeconds
ScreensaverLockScreenImages

## Sign-in settings
DeviceAllowNewUsers
DeviceAutofillSAMLUsername
DeviceEphemeralUsersEnabled
DeviceFamilyLinkAccountsAllowed
DeviceGuestModeEnabled
DeviceLoginScreenAutoSelectCertificateForUrls
DeviceLoginScreenDomainAutoComplete
DeviceLoginScreenExtensions
DeviceLoginScreenInputMethods
DeviceLoginScreenIsolateOrigins
DeviceLoginScreenLocales
DeviceLoginScreenPromptOnMultipleMatchingCertificates
DeviceLoginScreenSitePerProcess
DeviceLoginScreenSystemInfoEnforced
DeviceRunAutomaticCleanupOnLogin
DeviceSecondFactorAuthentication
DeviceShowNumericKeyboardForPassword
DeviceShowUserNamesOnSignin
DeviceStartUpFlags
DeviceTransferSAMLCookies
DeviceUserAllowlist
DeviceWallpaperImage
LoginAuthenticationBehavior
LoginVideoCaptureAllowedUrls
ProfileSeparationDataMigrationSettings
ProfileSeparationDomainExceptionList
ProfileSeparationSettings
RecoveryFactorBehavior

## Startup, Home page and New Tab page
HomepageIsNewTabPage
HomepageLocation
NewTabPageLocation
RestoreOnStartup
RestoreOnStartupURLs
ShowHomeButton

## User and device reporting
DeviceActivityHeartbeatEnabled
DeviceFlexHwDataForProductImprovementEnabled
DeviceMetricsReportingEnabled
DeviceReportNetworkEvents
DeviceReportXDREvents
EnableDeviceGranularReporting
HeartbeatEnabled
HeartbeatFrequency
LogUploadEnabled
ReportAppInventory
ReportAppUsage
ReportArcStatusEnabled
ReportCRDSessions
ReportDeviceActivityTimes
ReportDeviceAppInfo
ReportDeviceAudioStatus
ReportDeviceBacklightInfo
ReportDeviceBluetoothInfo
ReportDeviceBoardStatus
ReportDeviceBootMode
ReportDeviceCpuInfo
ReportDeviceCrashReportInfo
ReportDeviceFanInfo
ReportDeviceGraphicsStatus
ReportDeviceHardwareStatus
ReportDeviceLoginLogout
ReportDeviceMemoryInfo
ReportDeviceNetworkConfiguration
ReportDeviceNetworkInterfaces
ReportDeviceNetworkStatus
ReportDeviceOsUpdateStatus
ReportDevicePeripherals
ReportDevicePowerStatus
ReportDevicePrintJobs
ReportDeviceSecurityStatus
ReportDeviceSessionStatus
ReportDeviceStorageStatus
ReportDeviceSystemInfo
ReportDeviceTimezoneInfo
ReportDeviceUsers
ReportDeviceVersionInfo
ReportDeviceVpdInfo
ReportUploadFrequency

## Wilco DTC
DeviceWilcoDtcAllowed
DeviceWilcoDtcConfiguration
Back to top

## new chapter

--enable-features=CookiesWithoutSameSiteMustBeSecure,SameSiteByDefaultCookies

curl -s http://omahaproxy.appspot.com/all.json | jq -r '.[] | select(.os=="win") | .versions[] | select(.channel=="stable") | .current_version'

# passwords no longer saving
https://superuser.com/questions/573602/chrome-not-saving-passwords-and-not-auto-filling-existing-login-passwords
rm -f ~/.config/chromium/*/Login\ Data{,-journal}


# printscreen
* https://swimburger.net/blog/web/hidden-gem-take-screenshots-using-built-in-commands-in-chrome-edge#capture-full-size-screenshot
steps:
*  F12, go to developer tools, console
* control-shift-P (bring up Chrome DevTools Command Menu)
* type "Full" to search for "Capture full size screenshot"
* press Enter, a png image file whose name matches most of the URL, has been saved to ~/Downloads


# control-f find hijacking search
workaround: select location bar, then do you control-f


https://chromiumdash.appspot.com/fetch_releases?channel=Stable&platform=Linux&num=1&offset=0
https://chromiumdash.appspot.com/fetch_releases?channel=Stable&platform=Windows&num=1&offset=0

# certificates custom root / intermediate
  # https://superuser.com/questions/1717914/make-chrome-trust-the-linux-system-certificate-store-or-select-certificates-via
  # 1) is import with certutil to each applications  cert8.db or cert9.db
  # 2) is to do some clever with the libraries like 
  sudo ln -s -f /usr/lib/x86_64-linux-gnu/pkcs11/p11-kit-trust.so /usr/lib/x86_64-linux-gnu/nss/libnssckbi.so
