#!bookmarklet-encode.sh
// #!bookmarklet-encode-nomunge.sh
// #!bookmarklet-encode.sh
// #!docker-jshint-jslint.sh ud.js
/* ex: set filetype=javascript fenc=utf-8 expandtab ts=4 sw=4 : */
/* jshint strict: true */
/* jshint node: true */
/* jshint esversion: 9 */
/* globals alert, document, location, prompt, URL, Blob, fetch, navigator, $ */
"use strict";

var k,bA;

bA = document.getElementsByTagName('SCRIPT');
for (k = bA.length - 1; k >= 0; --k)
{   
    bA[k].src = bA[k].innerHTML = '';
}

bA = document.getElementsByTagName('STYLE');
for (k = bA.length - 1; k >= 0; --k)
{   
    if (bA[k] && bA[k].parentNode) bA[k].parentNode.removeChild(bA[k]);
}

(
// async function do not pass the yuicompressor
new Function("var copy_html_to_clipboard = async function() { try {console.log('trying to copy, ensure page is focused'); await navigator.clipboard.writeText(document.documentElement.outerHTML);console.log('success!');}catch (e) {console.log(e); console.log('try to focus page'); setTimeout(arguments.callee, 1000);}}; setTimeout(copy_html_to_clipboard, 0);")
)();
