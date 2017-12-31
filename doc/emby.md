@begin=sh@
curl -vX POST -H "Content-Length: 0" -H 'x-emby-authorization: MediaBrowser Client="Emby Mobile", Device="Chrome", DeviceId="e92ff4f01cc5a1b8399980ba46348a03b256ce93", Version="3.2.20.0", Token="0f933879758443ee9bb38d9767ff02a3"' http://jemby.ly.lan:8096/emby/ScheduledTasks/Running/6330ee8fb4a957f33981f89aa78b030f
@end=sh@
Request URL:http://jemby.ly.lan:8096/emby/ScheduledTasks/Running/6330ee8fb4a957f33981f89aa78b030f
Request Method:POST
Status Code:204 No Content
Remote Address:10.1.1.100:8096
Referrer Policy:no-referrer-when-downgrade

POST /emby/ScheduledTasks/Running/6330ee8fb4a957f33981f89aa78b030f HTTP/1.1
Host: jemby.ly.lan:8096
Connection: keep-alive
Content-Length: 0
Pragma: no-cache
Cache-Control: no-cache
Origin: http://jemby.ly.lan:8096
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/59.0.3071.109 Chrome/59.0.3071.109 Safari/537.36
x-emby-authorization: MediaBrowser Client="Emby Mobile", Device="Chrome", DeviceId="e92ff4f01cc5a1b8399980ba46348a03b256ce93", Version="3.2.20.0", Token="0f933879758443ee9bb38d9767ff02a3"
Accept: */*
DNT: 1
Referer: http://jemby.ly.lan:8096/web/scheduledtasks.html
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.8,fr;q=0.6

HTTP/1.1 204 No Content
Access-Control-Allow-Headers: Accept, Accept-Language, Authorization, Cache-Control, Content-Disposition, Content-Encoding, Content-Language, Content-Length, Content-MD5, Content-Range, Content-Type, Date, Host, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, Origin, OriginToken, Pragma, Range, Slug, Transfer-Encoding, Want-Digest, X-MediaBrowser-Token, X-Emby-Authorization
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, PATCH, OPTIONS
Access-Control-Allow-Origin: *
Server: Mono-HTTPAPI/1.0
Date: Sun, 20 Aug 2017 13:13:09 GMT
Content-Length: 0
Status: 204
