* http://findproxyforurl.com/pac-functions/
shExpMatch

https://superuser.com/questions/952870/how-do-i-force-ie-and-or-microsoft-edge-to-reload-pac-file
Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings
Value: EnableAutoproxyResultCache (REG_DWORD)
1 (default) = enable caching and 0 = disable caching

file://C:\Users\myuser\cygwin64\home\myuser\proxy.corp.pac

# firefox
about:networking#dns

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



🔧 String/Pattern Matching

    shExpMatch(str, shexp)
    Checks if the string str matches the shell expression shexp (like "*.example.com").

🌐 DNS / IP Functions

    dnsDomainIs(host, domain)
    Checks if host ends in domain.

    isPlainHostName(host)
    Returns true if host does not contain a dot (e.g., intranet).

    dnsResolve(host)
    Resolves a hostname to an IP address as a string.

    isInNet(ipaddr, pattern, mask)
    Returns true if ipaddr is in the given subnet. Useful with dnsResolve().

⏰ Time-Based Functions

    weekdayRange(wd1, wd2, gmt)
    True if the current day is in the specified range ("MON", "TUE", ..., "SUN").

    dateRange(...)
    Can check for specific days, months, years, or ranges.

    timeRange(...)
    Returns true if the current time is within the given range (hours, minutes, seconds).

🌍 Other

    myIpAddress()
    Returns the client’s IP address.

    localHostOrDomainIs(host, hostdom)
    Returns true if host is the same as hostdom or is just the first part of it.
