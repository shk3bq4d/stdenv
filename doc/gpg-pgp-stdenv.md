```sh
gpg --list-keys
gpg --homedir ~/gpgother --list-keys
gpg --import --import-options show-only --with-colons baac/ans/roles/bf-os-packages/files/rpm-gpg-keys/RPM-GPG-KEY-MariaDB
gpg --import --import-options show-only               baac/ans/roles/bf-os-packages/files/rpm-gpg-keys/RPM-GPG-KEY-MariaDB
```

# extend GPG Key Validity
```sh
gpg --edit-key <your-key-ID>
key <number>
expire
```

# be prompted for private key
```sh
gpg --list-secret-keys
gpg --edit-key SECRETKEY
passwd
[save]
```
