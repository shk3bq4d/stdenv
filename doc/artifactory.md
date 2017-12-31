
# freebsd
Message from artifactory-5.4.1:
=== INSTALLATION ===

Artifactory is now installed in /usr/local/artifactory

You may want to activate it in /etc/rc.conf:

  # echo artifactory_enable="YES" >> /etc/rc.conf

Now, start Artifactory:

  # service artifactory start

Once Artifactory is started, point your web browser to:

http://localhost:8081/

Artifactory configuration files are located in /usr/local/artifactory/etc

Please don't forget to review and edit the files in the
/usr/local/artifactory/etc directory to suit your needs.

Full documentation may be found at:

https://www.jfrog.com/confluence/display/RTF/Welcome+to+Artifactory

=== DEINSTALLATION ==

If, when, Artifactory is removed, and you no longer require the
runtime database and configuration files, you can delete the
following directory:

  /var/artifactory

Please double-check before removing this directory as it contains
the database files that Artifactory requires if you do decide to
re-install it again.

Enjoy!
