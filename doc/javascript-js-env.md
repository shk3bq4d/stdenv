```js
setTimeout(function() {alert(1);}, 10)
location.reload(true) // refresh

async function go_blocking() { // await
    var text = await navigator.clipboard.readText(); // async
    document.getElementById('textarea').value = text;
};

slice // does substring while allowing negative values


var bA = document._getElementsByXPath("//input[@type='checkbox']"); for (var k = bA.length - 1; k >= 0; --k) {bA[k].checked = true;} // zabbix template import select all box

encodeURIComponent
encodeURI()
push() // append, extend
["Banana", "Orange", "Apple", "Mango"].join(",") // merge split


"hehe".replace(/h/g, "_");
"aaaaa_bbbbbc_ddddddeeeeee=ffffff".replace(/(.)[_=]/g, "__$1__");
"hehe".replace(/h/g, function(matchstr, pos, fullstr) {return matchstr.toUpperCase();});

toLowerCase

try{
    // Try something wrong here
}
catch(e){
    var xcb="http://stackoverflow.com/search?q=[js]+"+e.message;
    window.open(xcb, '_blank');
    // https://github.com/gautamkrishnar/tcso/blob/master/javascript/tcso.js
}
```


# lint JSHINT

```sh
# https://github.com/jshint/jshint
# https://hub.docker.com/r/eeacms/jshint
docker run -it --rm -v $PWD:/code eeacms/jshint # lint
~/bin/javascript-lint.sh
```

# https://stackoverflow.com/questions/12977661/is-there-a-way-to-suppress-jshint-warning-for-one-given-line
```js
// Code here will be linted with JSHint.
// /* jshint ignore:start */
// // Code here will be ignored by JSHint.
// /* jshint ignore:end */
// // Code here will be linted with JSHint.
// You can also ignore a single line with a trailing comment like this:
//
// ignoreThis(); // jshint ignore:line
```

# notifications
* https://www.bennish.net/web-notifications.html # alert

JSON.stringify()


# CLI docker node.js
```sh
sudo docker run -it -v ~/tmp/js:/js --rm node:lts-alpine
.load /js/bip.js
sudo docker run -it -v ~/tmp/js:/js --rm node:lts-alpine /js/bip.js # console.log
```
# node.js reading one file
```js
var fs = require('fs');
var path = require('path');
function bufferFile(relPath) {
    return fs.readFileSync(path.join(__dirname, relPath));
}
var content = JSON.parse(bufferFile('nextcloud.log').toString());
```
