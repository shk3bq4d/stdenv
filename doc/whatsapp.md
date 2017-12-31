~strikethrough~
*bold*
_italic_


```
monospaced multiline text
hihi
```

yowsup-cli
yowsup-cli-mr registration --env android --requestcode sms --phone 41794276772 --cc 41 --mcc 228 --mnc 02 --debug
INFO:yowsup.common.http.warequest:b'{"login":"41794276772","status":"sent","length":6,"method":"sms","retry_after":65,"sms_wait":65,"voice_wait":65}\n'
login: b'41794276772'
retry_after: 65
status: b'sent'
length: 6
method: b'sms'
yowsup-cli-mr registration --env android --register 442-333 --phone 41794276772 --cc 41 --mcc 228 --mnc 02 --debug
INFO:yowsup.common.http.warequest:b'{"status":"ok","login":"41794276772","type":"existing","pw":"u6gvT/PDxxxxxxxxxxBF1FN4Hjc=","expiration":4444444444.0,"kind":"free","price":"$0.99","cost":"0.99","currency":"USD","price_expiration":1509562800}\n'
login: b'41794276772'
status: b'ok'
price_expiration: 1509562800
currency: b'USD'
price: b'$0.99'
pw: b'u6gvT/PDxxxxxxxxxxBF1FN4Hjc='
kind: b'free'
expiration: 4444444444.0

@begin=python@
# https://github.com/tgalal/yowsup/issues/2237
from yowsup.env import env_android
env_android.AndroidYowsupEnv._MD5_CLASSES = "ox998VW0nBTueMVfjuZkmQ=="
env_android.AndroidYowsupEnv._KEY = "eQV5aq/Cg63Gsq1sshN9T3gh+UUp0wIw0xgHYT1bnCjEqOJQKCRrWxdAe2yvsDeCJL+Y4G3PRD2HUF7oUgiGo8vGlNJOaux26k+A2F3hj8A="
env_android.AndroidYowsupEnv._VERSION = "2.17.212"
env_android.AndroidYowsupEnv._OS_NAME = "Android"
env_android.AndroidYowsupEnv._OS_VERSION = "4.3"
env_android.AndroidYowsupEnv._DEVICE_NAME = "armani"
env_android.AndroidYowsupEnv._MANUFACTURER = "Xiaomi"
env_android.AndroidYowsupEnv._BUILD_VERSION = "JLS36C"
env_android.AndroidYowsupEnv._AXOLOTL = True
@end=python@
