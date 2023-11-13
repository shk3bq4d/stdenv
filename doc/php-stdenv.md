* https://www.php.net/ChangeLog-8.php#8.1.25 release changelog version
* https://www.php.net/downloads.php
* Unsupported Historical Releases https://www.php.net/releases/index.php

# EOL
* end-of-life lifecycle versions https://www.php.net/supported-versions.php

Branch  Initial Release  Active Support Until    Security Support Until
8.0     26 Nov 2020      26 Nov 2022             26 Nov 2023
8.1     25 Nov 2021      25 Nov 2023             25 Nov 2024
8.2      8 Dec 2022       8 Dec 2024              8 Dec 2025

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
sleep(3600);
echo curl_exec(curl_init("http://localhost"));
```

```sh
php -a # interactive mode
php -r 'echo curl_exec(curl_init("http://localhost"));' # execute command from shell
php -r '$ch = curl_init("http://localhost")); echo curl_exec($ch); echo "error: $curl_error($ch)";' # execute command from shell
php -l /my/php/file.php # validate syntax --syntax-check
php --syntax-check /my/php/file.php # validate syntax --syntax-check
```
```php
function mylog($message, $logFile = "/var/www/html/var/logs/bip.log") {
  $timestamp = date("Y-m-d H:i:s");
  $logEntry = "[$timestamp] $message\n";
  file_put_contents($logFile, $logEntry, FILE_APPEND);
}

in_array($valueToCheck, $array, $same_type_boolnean);
explode(":", "a:b:c");       # split
implode(":", ["a","b","c"]); # join
```
