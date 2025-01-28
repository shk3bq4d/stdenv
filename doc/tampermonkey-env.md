# disable update tab
# disable "WARNING: your're using an unofficial version of Tampermonkey.  Please check it for malware because this version was re-packaged!"
you have to disable "show TM update notification" in advanced config
https://github.com/Tampermonkey/tampermonkey/issues/427

# update script
on extension bar
right click -> option
installed userscripts
click on script name
in the File menu of the Editor tab
Check for updates

# match include
https://stackoverflow.com/questions/71882835/convert-deprecated-include-with-regular-expression-to-match-in-userscript

extensions
tampermonkey
dashboard
+
(Delete all content)
paste from
curl -s http://localhost:57155/tampermonkey/mr.py XC

~/git/$USER/websupport/tampermonkey

# installation
enable developer mode on chrome extension global dashboard # troubleshooting errors not working
http://localhost:57155/tampermonkey/mr.py


// ==UserScript==
// @name         Mr
// @namespace    http://abc1.ch/
// @version      20240309.0934.53
// @description  Tenter de conquerir le monde
// @updateURL    http://localhost:57155/tampermonkey/mr.py
// @downloadURL  http://localhost:57155/tampermonkey/mr.py
// @author       Burp
// @match        https://*/*
// @match        http://*/*
// @exclude      http://localhost:57155/*
// @exclude      https://localhost:57155/*
// @require http://code.jquery.com/jquery-latest.js
// @connect localhost
// @connect localhost:57155
// @connect raw.githubusercontent.com
// @connect localhost:57155
// @connect        my.stonehagefleming.com
// @connect localhost:57155
// @grant GM_xmlhttpRequest
// @grant GM_log
// ==/UserScript==
/* eslint-disable no-multi-spaces */
// https://stackoverflow.com/questions/71882835/convert-deprecated-include-with-regular-expression-to-match-in-userscript

(   function () {
    'use strict';


    var bString;

    var ff40 = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
    var ie10 =  'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)';
    var url = "http://localhost:57155/tampermonkey/mr2.py";

    if (false && /^mail.nagra.com$/.test(location.host)) // doing in extension as  this hopefully precedes first http request
    {    bString = ff40;
    }
    if (bString)
    {
        GM_log('Mr-agentswitcher.js trying ' + bString);
        Object.defineProperty(navigator, 'userAgent', {
            value:bString
             });
        GM_log('Mrdone');
    }

    GM_log('mr.' + 'js 1 version: %s preparing GM_xmlhttpRequest', "20240309.0934.53", "localhost:57155"); // the + is here as mr.py modifies content
    GM_xmlhttpRequest(
    {
        method: "GET",
        url: url,
        onload: function(d)
        {   GM_log('mr' + '.js 3 successfully received %s response', url);
            try
            {   eval(d.responseText);
                GM_log('mr' + ".js 4 successfully eval'ed content from %s", url);
            }
            catch (e)
            {   GM_log('mr' + '.js 5 exception evaluating content from mr2.py:\n', e);
                if (e.message && e.message.toString().indexOf("unsafe-eval") >= 0)
                {   var bScript = document.createElement("SCRIPT");
                    bScript.type = "text/javascript";
                    bScript.text = d.responseText;
                    //bScript.src = "http://localhost:57155/tampermonkey/mr2.py";
                    try
                    {   document.getElementsByTagName('head')[0].appendChild(bScript);
                        GM_log('mr' + '.js 6 appended script element B');
                    }
                    catch (f)
                    {
                        GM_log('mr' + '.js 7 further exception');
                        bScript = document.createElement("SCRIPT");
                        bScript.type = "text/javascript";
                        bScript.src = "http://localhost:57155/tampermonkey/mr2.py";
                        try
                        {   document.getElementsByTagName('head')[0].appendChild(bScript);
                        }
                        catch (f)
                        {
                            GM_log('mr' + '.js 8 further exception giving up');
                        }
                    }
                }
            }
        }
    });
    GM_log('mr.' + 'js 2: %s GM_xmlhttpRequest to %s sent', location.href, url); // the + is here as mr.py modifies content
})();

/* vim: set expandtab: */
