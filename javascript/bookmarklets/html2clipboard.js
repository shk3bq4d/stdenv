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

(new Function("var copy_html_to_clipboard = async function() { try {console.log('trying to copy, ensure page is focused'); await navigator.clipboard.writeText(document.documentElement.outerHTML);console.log('success!');}catch (e) {console.log(e); console.log('try to focus page'); setTimeout(arguments.callee, 1000);}}; setTimeout(copy_html_to_clipboard, 0);"))();
