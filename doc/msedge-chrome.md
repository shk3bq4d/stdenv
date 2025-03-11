/usr/bin/google-chrome --version
https://github.com/MicrosoftDocs/Edge-Enterprise/blob/public/edgeenterprise/microsoft-edge-policies.md#passwordmanagerenabled


deb [arch=amd64 signed-by=/etc/apt/keyrings/70-iaac-microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main
deb [arch=amd64 signed-by=/etc/apt/keyrings/70-iaac-microsoft.gpg] https://packages.microsoft.com/repos/edge stable main
deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main

/usr/bin/microsoft-edge


"C:\Program Files\Google\Chrome\Application\chrome" --ignore-certificate-errors


chattr +i /etc/apt/sources.list.d/microsoft-edge.list # lock file to prevent modification
