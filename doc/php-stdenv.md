# debug craft mysql connection
```php <?php
$mysqli = mysqli_init();
$mysqli->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, true);
$mysqli->ssl_set(NULL, NULL, "/var/www/html/BaltimoreCyberTrustRoot.crt.pem", NULL, NULL);
$mysqli->real_connect(getenv('DB_SERVER'), getenv('DB_USER'), getenv('DB_PASSWORD'), getenv('DB_DATABASE'));
$result = $mysqli->query("select name from sites");
while($row = $result->fetch_assoc()) { echo $row['name'] . "\n"; }
$result->close();
$mysqli->close();
```


```php
echo curl_exec(curl_init("http://localhost"));
```

```sh
php -a # interactive mode
php -r 'echo curl_exec(curl_init("http://localhost"));' # execute command from shell
php -r '$ch = curl_init("http://localhost")); echo curl_exec($ch); echo "error: $curl_error($ch)";' # execute command from shell
```
