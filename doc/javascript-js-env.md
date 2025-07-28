```js
var copy_html_to_clipboard = async function() { try {console.log('trying to copy, ensure page is focused'); await navigator.clipboard.writeText(document.documentElement.outerHTML);console.log('success!');}catch (e) {console.log(e); console.log("try to focus page"); setTimeout(arguments.callee, 1000);}}; setTimeout(copy_html_to_clipboard, 0);

"  a strip ".trim()

delete foH.mykey
delete foH["mykey"]

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
["Banana", "Orange", "Apple", "Mango"].join(",") // merge split explode
"Banana,Orange,Apple,Mango".split(",") // merge split explode join
"Banana Orange Apple Mango".split(" ") // merge split explode join


"hehe".replace(/h/g, "_");
"aaaaa_bbbbbc_ddddddeeeeee=ffffff".replace(/(.)[_=]/g, "__$1__");
"hehe".replace(/h/g, function(matchstr, pos, fullstr) {return matchstr.toUpperCase();});

toLowerCase
myarray.sort()
myarray.shift() # removes and return first element of array
myarray.pop()   # removes and return last  element of array
myarray.at
myarray.concat
myarray.constructor
myarray.copyWithin
myarray.entries
myarray.every
myarray.fill
myarray.filter
myarray.find
myarray.findIndex
myarray.findLast
myarray.findLastIndex
myarray.flat
myarray.flatMap
myarray.forEach
myarray.includes
myarray.indexOf
myarray.join
myarray.keys
myarray.lastIndexOf
myarray.map
myarray.pop
myarray.push # append add
myarray.reduce
myarray.reduceRight
myarray.reverse
myarray.shift
myarray.slice
myarray.some
myarray.sort
myarray.splice
myarray.toLocaleString
myarray.toReversed
myarray.toSorted
myarray.toSpliced
myarray.toString
myarray.unshift
myarray.values
myarray.with

myarray.length

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

# minify
## yui-compressor
* https://github.com/yui/yuicompressor/

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
docker-nodejs-javascript.sh
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

```js
Array.isArray(myvar); // test is instance instanceof type

new Date("2024-10-14T13:59:39.000Z")    // timestamp
Math.round(new Date().getTime() / 1000) // get  timestamp
Math.round(Date.now() / 1000)           // get  timestamp
new Date(1534191480)                    // from timestamp

# filebeat javascript timestamp
e.Get("@timestamp").Add()
e.Get("@timestamp").AddDate()
e.Get("@timestamp").After()
e.Get("@timestamp").AppendFormat()
e.Get("@timestamp").Before()
e.Get("@timestamp").Clock()
e.Get("@timestamp").Compare()
e.Get("@timestamp").Date()
e.Get("@timestamp").Day()
e.Get("@timestamp").Equal()
e.Get("@timestamp").Format()
e.Get("@timestamp").GoString()
e.Get("@timestamp").GobEncode()
e.Get("@timestamp").Hour()
e.Get("@timestamp").ISOWeek()
e.Get("@timestamp").In()
e.Get("@timestamp").IsDST()
e.Get("@timestamp").IsZero()
e.Get("@timestamp").Local()
e.Get("@timestamp").Location()
e.Get("@timestamp").MarshalBinary()
e.Get("@timestamp").MarshalJSON()
e.Get("@timestamp").MarshalText()
e.Get("@timestamp").Minute()
e.Get("@timestamp").Month()
e.Get("@timestamp").Nanosecond()
e.Get("@timestamp").Round()
e.Get("@timestamp").Second()
e.Get("@timestamp").String()
e.Get("@timestamp").Sub()
e.Get("@timestamp").Truncate()
e.Get("@timestamp").UTC()
e.Get("@timestamp").Unix()
e.Get("@timestamp").UnixMicro()
e.Get("@timestamp").UnixMilli()
e.Get("@timestamp").UnixNano()
e.Get("@timestamp").Weekday()
e.Get("@timestamp").Year()
e.Get("@timestamp").YearDay()
e.Get("@timestamp").Zone()
e.Get("@timestamp").ZoneBounds()

# http redirect
<head>
    <title>Redirecting...</title>
    <script type="text/javascript">
        window.onload = function() {
            var newHost = "https://www.example.com";
            var currentPath = window.location.pathname + window.location.search + window.location.hash;
            window.location.href = newHost + currentPath;
        };
    </script>
</head>


/(?<year>\d{4})-\d{2}|\d{2}-(?<year>\d{4})/.exec("2024-12").groups["year"] // regex
outerHTML


function dictToQueryString(params) { return Object.entries(params) .map(([key, val]) => encodeURIComponent(key) + '=' + encodeURIComponent(val)).join('&'); } // { name: 'John Doe', age: 30, city: 'New York' }; -> "name=John%20Doe&age=30&city=New%20York"
function repeatingDictQueryString(params) { return Object.entries(params) .flatMap(([key, val]) => Array.isArray(val) ? val.map(v => `${encodeURIComponent(key)}=${encodeURIComponent(v)}`) : `${encodeURIComponent(key)}=${encodeURIComponent(val)}`) .join('&'); } // { tag: ['js', 'web', 'node'], sort: 'asc' }; -> "tag=js&tag=web&tag=node&sort=asc"


> bashExpansion("abc{1..5}e{_,+}")
[ 'abc1e_', 'abc2e_', 'abc3e_', 'abc4e_', 'abc5e_', 'abc1e+', 'abc2e+', 'abc3e+', 'abc4e+', 'abc5e+' ]
function bashExpansion(str) {
  const match = str.match(/(.*)\{([^}]+)\}(.*)/);
  if (!match) return [str];

  const [_, prefix, body, suffix] = match;

  let parts;
  if (body.includes('..')) {
    const [start, end] = body.split('..').map(Number);
    parts = Array.from({ length: end - start + 1 }, (_, i) => start + i);
  } else {
    parts = body.split(',');
  }

  return parts.flatMap(part => bashExpansion(`${prefix}${part}${suffix}`));
}

new Function("return x;");
