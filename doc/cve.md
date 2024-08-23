# CVE-2023-48795 OpenSSH Terrapin
* https://github.com/RUB-NDS/Terrapin-Scanner/releases/tag/v1.1.0
* https://github.com/RUB-NDS/Terrapin-Scanner/releases/download/v1.1.0/Terrapin_Scanner_Linux_amd64
* https://forum.proxmox.com/threads/cve-2023-48795-proxmox-is-vulnerable-to-terrapin-as-of-right-now.138488/#post-618071
* https://seclists.org/oss-sec/2023/q4/292
* https://access.redhat.com/security/cve/cve-2023-48795
* https://forums.centos.org/viewtopic.php?f=51&t=80511

# CVE-2023-44487 HTTP/2 Rapid Reset Attack
* https://github.com/kubernetes/ingress-nginx/issues/10493
* https://nvd.nist.gov/vuln/detail/CVE-2023-44487

# 2023.10.10 CVE-2023-38545 Curl and libcurl Vulnerabilities
# 2023.10.10 CVE-2023-38546 Curl and libcurl Vulnerabilities

# 2023.08.31 CVE-2023-41721 Unifi Controller
* https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-41721
* https://community.ui.com/releases/Security-Advisory-Bulletin-036-036/81367bc9-2a64-4435-95dc-bbe482457615
* https://github.com/jacobalberty/unifi-docker/issues/696
* https://github.com/jacobalberty/unifi-docker/pull/694

# 2023.10.31 CVE-2023-22518 Confluence
* https://www.helpnetsecurity.com/2023/10/31/cve-2023-22518/

# 2023.11.03 CVE-2023-46724 squid ssl_bump
* https://access.redhat.com/security/cve/cve-2023-46724

# 2023.11.20 CVE-2023-6175 wireshark netscreen
* https://access.redhat.com/security/cve/cve-2023-6175


# 2024.05.24 CVE-2024-1597 jira postgresql
https://jira.atlassian.com/browse/JSWSERVER-25896
```sh
sudo docker run --rm -it atlassian/jira-software:9.12.6 sh -c "ls -l /opt/atlassian/jira/lib/postgres*"
/opt/atlassian/jira/lib/postgresql-42.7.2.jar
sudo docker run --rm -it atlassian/jira-software:9.12.5 sh -c "ls -l /opt/atlassian/jira/lib/postgres*"
/opt/atlassian/jira/lib/postgresql-42.6.0.jar
```


# 2024.05.24 CVE-2024-22257 jira spring-security-core
https://jira.atlassian.com/browse/JSWSERVER-25905



# 2024.07.01 CVE-2024-6387 OpenSSH RegreSSHion
https://www.qualys.com/regresshion-cve-2024-6387/
timeout 1 nc localhost 22

## debian
https://security-tracker.debian.org/tracker/CVE-2024-6387
bookworm	1:9.2p1-2+deb12u2	vulnerable
bookworm (security)	1:9.2p1-2+deb12u3	fixed
bullseye (proxmox) 1:8.4p1-5+deb11u3 fixed

## ubuntu
https://ubuntu.com/security/CVE-2024-6387
jammy	Released (1:8.9p1-3ubuntu0.10)

## affected version checker
but does not passes for fixed debian
https://github.com/xaitax/CVE-2024-6387_Check/blob/main/CVE-2024-6387_Check.py
        'SSH-2.0-OpenSSH_8.5p1',
        'SSH-2.0-OpenSSH_8.6p1',
        'SSH-2.0-OpenSSH_8.7p1',
        'SSH-2.0-OpenSSH_8.8p1',
        'SSH-2.0-OpenSSH_8.9p1',
        'SSH-2.0-OpenSSH_9.0p1',
        'SSH-2.0-OpenSSH_9.1p1',
        'SSH-2.0-OpenSSH_9.2p1',
        'SSH-2.0-OpenSSH_9.3p1',
        'SSH-2.0-OpenSSH_9.4p1',
        'SSH-2.0-OpenSSH_9.5p1',
        'SSH-2.0-OpenSSH_9.6p1',
        'SSH-2.0-OpenSSH_9.7p1'
