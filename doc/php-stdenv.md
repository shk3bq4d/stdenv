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
