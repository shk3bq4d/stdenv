
https://superuser.com/questions/952870/how-do-i-force-ie-and-or-microsoft-edge-to-reload-pac-file
Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings
Value: EnableAutoproxyResultCache (REG_DWORD)
1 (default) = enable caching and 0 = disable caching

file://C:\Users\myuser\cygwin64\home\myuser\proxy.corp.pac

chrome://net-internals/#events
PAC_JAVASCRIPT_ALERT
PROXY_SCRIPT_DECIDER
```js
alert("Local IP address is: " + myIpAddress());

    var b = "PROXY valid.example.com:8080";
    var g = "PROXY wontwork.exampl.com:8080"; // this does not work

    var gb = g + ";" + b;

    var ip = myIpAddress();
    var last_member = parseInt(ip.replace(/(.*)\.(\d+)$/, "$2")); // last member of IP address

    // distributed load based on hash modulo three of IP
    if (last_member % 3 === 0)
    {   return gb;
    }
    else if (last_member % 3 == 1)
    {   return gc;
    }
    else if (last_member % 3 == 2)
    {   return gd;
    }
    return g;
```
