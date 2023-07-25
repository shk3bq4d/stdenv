crictl  --runtime-endpoint=unix:///run/containerd/containerd.sock ps


# LogLevel
```sh
systemctl edit containerd
```
```ini
[Service]
ExecStart=/usr/bin/containerd --log-level trace
```
