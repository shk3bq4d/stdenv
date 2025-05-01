apt install ttyplot

```sh
while true; do
  df --output=pcent /tmp | tail -n1 | tr -d ' %'   # just the numeric value
  sleep 1
done | ttyplot -u "%"

while true; do df --output=pcent /tmp | tail -n1 | tr -d ' %'; sleep 10; done | ttyplot -u "%"
while true; do df --output=avail /tmp | tail -n1 | tr -d ' %'; sleep 10; done | ttyplot -u "avail"
while true; do df --output=used  /tmp | tail -n1 | tr -d ' %'; sleep 10; done | ttyplot -u "used"

```
