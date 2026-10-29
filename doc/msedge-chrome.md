/usr/bin/google-chrome --version
https://github.com/MicrosoftDocs/Edge-Enterprise/blob/public/edgeenterprise/microsoft-edge-policies.md#passwordmanagerenabled


deb [arch=amd64 signed-by=/etc/apt/keyrings/70-iaac-microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main
deb [arch=amd64 signed-by=/etc/apt/keyrings/70-iaac-microsoft.gpg] https://packages.microsoft.com/repos/edge stable main
deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main

/usr/bin/microsoft-edge


"C:\Program Files\Google\Chrome\Application\chrome" --ignore-certificate-errors


```sh
chattr +i /etc/apt/sources.list.d/microsoft-edge.list # lock file to prevent modification

cat <<EOF | sudo tee /etc/apt/sources.list.d/90-manual-microsoft-edge.sources && sudo apt update && sudo apt install microsoft-edge-stable
Allow-Insecure: no
Allow-Weak: no
Architectures: amd64
Components: main
Enabled: yes
X-Repolib-Name: microsoft
Signed-By:
    -----BEGIN PGP PUBLIC KEY BLOCK-----
    Version: GnuPG v1.4.7 (GNU/Linux)
    .
    mQENBFYxWIwBCADAKoZhZlJxGNGWzqV+1OG1xiQeoowKhssGAKvd+buXCGISZJwT
    LXZqIcIiLP7pqdcZWtE9bSc7yBY2MalDp9Liu0KekywQ6VVX1T72NPf5Ev6x6DLV
    7aVWsCzUAF+eb7DC9fPuFLEdxmOEYoPjzrQ7cCnSV4JQxAqhU4T6OjbvRazGl3ag
    OeizPXmRljMtUUttHQZnRhtlzkmwIrUivbfFPD+fEoHJ1+uIdfOzZX8/oKHKLe2j
    H632kvsNzJFlROVvGLYAk2WRcLu+RjjggixhwiB+Mu/A8Tf4V6b+YppS44q8EvVr
    M+QvY7LNSOffSO6Slsy9oisGTdfE39nC7pVRABEBAAG0N01pY3Jvc29mdCAoUmVs
    ZWFzZSBzaWduaW5nKSA8Z3Bnc2VjdXJpdHlAbWljcm9zb2Z0LmNvbT6JATUEEwEC
    AB8FAlYxWIwCGwMGCwkIBwMCBBUCCAMDFgIBAh4BAheAAAoJEOs+lK2+EinPGpsH
    /32vKy29Hg51H9dfFJMx0/a/F+5vKeCeVqimvyTM04C+XENNuSbYZ3eRPHGHFLqe
    MNGxsfb7C7ZxEeW7J/vSzRgHxm7ZvESisUYRFq2sgkJ+HFERNrqfci45bdhmrUsy
    7SWw9ybxdFOkuQoyKD3tBmiGfONQMlBaOMWdAsic965rvJsd5zYaZZFI1UwTkFXV
    KJt3bp3Ngn1vEYXwijGTa+FXz6GLHueJwF0I7ug34DgUkAFvAs8Hacr2DRYxL5RJ
    XdNgj4Jd2/g6T9InmWT0hASljur+dJnzNiNCkbn9KbX7J/qK1IbR8y560yRmFsU+
    NdCFTW7wY0Fb1fWJ+/KTsC4=
    =J6gs
    -----END PGP PUBLIC KEY BLOCK-----
Suites: stable
Trusted: yes
Types: deb
URIs: https://packages.microsoft.com/repos/edge
EOF
```


# hardware acceleration
HardwareAccelerationModeEnabled: false #  /etc/opt/edge/policies/managed/managed.json
microsoft-edge --disable-gpu
edge://gpu


# hangs
since recently, my linux microsoft edge browser's tab hangs on both outlook.com and azure devops, when editing the email subject or editing a discussion message. I can type one of two words and suddenly it hangs, eventually leading to an "SIGILL" Error code.

I have disabled extension with no change

what could be the reason?
Searched the web

Typing a word or two and then hanging points to something that runs on the text you type. On Linux, a SIGILL crash in Edge almost always means the browser deliberately crashed its own tab after hitting an internal error. It’s not a hardware or CPU problem. So this is most likely a bug in a recent Edge update, set off by a feature that kicks in while you type in rich text editors like Outlook’s and Azure DevOps’.

The usual suspects, roughly in order of likelihood:

    Microsoft Editor spell/grammar check. It checks words as you finish them, which matches the “one or two words, then hang” pattern. Go to edge://settings/languages and switch “Grammar and spelling assistance” from Microsoft Editor to Basic, or turn it off, then test.
    Text prediction and writing assistance. On the same settings page, turn off text prediction. Also turn off any Copilot “compose” or rewrite suggestions under edge://settings/sidebar or edge://settings/privacy, depending on your version.
    Input method (IBus/Fcitx), especially on Wayland. Edge talks to your input method on every keystroke, and Wayland IME support in Chromium has had crash bugs. Test by starting Edge under X11: microsoft-edge --ozone-platform=x11. You can also temporarily switch your input method to plain keyboard.
    GPU acceleration. This is less likely given the typing trigger, but quick to rule out: microsoft-edge --disable-gpu.

Two quick checks will narrow it down:

    Try an InPrivate window, or a fresh profile or Guest. If the problem goes away, it’s a profile setting or corrupted data, not Edge itself.
    Launch Edge from a terminal and reproduce the crash. The last lines printed before the crash often name the component, such as spellcheck, IME or GPU. edge://crashes also keeps crash IDs you can attach to a report.

If none of the settings changes help, it’s probably a regression in your current Edge version. Edge on Linux has had SIGILL crashes like this before, and they were fixed in the next update. Check your version at edge://version and update if one is available. You could also install Edge Beta alongside it to see whether the newer build is fixed. Either way, send feedback with Alt+Shift+I right after a crash so Microsoft gets the crash ID.

If you tell me your distro, whether you’re on Wayland or X11, and your Edge version, I can narrow it down further.
