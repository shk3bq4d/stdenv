* https://nextcloud.com/changelog/ # release
* https://nextcloud.com/changelog/#latest27
* https://github.com/nextcloud/server/milestones # release
* [hub.docker.com](https://hub.docker.com/_/nextcloud)
* https://docs.nextcloud.com/server/latest/admin_manual/installation/system_requirements.html # database support

https://github.com/nextcloud/server/wiki/Maintenance-and-Release-Schedule # end of life

Version code  Version name  Release date  End of life  Current version       Next version
30            Hub 9         2024-04-24    2025-04
29            Hub 8         2024-04-24    2025-04
28            Hub 7         2023-12-12    2024-12
27.1          Hub 6         2023-06-13    2024-06
27.0          Hub 5         2023-06-13    2024-06
26            Hub 4         2023-03-21    2024-03
25            Hub 3         2022-10-19    2023-10      25.0.2 (2022-12-08)   25.0.3 (2023-01-12)
24            Hub 2         2022-05-03    2023-05      24.0.8 (2022-12-08)   24.0.9 (2023-01-12)
23            Hub 2         2021-11-30    2022-12      23.0.12 (2022-12-08)  End of Life
22            Hub           2021-07-06    2022-07      22.2.10 (2022-07-18)  End of Life
21            Hub           2021-02-22    2022-02      21.0.9 (2022-02-15)   End of Life
20            Hub           2020-10-03    2021-11      20.0.14 (2021-11-11)  End of Life
19            Hub           2020-06-03    2021-06      19.0.13 (2021-07-01)  End of Life
18            Hub           2020-01-16    2021-01      18.0.14 (2021-01-27)  End of Life
17            17            2019-09-30    2020-10      17.0.10 (2020-10-08)  End of Life
16            16            2019-04-25    2020-06      16.0.11 (2020-06-04)  End of Life
15            15            2018-12-10    2019-12      15.0.14 (2019-12-19)  End of Life
14            14            2018-09-10    2019-09      14.0.14 (2019-08-15)  End of Life
13            13            2018-02-06    2019-02      13.0.12 (2019-02-28)  End of Life
12            12            2017-05-22    2018-11      12.0.13 (2018-11-22)  End of Life
11            11            2016-12-13    2018-03      11.0.8 (2018-03-15)   End of Life
10            10            2016-08-25    2017-08      10.0.6 (2017-08-07)   End of Life
9             9             2016-03-08    2017-04      9.0.58 (2017-04-24)   End of Life

# condensed config.sample.php 20.0.14
docker run --rm -it nextcloud:20.0.14-apache cat /usr/src/nextcloud/config/config.sample.php
```php
<?php

$CONFIG = [

'instanceid' => '',
'passwordsalt' => '',
'trusted_domains' =>
   [
    'demo.example.org',
    'otherdomain.example.org',
    '10.111.112.113',
    '[2001:db8::1]'
  ],
'datadirectory' => '/var/www/nextcloud/data',
'version' => '',
'dbtype' => 'sqlite3',
'dbhost' => '',
'dbname' => 'nextcloud',
'dbuser' => '',
'dbpassword' => '',
'dbtableprefix' => '',
'installed' => false,
'default_language' => 'en',
'force_language' => 'en',
'default_locale' => 'en_US',
'force_locale' => 'en_US',
'defaultapp' => 'dashboard,files',
'knowledgebaseenabled' => true,
'allow_user_to_change_display_name' => true,
'remember_login_cookie_lifetime' => 60*60*24*15,
'session_lifetime' => 60 * 60 * 24,
'session_keepalive' => true,
'auto_logout' => false,
'token_auth_enforced' => false,
'token_auth_activity_update' => 60,
'auth.bruteforce.protection.enabled' => true,
'auth.webauthn.enabled' => true,
'skeletondirectory' => '/path/to/nextcloud/core/skeleton',
'lost_password_link' => 'https://example.org/link/to/password/reset',
'mail_domain' => 'example.com',
'mail_from_address' => 'nextcloud',
'mail_smtpdebug' => false,
'mail_smtpmode' => 'smtp',
'mail_smtphost' => '127.0.0.1',
'mail_smtpport' => 25,
'mail_smtptimeout' => 10,
'mail_smtpsecure' => '',
'mail_smtpauth' => false,
'mail_smtpauthtype' => 'LOGIN',
'mail_smtpname' => '',
'mail_smtppassword' => '',
'mail_template_class' => '\OC\Mail\EMailTemplate',
'mail_send_plaintext_only' => false,
'mail_smtpstreamoptions' => [],
'mail_sendmailmode' => 'smtp',
'overwritehost' => '',
'overwriteprotocol' => '',
'overwritewebroot' => '',
'overwritecondaddr' => '',
'overwrite.cli.url' => '',
'htaccess.RewriteBase' => '/',
'htaccess.IgnoreFrontController' => false,
'proxy' => '',
'proxyuserpwd' => '',
'proxyexclude' => [],
'allow_local_remote_servers' => true,
'trashbin_retention_obligation' => 'auto',
'versions_retention_obligation' => 'auto',
'appcodechecker' => true,
'updatechecker' => true,
'updater.server.url' => 'https://updates.nextcloud.com/updater_server/',
'updater.release.channel' => 'stable',
'has_internet_connection' => true,
'connectivity_check_domains' => [
    'www.nextcloud.com',
    'www.startpage.com',
    'www.eff.org',
    'www.edri.org'
],
'check_for_working_wellknown_setup' => true,
'check_for_working_htaccess' => true,
'check_data_directory_permissions' => true,
'config_is_read_only' => false,
'log_type' => 'file',
'logfile' => '/var/log/nextcloud.log',
'logfilemode' => 0640,
'loglevel' => 2,
'syslog_tag' => 'Nextcloud',
'log.condition' => [
    'shared_secret' => '57b58edb6637fe3059b3595cf9c41b9',
    'users' => ['sample-user'],
    'apps' => ['files'],
],
'logdateformat' => 'F d, Y H:i:s',
'logtimezone' => 'Europe/Berlin',
'log_query' => false,
'log_rotate_size' => 100 * 1024 * 1024,
'customclient_desktop' =>
    'https://nextcloud.com/install/#install-clients',
'customclient_android' =>
    'https://play.google.com/store/apps/details?id=com.nextcloud.client',
'customclient_ios' =>
    'https://itunes.apple.com/us/app/nextcloud/id1125420102?mt=8',
'customclient_ios_appid' =>
        '1125420102',
'appstoreenabled' => true,
'appstoreurl' => 'https://apps.nextcloud.com/api/v1',
'apps_paths' => [
    [
        'path'=> '/var/www/nextcloud/apps',
        'url' => '/apps',
        'writable' => true,
    ],
],
'enable_previews' => true,
'preview_max_x' => 4096,
'preview_max_y' => 4096,
'preview_max_filesize_image' => 50,
'preview_libreoffice_path' => '/usr/bin/libreoffice',
'preview_office_cl_parameters' =>
    ' --headless --nologo --nofirststartwizard --invisible --norestore '.
    '--convert-to png --outdir ',
'enabledPreviewProviders' => [
    'OC\Preview\PNG',
    'OC\Preview\JPEG',
    'OC\Preview\GIF',
    'OC\Preview\BMP',
    'OC\Preview\XBitmap',
    'OC\Preview\MP3',
    'OC\Preview\TXT',
    'OC\Preview\MarkDown',
    'OC\Preview\OpenDocument',
    'OC\Preview\Krita',
],
'ldapUserCleanupInterval' => 51,
'sort_groups_by_name' => false,
'comments.managerFactory' => '\OC\Comments\ManagerFactory',
'systemtags.managerFactory' => '\OC\SystemTag\ManagerFactory',
'maintenance' => false,
'openssl' => [
    'config' => '/absolute/location/of/openssl.cnf',
],
'memcache.local' => '\OC\Memcache\APCu',
'memcache.distributed' => '\OC\Memcache\Memcached',
'redis' => [
    'host' => 'localhost', // can also be a unix domain socket: '/tmp/redis.sock'
    'port' => 6379,
    'timeout' => 0.0,
    'password' => '', // Optional, if not defined no password will be used.
    'dbindex' => 0, // Optional, if undefined SELECT will not run and will use Redis Server's default DB Index.
],
'redis.cluster' => [
    'seeds' => [ // provide some/all of the cluster servers to bootstrap discovery, port required
        'localhost:7000',
        'localhost:7001',
    ],
    'timeout' => 0.0,
    'read_timeout' => 0.0,
    'failover_mode' => \RedisCluster::FAILOVER_ERROR,
    'password' => '', // Optional, if not defined no password will be used.
],
'memcached_servers' => [
    // hostname, port and optional weight. Also see:
    // http://www.php.net/manual/en/memcached.addservers.php
    // http://www.php.net/manual/en/memcached.addserver.php
    ['localhost', 11211],
    //array('other.host.local', 11211),
],
'memcached_options' => [
    // Set timeouts to 50ms
    \Memcached::OPT_CONNECT_TIMEOUT => 50,
    \Memcached::OPT_RETRY_TIMEOUT =>   50,
    \Memcached::OPT_SEND_TIMEOUT =>    50,
    \Memcached::OPT_RECV_TIMEOUT =>    50,
    \Memcached::OPT_POLL_TIMEOUT =>    50,

    // Enable compression
    \Memcached::OPT_COMPRESSION =>          true,

    // Turn on consistent hashing
    \Memcached::OPT_LIBKETAMA_COMPATIBLE => true,

    // Enable Binary Protocol
    \Memcached::OPT_BINARY_PROTOCOL =>      true,

    // Binary serializer vill be enabled if the igbinary PECL module is available
    //\Memcached::OPT_SERIALIZER => \Memcached::SERIALIZER_IGBINARY,
],
'cache_path' => '',
'cache_chunk_gc_ttl' => 60*60*24,
'objectstore' => [
    'class' => 'OC\\Files\\ObjectStore\\Swift',
    'arguments' => [
        // trystack will use your facebook id as the user name
        'username' => 'facebook100000123456789',
        // in the trystack dashboard go to user -> settings -> API Password to
        // generate a password
        'password' => 'Secr3tPaSSWoRdt7',
        // must already exist in the objectstore, name can be different
        'container' => 'nextcloud',
        // prefix to prepend to the fileid, default is 'oid:urn:'
        'objectPrefix' => 'oid:urn:',
        // create the container if it does not exist. default is false
        'autocreate' => true,
        // required, dev-/trystack defaults to 'RegionOne'
        'region' => 'RegionOne',
        // The Identity / Keystone endpoint
        'url' => 'http://8.21.28.222:5000/v2.0',
        // required on dev-/trystack
        'tenantName' => 'facebook100000123456789',
        // dev-/trystack uses swift by default, the lib defaults to 'cloudFiles'
        // if omitted
        'serviceName' => 'swift',
        // The Interface / url Type, optional
        'urlType' => 'internal'
    ],
],
'objectstore' => [
    'class' => 'OC\\Files\\ObjectStore\\Swift',
    'arguments' => [
        'autocreate' => true,
        'user' => [
            'name' => 'swift',
            'password' => 'swift',
            'domain' => [
                'name' => 'default',
            ],
        ],
        'scope' => [
            'project' => [
                'name' => 'service',
                'domain' => [
                    'name' => 'default',
                ],
            ],
        ],
        'tenantName' => 'service',
        'serviceName' => 'swift',
        'region' => 'regionOne',
        'url' => 'http://yourswifthost:5000/v3',
        'bucket' => 'nextcloud',
    ],
],
'objectstore.multibucket.preview-distribution' => false,
'sharing.managerFactory' => '\OC\Share20\ProviderFactory',
'sharing.maxAutocompleteResults' => 0,
'sharing.minSearchStringLength' => 0,
'sharing.enable_share_accept' => false,
'sharing.force_share_accept' => false,
'sharing.enable_share_mail' => true,
'dbdriveroptions' => [
    PDO::MYSQL_ATTR_SSL_CA => '/file/path/to/ca_cert.pem',
    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET wait_timeout = 28800'
],
'sqlite.journal_mode' => 'DELETE',
'mysql.utf8mb4' => false,
'supportedDatabases' => [
    'sqlite',
    'mysql',
    'pgsql',
    'oci',
],
'tempdirectory' => '/tmp/nextcloudtemp',
'hashing_default_password' => false,
'hashingThreads' => PASSWORD_ARGON2_DEFAULT_THREADS,
'hashingMemoryCost' => PASSWORD_ARGON2_DEFAULT_MEMORY_COST,
'hashingTimeCost' => PASSWORD_ARGON2_DEFAULT_TIME_COST,
'hashingCost' => 10,
'blacklisted_files' => ['.htaccess'],
'share_folder' => '/',
'theme' => '',
'cipher' => 'AES-256-CTR',
'minimum.supported.desktop.version' => '2.0.0',
'quota_include_external_storage' => false,
'external_storage.auth_availability_delay' => 1800,
'filesystem_check_changes' => 0,
'part_file_in_storage' => true,
'mount_file' => '/var/www/nextcloud/data/mount.json',
'filesystem_cache_readonly' => false,
'secret' => '',
'trusted_proxies' => ['203.0.113.45', '198.51.100.128', '192.168.2.0/24'],
'forwarded_for_headers' => ['HTTP_X_FORWARDED', 'HTTP_FORWARDED_FOR'],
'max_filesize_animated_gifs_public_sharing' => 10,
'filelocking.enabled' => true,
'filelocking.ttl' => 60*60,
'memcache.locking' => '\\OC\\Memcache\\Redis',
'filelocking.debug' => false,
'upgrade.disable-web' => false,
'debug' => false,
'data-fingerprint' => '',
'copied_sample_config' => true,
'lookup_server' => 'https://lookup.nextcloud.com',
'gs.enabled' => false,
'gs.federation' => 'internal',
'csrf.optout' => [
    '/^WebDAVFS/', // OS X Finder
    '/^Microsoft-WebDAV-MiniRedir/', // Windows webdav drive
],
'simpleSignUpLink.shown' => true,
'login_form_autocomplete' => true,
'files_no_background_scan' => false,
];

# config.sample.php 20.0.14
<?php

/**
 * This configuration file is only provided to document the different
 * configuration options and their usage.
 *
 * DO NOT COMPLETELY BASE YOUR CONFIGURATION FILE ON THIS SAMPLE. THIS MAY BREAK
 * YOUR INSTANCE. Instead, manually copy configuration switches that you
 * consider important for your instance to your working ``config.php``, and
 * apply configuration options that are pertinent for your instance.
 *
 * This file is used to generate the configuration documentation.
 * Please consider following requirements of the current parser:
 *  * all comments need to start with `/**` and end with ` *\/` - each on their
 *    own line
 *  * add a `@see CONFIG_INDEX` to copy a previously described config option
 *    also to this line
 *  * everything between the ` *\/` and the next `/**` will be treated as the
 *    config option
 *  * use RST syntax
 */

$CONFIG = [


/**
 * Default Parameters
 *
 * These parameters are configured by the Nextcloud installer, and are required
 * for your Nextcloud server to operate.
 */


/**
 * This is a unique identifier for your Nextcloud installation, created
 * automatically by the installer. This example is for documentation only,
 * and you should never use it because it will not work. A valid ``instanceid``
 * is created when you install Nextcloud.
 *
 * 'instanceid' => 'd3c944a9a',
 */
'instanceid' => '',

 /**
  * The salt used to hash all passwords, auto-generated by the Nextcloud
  * installer. (There are also per-user salts.) If you lose this salt you lose
  * all your passwords. This example is for documentation only, and you should
  * never use it.
  *
  * @deprecated This salt is deprecated and only used for legacy-compatibility,
  * developers should *NOT* use this value for anything nowadays.
  *
  * 'passwordsalt' => 'd3c944a9af095aa08f',
 */
'passwordsalt' => '',

/**
 * Your list of trusted domains that users can log into. Specifying trusted
 * domains prevents host header poisoning. Do not remove this, as it performs
 * necessary security checks.
 * You can specify:
 *
 * - the exact hostname of your host or virtual host, e.g. demo.example.org.
 * - the exact hostname with permitted port, e.g. demo.example.org:443.
 *   This disallows all other ports on this host
 * - use * as a wildcard, e.g. ubos-raspberry-pi*.local will allow
 *   ubos-raspberry-pi.local and ubos-raspberry-pi-2.local
 * - the IP address with or without permitted port, e.g. [2001:db8::1]:8080
 *   Using TLS certificates where commonName=<IP address> is deprecated
 */
'trusted_domains' =>
   [
    'demo.example.org',
    'otherdomain.example.org',
    '10.111.112.113',
    '[2001:db8::1]'
  ],


/**
 * Where user files are stored. The SQLite database is also stored here, when
 * you use SQLite.
 *
 * Default to ``data/`` in the Nextcloud directory.
 */
'datadirectory' => '/var/www/nextcloud/data',

/**
 * The current version number of your Nextcloud installation. This is set up
 * during installation and update, so you shouldn't need to change it.
 */
'version' => '',

/**
 * Identifies the database used with this installation. See also config option
 * ``supportedDatabases``
 *
 * Available:
 *  - sqlite3 (SQLite3)
 *  - mysql (MySQL/MariaDB)
 *  - pgsql (PostgreSQL)
 *
 * Defaults to ``sqlite3``
 */
'dbtype' => 'sqlite3',

/**
 * Your host server name, for example ``localhost``, ``hostname``,
 * ``hostname.example.com``, or the IP address. To specify a port use
 * ``hostname:####``; to specify a Unix socket use
 * ``localhost:/path/to/socket``.
 */
'dbhost' => '',

/**
 * The name of the Nextcloud database, which is set during installation. You
 * should not need to change this.
 */
'dbname' => 'nextcloud',

/**
 * The user that Nextcloud uses to write to the database. This must be unique
 * across Nextcloud instances using the same SQL database. This is set up during
 * installation, so you shouldn't need to change it.
 */
'dbuser' => '',

/**
 * The password for the database user. This is set up during installation, so
 * you shouldn't need to change it.
 */
'dbpassword' => '',

/**
 * Prefix for the Nextcloud tables in the database.
 *
 * Default to ``oc_``
 */
'dbtableprefix' => '',


/**
 * Indicates whether the Nextcloud instance was installed successfully; ``true``
 * indicates a successful installation, and ``false`` indicates an unsuccessful
 * installation.
 *
 * Defaults to ``false``
 */
'installed' => false,


/**
 * User Experience
 *
 * These optional parameters control some aspects of the user interface. Default
 * values, where present, are shown.
 */

/**
 * This sets the default language on your Nextcloud server, using ISO_639-1
 * language codes such as ``en`` for English, ``de`` for German, and ``fr`` for
 * French. It overrides automatic language detection on public pages like login
 * or shared items. User's language preferences configured under "personal ->
 * language" override this setting after they have logged in. Nextcloud has two
 * distinguished language codes for German, 'de' and 'de_DE'. 'de' is used for
 * informal German and 'de_DE' for formal German. By setting this value to 'de_DE'
 * you can enforce the formal version of German unless the user has chosen
 * something different explicitly.
 *
 * Defaults to ``en``
 */
'default_language' => 'en',

/**
 * With this setting a language can be forced for all users. If a language is
 * forced, the users are also unable to change their language in the personal
 * settings. If users shall be unable to change their language, but users have
 * different languages, this value can be set to ``true`` instead of a language
 * code.
 *
 * Defaults to ``false``
 */
'force_language' => 'en',

/**
 * This sets the default locale on your Nextcloud server, using ISO_639
 * language codes such as ``en`` for English, ``de`` for German, and ``fr`` for
 * French, and ISO-3166 country codes such as ``GB``, ``US``, ``CA``, as defined
 * in RFC 5646. It overrides automatic locale detection on public pages like
 * login or shared items. User's locale preferences configured under "personal
 * -> locale" override this setting after they have logged in.
 *
 * Defaults to ``en``
 */
'default_locale' => 'en_US',

/**
 * With this setting a locale can be forced for all users. If a locale is
 * forced, the users are also unable to change their locale in the personal
 * settings. If users shall be unable to change their locale, but users have
 * different languages, this value can be set to ``true`` instead of a locale
 * code.
 *
 * Defaults to ``false``
 */
'force_locale' => 'en_US',

/**
 * Set the default app to open on login. Use the app names as they appear in the
 * URL after clicking them in the Apps menu, such as documents, calendar, and
 * gallery. You can use a comma-separated list of app names, so if the first
 * app is not enabled for a user then Nextcloud will try the second one, and so
 * on. If no enabled apps are found it defaults to the dashboard app.
 *
 * Defaults to ``dashboard,files``
 */
'defaultapp' => 'dashboard,files',

/**
 * ``true`` enables the Help menu item in the user menu (top right of the
 * Nextcloud Web interface). ``false`` removes the Help item.
 */
'knowledgebaseenabled' => true,

/**
 * ``true`` allows users to change their display names (on their Personal
 * pages), and ``false`` prevents them from changing their display names.
 */
'allow_user_to_change_display_name' => true,

/**
 * Lifetime of the remember login cookie. This should be larger than the
 * session_lifetime. If it is set to 0 remember me is disabled.
 *
 * Defaults to ``60*60*24*15`` seconds (15 days)
 */
'remember_login_cookie_lifetime' => 60*60*24*15,

/**
 * The lifetime of a session after inactivity.
 *
 * Defaults to ``60*60*24`` seconds (24 hours)
 */
'session_lifetime' => 60 * 60 * 24,

/**
 * Enable or disable session keep-alive when a user is logged in to the Web UI.
 * Enabling this sends a "heartbeat" to the server to keep it from timing out.
 *
 * Defaults to ``true``
 */
'session_keepalive' => true,

/**
 * Enable or disable the automatic logout after session_lifetime, even if session
 * keepalive is enabled. This will make sure that an inactive browser will be logged out
 * even if requests to the server might extend the session lifetime.
 *
 * Defaults to ``false``
 */
'auto_logout' => false,

/**
 * Enforce token authentication for clients, which blocks requests using the user
 * password for enhanced security. Users need to generate tokens in personal settings
 * which can be used as passwords on their clients.
 *
 * Defaults to ``false``
 */
'token_auth_enforced' => false,

/**
 * The interval at which token activity should be updated.
 * Increasing this value means that the last activty on the security page gets
 * more outdated.
 *
 * Tokens are still checked every 5 minutes for validity
 * max value: 300
 *
 * Defaults to ``300``
 */
'token_auth_activity_update' => 60,

/**
 * Whether the bruteforce protection shipped with Nextcloud should be enabled or not.
 *
 * Disabling this is discouraged for security reasons.
 *
 * Defaults to ``true``
 */
'auth.bruteforce.protection.enabled' => true,

/**
 * By default WebAuthn is available but it can be explicitly disabled by admins
 */
'auth.webauthn.enabled' => true,

/**
 * The directory where the skeleton files are located. These files will be
 * copied to the data directory of new users. Leave empty to not copy any
 * skeleton files.
 * ``{lang}`` can be used as a placeholder for the language of the user.
 * If the directory does not exist, it falls back to non dialect (from ``de_DE``
 * to ``de``). If that does not exist either, it falls back to ``default``
 *
 * Defaults to ``core/skeleton`` in the Nextcloud directory.
 */
'skeletondirectory' => '/path/to/nextcloud/core/skeleton',

/**
 * If your user backend does not allow password resets (e.g. when it's a
 * read-only user backend like LDAP), you can specify a custom link, where the
 * user is redirected to, when clicking the "reset password" link after a failed
 * login-attempt.
 * In case you do not want to provide any link, replace the url with 'disabled'
 */
'lost_password_link' => 'https://example.org/link/to/password/reset',

/**
 * Mail Parameters
 *
 * These configure the email settings for Nextcloud notifications and password
 * resets.
 */

/**
 * The return address that you want to appear on emails sent by the Nextcloud
 * server, for example ``nc-admin@example.com``, substituting your own domain,
 * of course.
 */
'mail_domain' => 'example.com',

/**
 * FROM address that overrides the built-in ``sharing-noreply`` and
 * ``lostpassword-noreply`` FROM addresses.
 *
 * Defaults to different from addresses depending on the feature.
 */
'mail_from_address' => 'nextcloud',

/**
 * Enable SMTP class debugging.
 *
 * Defaults to ``false``
 */
'mail_smtpdebug' => false,

/**
 * Which mode to use for sending mail: ``sendmail``, ``smtp`` or ``qmail``.
 *
 * If you are using local or remote SMTP, set this to ``smtp``.
 *
 * For the ``sendmail`` option you need an installed and working email system on
 * the server, with ``/usr/sbin/sendmail`` installed on your Unix system.
 *
 * For ``qmail`` the binary is /var/qmail/bin/sendmail, and it must be installed
 * on your Unix system.
 *
 * Defaults to ``smtp``
 */
'mail_smtpmode' => 'smtp',

/**
 * This depends on ``mail_smtpmode``. Specify the IP address of your mail
 * server host. This may contain multiple hosts separated by a semi-colon. If
 * you need to specify the port number append it to the IP address separated by
 * a colon, like this: ``127.0.0.1:24``.
 *
 * Defaults to ``127.0.0.1``
 */
'mail_smtphost' => '127.0.0.1',

/**
 * This depends on ``mail_smtpmode``. Specify the port for sending mail.
 *
 * Defaults to ``25``
 */
'mail_smtpport' => 25,

/**
 * This depends on ``mail_smtpmode``. This sets the SMTP server timeout, in
 * seconds. You may need to increase this if you are running an anti-malware or
 * spam scanner.
 *
 * Defaults to ``10`` seconds
 */
'mail_smtptimeout' => 10,

/**
 * This depends on ``mail_smtpmode``. Specify when you are using ``ssl`` for SSL/TLS or
 * ``tls`` for STARTTLS, or leave empty for no encryption.
 *
 * Defaults to ``''`` (empty string)
 */
'mail_smtpsecure' => '',

/**
 * This depends on ``mail_smtpmode``. Change this to ``true`` if your mail
 * server requires authentication.
 *
 * Defaults to ``false``
 */
'mail_smtpauth' => false,

/**
 * This depends on ``mail_smtpmode``. If SMTP authentication is required, choose
 * the authentication type as ``LOGIN`` or ``PLAIN``.
 *
 * Defaults to ``LOGIN``
 */
'mail_smtpauthtype' => 'LOGIN',

/**
 * This depends on ``mail_smtpauth``. Specify the username for authenticating to
 * the SMTP server.
 *
 * Defaults to ``''`` (empty string)
 */
'mail_smtpname' => '',

/**
 * This depends on ``mail_smtpauth``. Specify the password for authenticating to
 * the SMTP server.
 *
 * Default to ``''`` (empty string)
 */
'mail_smtppassword' => '',

/**
 * Replaces the default mail template layout. This can be utilized if the
 * options to modify the mail texts with the theming app is not enough.
 * The class must extend  ``\OC\Mail\EMailTemplate``
 */
'mail_template_class' => '\OC\Mail\EMailTemplate',

/**
 * Email will be send by default with an HTML and a plain text body. This option
 * allows to only send plain text emails.
 */
'mail_send_plaintext_only' => false,

/**
 * This depends on ``mail_smtpmode``. Array of additional streams options that
 * will be passed to underlying Swift mailer implementation.
 * Defaults to an empty array.
 */
'mail_smtpstreamoptions' => [],

/**
 * Which mode is used for sendmail/qmail: ``smtp`` or ``pipe``.
 *
 * For ``smtp`` the sendmail binary is started with the parameter ``-bs``:
 *   - Use the SMTP protocol on standard input and output.
 *
 * For ``pipe`` the binary is started with the parameters ``-t``:
 *   - Read message from STDIN and extract recipients.
 *
 * Defaults to ``smtp``
 */
'mail_sendmailmode' => 'smtp',

/**
 * Proxy Configurations
 */

/**
 * The automatic hostname detection of Nextcloud can fail in certain reverse
 * proxy and CLI/cron situations. This option allows you to manually override
 * the automatic detection; for example ``www.example.com``, or specify the port
 * ``www.example.com:8080``.
 */
'overwritehost' => '',

/**
 * When generating URLs, Nextcloud attempts to detect whether the server is
 * accessed via ``https`` or ``http``. However, if Nextcloud is behind a proxy
 * and the proxy handles the ``https`` calls, Nextcloud would not know that
 * ``ssl`` is in use, which would result in incorrect URLs being generated.
 * Valid values are ``http`` and ``https``.
 */
'overwriteprotocol' => '',

/**
 * Nextcloud attempts to detect the webroot for generating URLs automatically.
 * For example, if ``www.example.com/nextcloud`` is the URL pointing to the
 * Nextcloud instance, the webroot is ``/nextcloud``. When proxies are in use,
 * it may be difficult for Nextcloud to detect this parameter, resulting in
 * invalid URLs.
 */
'overwritewebroot' => '',

/**
 * This option allows you to define a manual override condition as a regular
 * expression for the remote IP address. For example, defining a range of IP
 * addresses starting with ``10.0.0.`` and ending with 1 to 3:
 * ``^10\.0\.0\.[1-3]$``
 *
 * Defaults to ``''`` (empty string)
 */
'overwritecondaddr' => '',

/**
 * Use this configuration parameter to specify the base URL for any URLs which
 * are generated within Nextcloud using any kind of command line tools (cron or
 * occ). The value should contain the full base URL:
 * ``https://www.example.com/nextcloud``
 *
 * Defaults to ``''`` (empty string)
 */
'overwrite.cli.url' => '',

/**
 * To have clean URLs without `/index.php` this parameter needs to be configured.
 *
 * This parameter will be written as "RewriteBase" on update and installation of
 * Nextcloud to your `.htaccess` file. While this value is often simply the URL
 * path of the Nextcloud installation it cannot be set automatically properly in
 * every scenario and needs thus some manual configuration.
 *
 * In a standard Apache setup this usually equals the folder that Nextcloud is
 * accessible at. So if Nextcloud is accessible via "https://mycloud.org/nextcloud"
 * the correct value would most likely be "/nextcloud". If Nextcloud is running
 * under "https://mycloud.org/" then it would be "/".
 *
 * Note that the above rule is not valid in every case, as there are some rare setup
 * cases where this may not apply. However, to avoid any update problems this
 * configuration value is explicitly opt-in.
 *
 * After setting this value run `occ maintenance:update:htaccess`. Now, when the
 * following conditions are met Nextcloud URLs won't contain `index.php`:
 *
 * - `mod_rewrite` is installed
 * - `mod_env` is installed
 *
 * Defaults to ``''`` (empty string)
 */
'htaccess.RewriteBase' => '/',

/**
 * For server setups, that don't have `mod_env` enabled or restricted (e.g. suEXEC)
 * this parameter has to be set to true and will assume mod_rewrite.
 *
 * Please check, if `mod_rewrite` is active and functional before setting this
 * parameter and you updated your .htaccess with `occ maintenance:update:htaccess`.
 * Otherwise your nextcloud installation might not be reachable anymore.
 * For example, try accessing resources by leaving out `index.php` in the URL.
 */
'htaccess.IgnoreFrontController' => false,

/**
 * The URL of your proxy server, for example ``proxy.example.com:8081``.
 *
 * Note: Guzzle (the http library used by Nextcloud) is reading the environment
 * variables HTTP_PROXY (only for cli request), HTTPS_PROXY, and NO_PROXY by default.
 *
 * If you configure proxy with Nextcloud any default configuration by Guzzle
 * is overwritten. Make sure to set ``proxyexclude`` accordingly if necessary.
 *
 * Defaults to ``''`` (empty string)
 */
'proxy' => '',

/**
 * The optional authentication for the proxy to use to connect to the internet.
 * The format is: ``username:password``.
 *
 * Defaults to ``''`` (empty string)
 */
'proxyuserpwd' => '',

/**
 * List of host names that should not be proxied to.
 * For example: ``['.mit.edu', 'foo.com']``.
 *
 * Hint: Use something like ``explode(',', getenv('NO_PROXY'))`` to sync this
 * value with the global NO_PROXY option.
 *
 * Defaults to empty array.
 */
'proxyexclude' => [],

/**
 * Allow remote servers with local addresses e.g. in federated shares, webcal services and more
 *
 * Defaults to false
 */
'allow_local_remote_servers' => true,

/**
 * Deleted Items (trash bin)
 *
 * These parameters control the Deleted files app.
 */

/**
 * If the trash bin app is enabled (default), this setting defines the policy
 * for when files and folders in the trash bin will be permanently deleted.
 * The app allows for two settings, a minimum time for trash bin retention,
 * and a maximum time for trash bin retention.
 * Minimum time is the number of days a file will be kept, after which it
 * may be deleted. Maximum time is the number of days at which it is guaranteed
 * to be deleted.
 * Both minimum and maximum times can be set together to explicitly define
 * file and folder deletion. For migration purposes, this setting is installed
 * initially set to "auto", which is equivalent to the default setting in
 * Nextcloud.
 *
 * Available values:
 *
 * * ``auto``
 *     default setting. keeps files and folders in the trash bin for 30 days
 *     and automatically deletes anytime after that if space is needed (note:
 *     files may not be deleted if space is not needed).
 * * ``D, auto``
 *     keeps files and folders in the trash bin for D+ days, delete anytime if
 *     space needed (note: files may not be deleted if space is not needed)
 * * ``auto, D``
 *     delete all files in the trash bin that are older than D days
 *     automatically, delete other files anytime if space needed
 * * ``D1, D2``
 *     keep files and folders in the trash bin for at least D1 days and
 *     delete when exceeds D2 days (note: files will not be deleted automatically if space is needed)
 * * ``disabled``
 *     trash bin auto clean disabled, files and folders will be kept forever
 *
 * Defaults to ``auto``
 */
'trashbin_retention_obligation' => 'auto',


/**
 * File versions
 *
 * These parameters control the Versions app.
 */

/**
 * If the versions app is enabled (default), this setting defines the policy
 * for when versions will be permanently deleted.
 * The app allows for two settings, a minimum time for version retention,
 * and a maximum time for version retention.
 * Minimum time is the number of days a version will be kept, after which it
 * may be deleted. Maximum time is the number of days at which it is guaranteed
 * to be deleted.
 * Both minimum and maximum times can be set together to explicitly define
 * version deletion. For migration purposes, this setting is installed
 * initially set to "auto", which is equivalent to the default setting in
 * Nextcloud.
 *
 * Available values:
 *
 * * ``auto``
 *     default setting. Automatically expire versions according to expire
 *     rules. Please refer to :doc:`../configuration_files/file_versioning` for
 *     more information.
 * * ``D, auto``
 *     keep versions at least for D days, apply expire rules to all versions
 *     that are older than D days
 * * ``auto, D``
 *     delete all versions that are older than D days automatically, delete
 *     other versions according to expire rules
 * * ``D1, D2``
 *     keep versions for at least D1 days and delete when exceeds D2 days
 * * ``disabled``
 *     versions auto clean disabled, versions will be kept forever
 *
 * Defaults to ``auto``
 */
'versions_retention_obligation' => 'auto',

/**
 * Nextcloud Verifications
 *
 * Nextcloud performs several verification checks. There are two options,
 * ``true`` and ``false``.
 */

/**
 * Checks an app before install whether it uses private APIs instead of the
 * proper public APIs. If this is set to true it will only allow to install or
 * enable apps that pass this check.
 *
 * Defaults to ``false``
 */
'appcodechecker' => true,

/**
 * Check if Nextcloud is up-to-date and shows a notification if a new version is
 * available.
 *
 * Defaults to ``true``
 */
'updatechecker' => true,

/**
 * URL that Nextcloud should use to look for updates
 *
 * Defaults to ``https://updates.nextcloud.com/updater_server/``
 */
'updater.server.url' => 'https://updates.nextcloud.com/updater_server/',

/**
 * The channel that Nextcloud should use to look for updates
 *
 * Supported values:
 *   - ``daily``
 *   - ``beta``
 *   - ``stable``
 */
'updater.release.channel' => 'stable',

/**
 * Is Nextcloud connected to the Internet or running in a closed network?
 *
 * Defaults to ``true``
 */
'has_internet_connection' => true,

/**
 * Which domains to request to determine the availability of an Internet
 * connection. If none of these hosts are reachable, the administration panel
 * will show a warning. Set to an empty list to not do any such checks (warning
 * will still be shown).
 *
 * Defaults to the following domains:
 *
 *  - www.nextcloud.com
 *  - www.startpage.com
 *  - www.eff.org
 *  - www.edri.org
 */
'connectivity_check_domains' => [
    'www.nextcloud.com',
    'www.startpage.com',
    'www.eff.org',
    'www.edri.org'
],

/**
 * Allows Nextcloud to verify a working .well-known URL redirects. This is done
 * by attempting to make a request from JS to
 * https://your-domain.com/.well-known/caldav/
 *
 * Defaults to ``true``
 */
'check_for_working_wellknown_setup' => true,

/**
 * This is a crucial security check on Apache servers that should always be set
 * to ``true``. This verifies that the ``.htaccess`` file is writable and works.
 * If it is not, then any options controlled by ``.htaccess``, such as large
 * file uploads, will not work. It also runs checks on the ``data/`` directory,
 * which verifies that it can't be accessed directly through the Web server.
 *
 * Defaults to ``true``
 */
'check_for_working_htaccess' => true,

/**
 * In rare setups (e.g. on Openshift or docker on windows) the permissions check
 * might block the installation while the underlying system offers no means to
 * "correct" the permissions. In this case, set the value to false.
 *
 * In regular cases, if issues with permissions are encountered they should be
 * adjusted accordingly. Changing the flag is discouraged.
 *
 * Defaults to ``true``
 */
'check_data_directory_permissions' => true,

/**
 * In certain environments it is desired to have a read-only configuration file.
 * When this switch is set to ``true`` Nextcloud will not verify whether the
 * configuration is writable. However, it will not be possible to configure
 * all options via the Web interface. Furthermore, when updating Nextcloud
 * it is required to make the configuration file writable again for the update
 * process.
 *
 * Defaults to ``false``
 */
'config_is_read_only' => false,

/**
 * Logging
 */

/**
 * This parameter determines where the Nextcloud logs are sent.
 * ``file``: the logs are written to file ``nextcloud.log`` in the default
 * Nextcloud data directory. The log file can be changed with parameter
 * ``logfile``.
 * ``syslog``: the logs are sent to the system log. This requires a syslog daemon
 * to be active.
 * ``errorlog``: the logs are sent to the PHP ``error_log`` function.
 * ``systemd``: the logs are sent to the Systemd journal. This requires a system
 * that runs Systemd and the Systemd journal. The PHP extension ``systemd``
 * must be installed and active.
 *
 * Defaults to ``file``
 */
'log_type' => 'file',

/**
 * Name of the file to which the Nextcloud logs are written if parameter
 * ``log_type`` is set to ``file``.
 *
 * Defaults to ``[datadirectory]/nextcloud.log``
 */
'logfile' => '/var/log/nextcloud.log',

/**
 * Log file mode for the Nextcloud loggin type in octal notation.
 *
 * Defaults to 0640 (writeable by user, readable by group).
 */
'logfilemode' => 0640,

/**
 * Loglevel to start logging at. Valid values are: 0 = Debug, 1 = Info, 2 =
 * Warning, 3 = Error, and 4 = Fatal. The default value is Warning.
 *
 * Defaults to ``2``
 */
'loglevel' => 2,

/**
 * If you maintain different instances and aggregate the logs, you may want
 * to distinguish between them. ``syslog_tag`` can be set per instance
 * with a unique id. Only available if ``log_type`` is set to ``syslog`` or
 * ``systemd``.
 *
 * The default value is ``Nextcloud``.
 */
'syslog_tag' => 'Nextcloud',

/**
 * Log condition for log level increase based on conditions. Once one of these
 * conditions is met, the required log level is set to debug. This allows to
 * debug specific requests, users or apps
 *
 * Supported conditions:
 *  - ``shared_secret``: if a request parameter with the name `log_secret` is set to
 *                this value the condition is met
 *  - ``users``:  if the current request is done by one of the specified users,
 *                this condition is met
 *  - ``apps``:   if the log message is invoked by one of the specified apps,
 *                this condition is met
 *
 * Defaults to an empty array.
 */
'log.condition' => [
    'shared_secret' => '57b58edb6637fe3059b3595cf9c41b9',
    'users' => ['sample-user'],
    'apps' => ['files'],
],

/**
 * This uses PHP.date formatting; see http://php.net/manual/en/function.date.php
 *
 * Defaults to ISO 8601 ``2005-08-15T15:52:01+00:00`` - see \DateTime::ATOM
 * (https://secure.php.net/manual/en/class.datetime.php#datetime.constants.atom)
 */
'logdateformat' => 'F d, Y H:i:s',

/**
 * The timezone for logfiles. You may change this; see
 * http://php.net/manual/en/timezones.php
 *
 * Defaults to ``UTC``
 */
'logtimezone' => 'Europe/Berlin',

/**
 * Append all database queries and parameters to the log file. Use this only for
 * debugging, as your logfile will become huge.
 */
'log_query' => false,

/**
 * Enables log rotation and limits the total size of logfiles. Set it to 0 for
 * no rotation. Specify a size in bytes, for example 104857600 (100 megabytes
 * = 100 * 1024 * 1024 bytes). A new logfile is created with a new name when the
 * old logfile reaches your limit. If a rotated log file is already present, it
 * will be overwritten.
 *
 * Defaults to 100 MB
 */
'log_rotate_size' => 100 * 1024 * 1024,


/**
 * Alternate Code Locations
 *
 * Some of the Nextcloud code may be stored in alternate locations.
 */

/**
 * This section is for configuring the download links for Nextcloud clients, as
 * seen in the first-run wizard and on Personal pages.
 *
 * Defaults to:
 *  - Desktop client: ``https://nextcloud.com/install/#install-clients``
 *  - Android client: ``https://play.google.com/store/apps/details?id=com.nextcloud.client``
 *  - iOS client: ``https://itunes.apple.com/us/app/nextcloud/id1125420102?mt=8``
 *  - iOS client app id: ``1125420102``
 */
'customclient_desktop' =>
    'https://nextcloud.com/install/#install-clients',
'customclient_android' =>
    'https://play.google.com/store/apps/details?id=com.nextcloud.client',
'customclient_ios' =>
    'https://itunes.apple.com/us/app/nextcloud/id1125420102?mt=8',
'customclient_ios_appid' =>
        '1125420102',
/**
 * Apps
 *
 * Options for the Apps folder, Apps store, and App code checker.
 */

/**
 * When enabled, admins may install apps from the Nextcloud app store.
 *
 * Defaults to ``true``
 */
'appstoreenabled' => true,

/**
 * Enables the installation of apps from a self hosted apps store.
 * Requires that at least one of the configured apps directories is writeable.
 *
 * Defaults to ``https://apps.nextcloud.com/api/v1``
 */
'appstoreurl' => 'https://apps.nextcloud.com/api/v1',

/**
 * Use the ``apps_paths`` parameter to set the location of the Apps directory,
 * which should be scanned for available apps, and where user-specific apps
 * should be installed from the Apps store. The ``path`` defines the absolute
 * file system path to the app folder. The key ``url`` defines the HTTP Web path
 * to that folder, starting from the Nextcloud webroot. The key ``writable``
 * indicates if a Web server can write files to that folder.
 */
'apps_paths' => [
    [
        'path'=> '/var/www/nextcloud/apps',
        'url' => '/apps',
        'writable' => true,
    ],
],

/**
 * @see appcodechecker
 */

/**
 * Previews
 *
 * Nextcloud supports previews of image files, the covers of MP3 files, and text
 * files. These options control enabling and disabling previews, and thumbnail
 * size.
 */

/**
 * By default, Nextcloud can generate previews for the following filetypes:
 *
 * - Image files
 * - Covers of MP3 files
 * - Text documents
 *
 * Valid values are ``true``, to enable previews, or
 * ``false``, to disable previews
 *
 * Defaults to ``true``
 */
'enable_previews' => true,
/**
 * The maximum width, in pixels, of a preview. A value of ``null`` means there
 * is no limit.
 *
 * Defaults to ``4096``
 */
'preview_max_x' => 4096,
/**
 * The maximum height, in pixels, of a preview. A value of ``null`` means there
 * is no limit.
 *
 * Defaults to ``4096``
 */
'preview_max_y' => 4096,

/**
 * max file size for generating image previews with imagegd (default behavior)
 * If the image is bigger, it'll try other preview generators, but will most
 * likely show the default mimetype icon. Set to -1 for no limit.
 *
 * Defaults to ``50`` megabytes
 */
'preview_max_filesize_image' => 50,

/**
 * custom path for LibreOffice/OpenOffice binary
 *
 *
 * Defaults to ``''`` (empty string)
 */
'preview_libreoffice_path' => '/usr/bin/libreoffice',
/**
 * Use this if LibreOffice/OpenOffice requires additional arguments.
 *
 * Defaults to ``''`` (empty string)
 */
'preview_office_cl_parameters' =>
    ' --headless --nologo --nofirststartwizard --invisible --norestore '.
    '--convert-to png --outdir ',

/**
 * Only register providers that have been explicitly enabled
 *
 * The following providers are disabled by default due to performance or privacy
 * concerns:
 *
 *  - OC\Preview\Illustrator
 *  - OC\Preview\HEIC
 *  - OC\Preview\Movie
 *  - OC\Preview\MSOffice2003
 *  - OC\Preview\MSOffice2007
 *  - OC\Preview\MSOfficeDoc
 *  - OC\Preview\PDF
 *  - OC\Preview\Photoshop
 *  - OC\Preview\Postscript
 *  - OC\Preview\StarOffice
 *  - OC\Preview\SVG
 *  - OC\Preview\TIFF
 *  - OC\Preview\Font
 *
 *
 * Defaults to the following providers:
 *
 *  - OC\Preview\BMP
 *  - OC\Preview\GIF
 *  - OC\Preview\JPEG
 *  - OC\Preview\MarkDown
 *  - OC\Preview\MP3
 *  - OC\Preview\PNG
 *  - OC\Preview\TXT
 *  - OC\Preview\XBitmap
 *  - OC\Preview\OpenDocument
 *  - OC\Preview\Krita
 */
'enabledPreviewProviders' => [
    'OC\Preview\PNG',
    'OC\Preview\JPEG',
    'OC\Preview\GIF',
    'OC\Preview\BMP',
    'OC\Preview\XBitmap',
    'OC\Preview\MP3',
    'OC\Preview\TXT',
    'OC\Preview\MarkDown',
    'OC\Preview\OpenDocument',
    'OC\Preview\Krita',
],

/**
 * LDAP
 *
 * Global settings used by LDAP User and Group Backend
 */

/**
 * defines the interval in minutes for the background job that checks user
 * existence and marks them as ready to be cleaned up. The number is always
 * minutes. Setting it to 0 disables the feature.
 * See command line (occ) methods ``ldap:show-remnants`` and ``user:delete``
 *
 * Defaults to ``51`` minutes
 */
'ldapUserCleanupInterval' => 51,

/**
 * Sort groups in the user settings by name instead of the user count
 *
 * By enabling this the user count beside the group name is disabled as well.
 */
'sort_groups_by_name' => false,

/**
 * Comments
 *
 * Global settings for the Comments infrastructure
 */

/**
 * Replaces the default Comments Manager Factory. This can be utilized if an
 * own or 3rdParty CommentsManager should be used that – for instance – uses the
 * filesystem instead of the database to keep the comments.
 *
 * Defaults to ``\OC\Comments\ManagerFactory``
 */
'comments.managerFactory' => '\OC\Comments\ManagerFactory',

/**
 * Replaces the default System Tags Manager Factory. This can be utilized if an
 * own or 3rdParty SystemTagsManager should be used that – for instance – uses the
 * filesystem instead of the database to keep the tags.
 *
 * Defaults to ``\OC\SystemTag\ManagerFactory``
 */
'systemtags.managerFactory' => '\OC\SystemTag\ManagerFactory',

/**
 * Maintenance
 *
 * These options are for halting user activity when you are performing server
 * maintenance.
 */

/**
 * Enable maintenance mode to disable Nextcloud
 *
 * If you want to prevent users from logging in to Nextcloud before you start
 * doing some maintenance work, you need to set the value of the maintenance
 * parameter to true. Please keep in mind that users who are already logged-in
 * are kicked out of Nextcloud instantly.
 *
 * Defaults to ``false``
 */
'maintenance' => false,


/**
 * SSL
 */

/**
 * Extra SSL options to be used for configuration.
  *
 * Defaults to an empty array.
 */
'openssl' => [
    'config' => '/absolute/location/of/openssl.cnf',
],

/**
 * Memory caching backend configuration
 *
 * Available cache backends:
 *
 * * ``\OC\Memcache\APCu``       APC user backend
 * * ``\OC\Memcache\ArrayCache`` In-memory array-based backend (not recommended)
 * * ``\OC\Memcache\Memcached``  Memcached backend
 * * ``\OC\Memcache\Redis``      Redis backend
 *
 * Advice on choosing between the various backends:
 *
 * * APCu should be easiest to install. Almost all distributions have packages.
 *   Use this for single user environment for all caches.
 * * Use Redis or Memcached for distributed environments.
 *   For the local cache (you can configure two) take APCu.
 */

/**
 * Memory caching backend for locally stored data
 *
 * * Used for host-specific data, e.g. file paths
 *
 * Defaults to ``none``
 */
'memcache.local' => '\OC\Memcache\APCu',

/**
 * Memory caching backend for distributed data
 *
 * * Used for installation-specific data, e.g. database caching
 * * If unset, defaults to the value of memcache.local
 *
 * Defaults to ``none``
 */
'memcache.distributed' => '\OC\Memcache\Memcached',

/**
 * Connection details for redis to use for memory caching in a single server configuration.
 *
 * For enhanced security it is recommended to configure Redis
 * to require a password. See http://redis.io/topics/security
 * for more information.
 */
'redis' => [
    'host' => 'localhost', // can also be a unix domain socket: '/tmp/redis.sock'
    'port' => 6379,
    'timeout' => 0.0,
    'password' => '', // Optional, if not defined no password will be used.
    'dbindex' => 0, // Optional, if undefined SELECT will not run and will use Redis Server's default DB Index.
],

/**
 * Connection details for a Redis Cluster
 *
 * Only for use with Redis Clustering, for Sentinel-based setups use the single
 * server configuration above, and perform HA on the hostname.
 *
 * Redis Cluster support requires the php module phpredis in version 3.0.0 or
 * higher.
 *
 * Available failover modes:
 *  - \RedisCluster::FAILOVER_NONE - only send commands to master nodes (default)
 *  - \RedisCluster::FAILOVER_ERROR - failover to slaves for read commands if master is unavailable (recommended)
 *  - \RedisCluster::FAILOVER_DISTRIBUTE - randomly distribute read commands across master and slaves
 *
 * WARNING: FAILOVER_DISTRIBUTE is a not recommended setting and we strongly
 * suggest to not use it if you use Redis for file locking. Due to the way Redis
 * is synchronized it could happen, that the read for an existing lock is
 * scheduled to a slave that is not fully synchronized with the connected master
 * which then causes a FileLocked exception.
 *
 * See https://redis.io/topics/cluster-spec for details about the Redis cluster
 *
 * Authentication works with phpredis version 4.2.1+. See
 * https://github.com/phpredis/phpredis/commit/c5994f2a42b8a348af92d3acb4edff1328ad8ce1
 */
'redis.cluster' => [
    'seeds' => [ // provide some/all of the cluster servers to bootstrap discovery, port required
        'localhost:7000',
        'localhost:7001',
    ],
    'timeout' => 0.0,
    'read_timeout' => 0.0,
    'failover_mode' => \RedisCluster::FAILOVER_ERROR,
    'password' => '', // Optional, if not defined no password will be used.
],


/**
 * Server details for one or more memcached servers to use for memory caching.
 */
'memcached_servers' => [
    // hostname, port and optional weight. Also see:
    // http://www.php.net/manual/en/memcached.addservers.php
    // http://www.php.net/manual/en/memcached.addserver.php
    ['localhost', 11211],
    //array('other.host.local', 11211),
],

/**
 * Connection options for memcached
 */
'memcached_options' => [
    // Set timeouts to 50ms
    \Memcached::OPT_CONNECT_TIMEOUT => 50,
    \Memcached::OPT_RETRY_TIMEOUT =>   50,
    \Memcached::OPT_SEND_TIMEOUT =>    50,
    \Memcached::OPT_RECV_TIMEOUT =>    50,
    \Memcached::OPT_POLL_TIMEOUT =>    50,

    // Enable compression
    \Memcached::OPT_COMPRESSION =>          true,

    // Turn on consistent hashing
    \Memcached::OPT_LIBKETAMA_COMPATIBLE => true,

    // Enable Binary Protocol
    \Memcached::OPT_BINARY_PROTOCOL =>      true,

    // Binary serializer vill be enabled if the igbinary PECL module is available
    //\Memcached::OPT_SERIALIZER => \Memcached::SERIALIZER_IGBINARY,
],


/**
 * Location of the cache folder, defaults to ``data/$user/cache`` where
 * ``$user`` is the current user. When specified, the format will change to
 * ``$cache_path/$user`` where ``$cache_path`` is the configured cache directory
 * and ``$user`` is the user.
 *
 * Defaults to ``''`` (empty string)
 */
'cache_path' => '',

/**
 * TTL of chunks located in the cache folder before they're removed by
 * garbage collection (in seconds). Increase this value if users have
 * issues uploading very large files via the Nextcloud Client as upload isn't
 * completed within one day.
 *
 * Defaults to ``60*60*24`` (1 day)
 */
'cache_chunk_gc_ttl' => 60*60*24,

/**
 * Using Object Store with Nextcloud
 */

/**
 * This example shows how to configure Nextcloud to store all files in a
 * swift object storage.
 *
 * It is important to note that Nextcloud in object store mode will expect
 * exclusive access to the object store container because it only stores the
 * binary data for each file. The metadata is currently kept in the local
 * database for performance reasons.
 *
 * WARNING: The current implementation is incompatible with any app that uses
 * direct file IO and circumvents our virtual filesystem. That includes
 * Encryption and Gallery. Gallery will store thumbnails directly in the
 * filesystem and encryption will cause severe overhead because key files need
 * to be fetched in addition to any requested file.
 *
 * One way to test is applying for a trystack account at http://trystack.org/
 */
'objectstore' => [
    'class' => 'OC\\Files\\ObjectStore\\Swift',
    'arguments' => [
        // trystack will use your facebook id as the user name
        'username' => 'facebook100000123456789',
        // in the trystack dashboard go to user -> settings -> API Password to
        // generate a password
        'password' => 'Secr3tPaSSWoRdt7',
        // must already exist in the objectstore, name can be different
        'container' => 'nextcloud',
        // prefix to prepend to the fileid, default is 'oid:urn:'
        'objectPrefix' => 'oid:urn:',
        // create the container if it does not exist. default is false
        'autocreate' => true,
        // required, dev-/trystack defaults to 'RegionOne'
        'region' => 'RegionOne',
        // The Identity / Keystone endpoint
        'url' => 'http://8.21.28.222:5000/v2.0',
        // required on dev-/trystack
        'tenantName' => 'facebook100000123456789',
        // dev-/trystack uses swift by default, the lib defaults to 'cloudFiles'
        // if omitted
        'serviceName' => 'swift',
        // The Interface / url Type, optional
        'urlType' => 'internal'
    ],
],

/**
 * To use swift V3
 */
'objectstore' => [
    'class' => 'OC\\Files\\ObjectStore\\Swift',
    'arguments' => [
        'autocreate' => true,
        'user' => [
            'name' => 'swift',
            'password' => 'swift',
            'domain' => [
                'name' => 'default',
            ],
        ],
        'scope' => [
            'project' => [
                'name' => 'service',
                'domain' => [
                    'name' => 'default',
                ],
            ],
        ],
        'tenantName' => 'service',
        'serviceName' => 'swift',
        'region' => 'regionOne',
        'url' => 'http://yourswifthost:5000/v3',
        'bucket' => 'nextcloud',
    ],
],

/**
 * If this is set to true and a multibucket object store is configured then
 * newly created previews are put into 256 dedicated buckets.
 *
 * Those buckets are named like the mulibucket version but with the postfix
 * ``-preview-NUMBER`` where NUMBER is between 0 and 255.
 *
 * Keep in mind that only previews of files are put in there that don't have
 * some already. Otherwise the old bucket will be used.
 *
 * To migrate existing previews to this new multibucket distribution of previews
 * use the occ command ``preview:repair``. For now this will only migrate
 * previews that were generated before Nextcloud 19 in the flat
 * ``appdata_INSTANCEID/previews/FILEID`` folder structure.
 */
'objectstore.multibucket.preview-distribution' => false,


/**
 * Sharing
 *
 * Global settings for Sharing
 */

/**
 * Replaces the default Share Provider Factory. This can be utilized if
 * own or 3rdParty Share Providers are used that – for instance – use the
 * filesystem instead of the database to keep the share information.
 *
 * Defaults to ``\OC\Share20\ProviderFactory``
 */
'sharing.managerFactory' => '\OC\Share20\ProviderFactory',

/**
 * Define max number of results returned by the user search for auto-completion
 * Default is unlimited (value set to 0).
 */
'sharing.maxAutocompleteResults' => 0,

/**
 * Define the minimum length of the search string before we start auto-completion
 * Default is no limit (value set to 0)
 */
'sharing.minSearchStringLength' => 0,

/**
 * Set to true to enable that internal shares need to be accepted by the users by default.
 * Users can change this for their account in their personal sharing settings
 */
'sharing.enable_share_accept' => false,

/**
 * Set to true to enforce that internal shares need to be accepted
 */
'sharing.force_share_accept' => false,

/**
 * Set to false to stop sending a mail when users receive a share
 */
'sharing.enable_share_mail' => true,


/**
 * All other configuration options
 */

/**
 * Additional driver options for the database connection, eg. to enable SSL
 * encryption in MySQL or specify a custom wait timeout on a cheap hoster.
 */
'dbdriveroptions' => [
    PDO::MYSQL_ATTR_SSL_CA => '/file/path/to/ca_cert.pem',
    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET wait_timeout = 28800'
],

/**
 * sqlite3 journal mode can be specified using this configuration parameter -
 * can be 'WAL' or 'DELETE' see for more details https://www.sqlite.org/wal.html
 */
'sqlite.journal_mode' => 'DELETE',

/**
 * During setup, if requirements are met (see below), this setting is set to true
 * and MySQL can handle 4 byte characters instead of 3 byte characters.
 *
 * If you want to convert an existing 3-byte setup into a 4-byte setup please
 * set the parameters in MySQL as mentioned below and run the migration command:
 * ./occ db:convert-mysql-charset
 * The config setting will be set automatically after a successful run.
 *
 * Consult the documentation for more details.
 *
 * MySQL requires a special setup for longer indexes (> 767 bytes) which are
 * needed:
 *
 * [mysqld]
 * innodb_large_prefix=ON
 * innodb_file_format=Barracuda
 * innodb_file_per_table=ON
 *
 * Tables will be created with
 *  * character set: utf8mb4
 *  * collation:     utf8mb4_bin
 *  * row_format:    compressed
 *
 * See:
 * https://dev.mysql.com/doc/refman/5.7/en/charset-unicode-utf8mb4.html
 * https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_large_prefix
 * https://mariadb.com/kb/en/mariadb/xtradbinnodb-server-system-variables/#innodb_large_prefix
 * http://www.tocker.ca/2013/10/31/benchmarking-innodb-page-compression-performance.html
 * http://mechanics.flite.com/blog/2014/07/29/using-innodb-large-prefix-to-avoid-error-1071/
 */
'mysql.utf8mb4' => false,

/**
 * Database types that are supported for installation.
 *
 * Available:
 *  - sqlite (SQLite3)
 *  - mysql (MySQL)
 *  - pgsql (PostgreSQL)
 *  - oci (Oracle)
 *
 * Defaults to the following databases:
 *  - sqlite (SQLite3)
 *  - mysql (MySQL)
 *  - pgsql (PostgreSQL)
 */
'supportedDatabases' => [
    'sqlite',
    'mysql',
    'pgsql',
    'oci',
],

/**
 * Override where Nextcloud stores temporary files. Useful in situations where
 * the system temporary directory is on a limited space ramdisk or is otherwise
 * restricted, or if external storages which do not support streaming are in
 * use.
 *
 * The Web server user must have write access to this directory.
 */
'tempdirectory' => '/tmp/nextcloudtemp',

/**
 * Hashing
 */

/**
 * By default Nextcloud will use the Argon2 password hashing if available.
 * However if for whatever reason you want to stick with the PASSWORD_DEFAULT
 * of your php version. Then set the setting to true.
 */
'hashing_default_password' => false,

/**
 *
 * Nextcloud uses the Argon2 algorithm (with PHP >= 7.2) to create hashes by its
 * own and exposes its configuration options as following. More information can
 * be found at: https://www.php.net/manual/en/function.password-hash.php
 */

/**
 * The number of CPU threads to be used by the algorithm for computing a hash.
 * The value must be an integer, and the minimum value is 1. Rationally it does
 * not help to provide a number higher than the available threads on the machine.
 * Values that undershoot the minimum will be ignored in favor of the minimum.
 */
'hashingThreads' => PASSWORD_ARGON2_DEFAULT_THREADS,

/**
 * The memory in KiB to be used by the algorithm for computing a hash. The value
 * must be an integer, and the minimum value is 8 times the number of CPU threads.
 * Values that undershoot the minimum will be ignored in favor of the minimum.
 */
'hashingMemoryCost' => PASSWORD_ARGON2_DEFAULT_MEMORY_COST,

/**
 * The number of iterations that are used by the algorithm for computing a hash.
 * The value must be an integer, and the minimum value is 1. Values that
 * undershoot the minimum will be ignored in favor of the minimum.
 */
'hashingTimeCost' => PASSWORD_ARGON2_DEFAULT_TIME_COST,

/**
 * The hashing cost used by hashes generated by Nextcloud
 * Using a higher value requires more time and CPU power to calculate the hashes
 */
'hashingCost' => 10,

/**
 * Blacklist a specific file or files and disallow the upload of files
 * with this name. ``.htaccess`` is blocked by default.
 * WARNING: USE THIS ONLY IF YOU KNOW WHAT YOU ARE DOING.
 *
 * Defaults to ``array('.htaccess')``
 */
'blacklisted_files' => ['.htaccess'],

/**
 * Define a default folder for shared files and folders other than root.
 * Changes to this value will only have effect on new shares.
 *
 * Defaults to ``/``
 */
'share_folder' => '/',

/**
 * If you are applying a theme to Nextcloud, enter the name of the theme here.
 * The default location for themes is ``nextcloud/themes/``.
 *
 * Defaults to the theming app which is shipped since Nextcloud 9
 */
'theme' => '',

/**
 * The default cipher for encrypting files. Currently supported are:
 *  - AES-256-CTR
 *  - AES-128-CTR
 *  - AES-256-CFB
 *  - AES-128-CFB
 *
 * Defaults to ``AES-256-CTR``
 */
'cipher' => 'AES-256-CTR',

/**
 * The minimum Nextcloud desktop client version that will be allowed to sync with
 * this server instance. All connections made from earlier clients will be denied
 * by the server. Defaults to the minimum officially supported Nextcloud desktop
 * clientversion at the time of release of this server version.
 *
 * When changing this, note that older unsupported versions of the Nextcloud desktop
 * client may not function as expected, and could lead to permanent data loss for
 * clients or other unexpected results.
 *
 * Defaults to ``2.0.0``
 */
'minimum.supported.desktop.version' => '2.0.0',

/**
 * EXPERIMENTAL: option whether to include external storage in quota
 * calculation, defaults to false.
 *
 * Defaults to ``false``
 */
'quota_include_external_storage' => false,

/**
 * When an external storage is unavailable for some reasons, it will be flagged
 * as such for 10 minutes. When the trigger is a failed authentication attempt
 * the delay is higher and can be controlled with this option. The motivation
 * is to make account lock outs at Active Directories (and compatible) more
 * unlikely.
 *
 * Defaults to ``1800`` (seconds)
 */
'external_storage.auth_availability_delay' => 1800,

/**
 * Specifies how often the local filesystem (the Nextcloud data/ directory, and
 * NFS mounts in data/) is checked for changes made outside Nextcloud. This
 * does not apply to external storages.
 *
 * 0 -> Never check the filesystem for outside changes, provides a performance
 * increase when it's certain that no changes are made directly to the
 * filesystem
 *
 * 1 -> Check each file or folder at most once per request, recommended for
 * general use if outside changes might happen.
 *
 * Defaults to ``0``
 */
'filesystem_check_changes' => 0,

/**
 * By default Nextcloud will store the part files created during upload in the
 * same storage as the upload target. Setting this to false will store the part
 * files in the root of the users folder which might be required to work with certain
 * external storage setups that have limited rename capabilities.
 *
 * Defaults to ``true``
 */
'part_file_in_storage' => true,

/**
 * Where ``mount.json`` file should be stored, defaults to ``data/mount.json``
 * in the Nextcloud directory.
 *
 * Defaults to ``data/mount.json`` in the Nextcloud directory.
 */
'mount_file' => '/var/www/nextcloud/data/mount.json',

/**
 * When ``true``, prevent Nextcloud from changing the cache due to changes in
 * the filesystem for all storage.
 *
 * Defaults to ``false``
 */
'filesystem_cache_readonly' => false,

/**
 * Secret used by Nextcloud for various purposes, e.g. to encrypt data. If you
 * lose this string there will be data corruption.
 */
'secret' => '',

/**
 * List of trusted proxy servers
 *
 * You may set this to an array containing a combination of
 * - IPv4 addresses, e.g. `192.168.2.123`
 * - IPv4 ranges in CIDR notation, e.g. `192.168.2.0/24`
 * - IPv6 addresses, e.g. `fd9e:21a7:a92c:2323::1`
 *
 * _(CIDR notation for IPv6 is currently work in progress and thus not
 * available as of yet)_
 *
 * When an incoming request's `REMOTE_ADDR` matches any of the IP addresses
 * specified here, it is assumed to be a proxy instead of a client. Thus, the
 * client IP will be read from the HTTP header specified in
 * `forwarded_for_headers` instead of from `REMOTE_ADDR`.
 *
 * So if you configure `trusted_proxies`, also consider setting
 * `forwarded_for_headers` which otherwise defaults to `HTTP_X_FORWARDED_FOR`
 * (the `X-Forwarded-For` header).
 *
 * Defaults to an empty array.
 */
'trusted_proxies' => ['203.0.113.45', '198.51.100.128', '192.168.2.0/24'],

/**
 * Headers that should be trusted as client IP address in combination with
 * `trusted_proxies`. If the HTTP header looks like 'X-Forwarded-For', then use
 * 'HTTP_X_FORWARDED_FOR' here.
 *
 * If set incorrectly, a client can spoof their IP address as visible to
 * Nextcloud, bypassing access controls and making logs useless!
 *
 * Defaults to ``'HTTP_X_FORWARDED_FOR'``
 */
'forwarded_for_headers' => ['HTTP_X_FORWARDED', 'HTTP_FORWARDED_FOR'],

/**
 * max file size for animating gifs on public-sharing-site.
 * If the gif is bigger, it'll show a static preview
 *
 * Value represents the maximum filesize in megabytes. Set to ``-1`` for
 * no limit.
 *
 * Defaults to ``10`` megabytes
 */
'max_filesize_animated_gifs_public_sharing' => 10,


/**
 * Enables transactional file locking.
 * This is enabled by default.
 *
 * Prevents concurrent processes from accessing the same files
 * at the same time. Can help prevent side effects that would
 * be caused by concurrent operations. Mainly relevant for
 * very large installations with many users working with
 * shared files.
 *
 * Defaults to ``true``
 */
'filelocking.enabled' => true,

/**
 * Set the lock's time-to-live in seconds.
 *
 * Any lock older than this will be automatically cleaned up.
 *
 * Defaults to ``60*60`` seconds (1 hour) or the php
 *             max_execution_time, whichever is higher.
 */
'filelocking.ttl' => 60*60,

/**
 * Memory caching backend for file locking
 *
 * Because most memcache backends can clean values without warning using redis
 * is highly recommended to *avoid data loss*.
 *
 * Defaults to ``none``
 */
'memcache.locking' => '\\OC\\Memcache\\Redis',

/**
 * Enable locking debug logging
 *
 * Note that this can lead to a very large volume of log items being written which can lead
 * to performance degradation and large log files on busy instance.
 *
 * Thus enabling this in production for longer periods of time is not recommended
 * or should be used together with the ``log.condition`` setting.
 */
'filelocking.debug' => false,

/**
 * Disable the web based updater
 */
'upgrade.disable-web' => false,

/**
 * Set this Nextcloud instance to debugging mode
 *
 * Only enable this for local development and not in production environments
 * This will disable the minifier and outputs some additional debug information
 *
 * Defaults to ``false``
 */
'debug' => false,

/**
 * Sets the data-fingerprint of the current data served
 *
 * This is a property used by the clients to find out if a backup has been
 * restored on the server. Once a backup is restored run
 * ./occ maintenance:data-fingerprint
 * To set this to a new value.
 *
 * Updating/Deleting this value can make connected clients stall until
 * the user has resolved conflicts.
 *
 * Defaults to ``''`` (empty string)
 */
'data-fingerprint' => '',

/**
 * This entry is just here to show a warning in case somebody copied the sample
 * configuration. DO NOT ADD THIS SWITCH TO YOUR CONFIGURATION!
 *
 * If you, brave person, have read until here be aware that you should not
 * modify *ANY* settings in this file without reading the documentation.
 */
'copied_sample_config' => true,

/**
 * use a custom lookup server to publish user data
 */
'lookup_server' => 'https://lookup.nextcloud.com',

/**
 * set to true if the server is used in a setup based on Nextcloud's Global Scale architecture
 */
'gs.enabled' => false,

/**
 * by default federation is only used internally in a Global Scale setup
 * If you want to allow federation outside of your environment set it to 'global'
 */
'gs.federation' => 'internal',

/**
 * List of incompatible user agents opted out from Same Site Cookie Protection.
 * Some user agents are notorious and don't really properly follow HTTP
 * specifications. For those, have an opt-out.
 *
 * WARNING: only use this if you know what you are doing
 */
'csrf.optout' => [
    '/^WebDAVFS/', // OS X Finder
    '/^Microsoft-WebDAV-MiniRedir/', // Windows webdav drive
],

/**
 * By default there is on public pages a link shown that allows users to
 * learn about the "simple sign up" - see https://nextcloud.com/signup/
 *
 * If this is set to "false" it will not show the link.
 */
'simpleSignUpLink.shown' => true,

/**
 * By default autocompletion is enabled for the login form on Nextcloud's login page.
 * While this is enabled, browsers are allowed to "remember" login names and such.
 * Some companies require it to be disabled to comply with their security policy.
 *
 * Simply set this property to "false", if you want to turn this feature off.
 */

'login_form_autocomplete' => true,

/**
 * Disable background scanning of files
 *
 * By default, a background job runs every 10 minutes and execute a background
 * scan to sync filesystem and database. Only users with unscanned files
 * (size < 0 in filecache) are included. Maximum 500 users per job.
 *
 * Defaults to ``true``
 */
'files_no_background_scan' => false,
];
```

# occ commands
Available commands:
  check                                  check dependencies of the server environment
  help                                   Display help for a command
  list                                   List commands
  status                                 show some status information
  upgrade                                run upgrade routines after installation of a new release. The release has to be installed before.
 activity
  activity:send-mails                    Sends the activity notification mails
 app
  app:check-code                         check code to be compliant
  app:disable                            disable an app
  app:enable                             enable an app
  app:getpath                            Get an absolute path to the app directory
  app:install                            install an app
  app:list                               List all available apps
  app:remove                             remove an app
  app:update                             update an app or all apps
 background
  background:ajax                        Use ajax to run background jobs
  background:cron                        Use cron to run background jobs
  background:webcron                     Use webcron to run background jobs
 broadcast
  broadcast:test                         test the SSE broadcaster
 circles
  circles:check                          Checking your configuration
  circles:maintenance                    Clean stuff, keeps the app running
  circles:manage:config                  edit config/type of a Circle
  circles:manage:create                  create a new circle
  circles:manage:destroy                 destroy a circle by its ID
  circles:manage:details                 get details about a circle by its ID
  circles:manage:edit                    edit displayName or description of a Circle
  circles:manage:join                    emulate a user joining a Circle
  circles:manage:leave                   simulate a user joining a Circle
  circles:manage:list                    listing current circles
  circles:manage:setting                 edit setting for a Circle
  circles:members:add                    Add a member to a Circle
  circles:members:details                get details about a member by its ID
  circles:members:level                  Change the level of a member from a Circle
  circles:members:list                   listing Members from a Circle
  circles:members:remove                 remove a member from a circle
  circles:members:search                 Change the level of a member from a Circle
  circles:memberships                    index and display memberships for local and federated users
  circles:remote                         remote features
  circles:shares:files                   listing shares files
  circles:sync                           Sync Circles and Members
  circles:test                           testing some features
 config
  config:app:delete                      Delete an app config value
  config:app:get                         Get an app config value
  config:app:set                         Set an app config value
  config:import                          Import a list of configs
  config:list                            List all configs
  config:system:delete                   Delete a system config value
  config:system:get                      Get a system config value
  config:system:set                      Set a system config value
 dav
  dav:create-addressbook                 Create a dav addressbook
  dav:create-calendar                    Create a dav calendar
  dav:delete-calendar                    Delete a dav calendar
  dav:list-calendars                     List all calendars of a user
  dav:move-calendar                      Move a calendar from an user to another
  dav:remove-invalid-shares              Remove invalid dav shares
  dav:retention:clean-up
  dav:send-event-reminders               Sends event reminders
  dav:sync-birthday-calendar             Synchronizes the birthday calendar
  dav:sync-system-addressbook            Synchronizes users to the system addressbook
 db
  db:add-missing-columns                 Add missing optional columns to the database tables
  db:add-missing-indices                 Add missing indices to the database tables # index
  db:add-missing-primary-keys            Add missing primary keys to the database tables
  db:convert-filecache-bigint            Convert the ID columns of the filecache to BigInt
  db:convert-mysql-charset               Convert charset of MySQL/MariaDB to use utf8mb4
  db:convert-type                        Convert the Nextcloud database to the newly configured one
 encryption
  encryption:change-key-storage-root     Change key storage root
  encryption:decrypt-all                 Disable server-side encryption and decrypt all files
  encryption:disable                     Disable encryption
  encryption:disable-master-key          Disable the master key and use per-user keys instead. Only available for fresh installations with no existing encrypted data! There is no way to enable it again.
  encryption:enable                      Enable encryption
  encryption:enable-master-key           Enable the master key. Only available for fresh installations with no existing encrypted data! There is also no way to disable it again.
  encryption:encrypt-all                 Encrypt all files for all users
  encryption:fix-encrypted-version       Fix the encrypted version if the encrypted file(s) are not downloadable.
  encryption:list-modules                List all available encryption modules
  encryption:migrate-key-storage-format  Migrate the format of the keystorage to a newer format
  encryption:recover-user                Recover user data in case of password lost. This only works if the user enabled the recovery key.
  encryption:scan:legacy-format          Scan the files for the legacy format
  encryption:set-default-module          Set the encryption default module
  encryption:show-key-storage-root       Show current key storage root
  encryption:status                      Lists the current status of encryption
 federation
  federation:sync-addressbooks           Synchronizes addressbooks of all federated clouds
 files
  files:cleanup                          cleanup filecache
  files:recommendations:recommend
  files:repair-tree                      Try and repair malformed filesystem tree structures
  files:scan                             rescan filesystem
  files:scan-app-data                    rescan the AppData folder
  files:transfer-ownership               All files and folders are moved to another user - outgoing shares and incoming user file shares (optionally) are moved as well.
 group
  group:add                              Add a group
  group:adduser                          add a user to a group
  group:delete                           Remove a group
  group:info                             Show information about a group
  group:list                             list configured groups
  group:removeuser                       remove a user from a group
 integrity
  integrity:check-app                    Check integrity of an app using a signature.
  integrity:check-core                   Check integrity of core code using a signature.
  integrity:sign-app                     Signs an app using a private key.
  integrity:sign-core                    Sign core using a private key.
 l10n
  l10n:createjs                          Create javascript translation files for a given app
 log
  log:file                               manipulate logging backend
  log:manage                             manage logging configuration
  log:tail                               Tail the nextcloud logfile
  log:watch                              Watch the nextcloud logfile
 maintenance
  maintenance:data-fingerprint           update the systems data-fingerprint after a backup is restored
  maintenance:mimetype:update-db         Update database mimetypes and update filecache
  maintenance:mimetype:update-js         Update mimetypelist.js
  maintenance:mode                       set maintenance mode
  maintenance:repair                     repair this installation
  maintenance:theme:update               Apply custom theme changes
  maintenance:update:htaccess            Updates the .htaccess file
 notification
  notification:generate                  Generate a notification for the given user
  notification:test-push                 Generate a notification for the given user
 preview
  preview:repair                         distributes the existing previews into subfolders
  preview:reset-rendered-texts           Deletes all generated avatars and previews of text and md files
 saml
  saml:config:create                     Creates a new config and prints the new provider ID
  saml:config:delete
  saml:config:get
  saml:config:set
  saml:metadata                          Get SAML Metadata
 security
  security:bruteforce:reset              resets bruteforce attemps for given IP address
  security:certificates                  list trusted certificates
  security:certificates:import           import trusted certificate in PEM format
  security:certificates:remove           remove trusted certificate
 serverinfo
  serverinfo:update-storage-statistics   Triggers an update of the counts related to storages used in serverinfo
 sharing
  sharing:cleanup-remote-storages        Cleanup shared storage entries that have no matching entry in the shares_external table
  sharing:expiration-notification        Notify share initiators when a share will expire the next day.
 tag
  tag:add                                Add new tag
  tag:delete                             delete a tag
  tag:edit                               edit tag attributes
  tag:list                               list tags
 text
  text:reset                             Reset a text document
 theming
  theming:config                         Set theming app config values
 trashbin
  trashbin:cleanup                       Remove deleted files
  trashbin:expire                        Expires the users trashbin
  trashbin:size                          Configure the target trashbin size
 twofactorauth
  twofactorauth:cleanup                  Clean up the two-factor user-provider association of an uninstalled/removed provider
  twofactorauth:disable                  Disable two-factor authentication for a user
  twofactorauth:enable                   Enable two-factor authentication for a user
  twofactorauth:enforce                  Enabled/disable enforced two-factor authentication
  twofactorauth:state                    Get the two-factor authentication (2FA) state of a user
 update
  update:check                           Check for server and app updates
 user
  user:add                               adds a user
  user:add-app-password                  Add app password for the named user
  user:delete                            deletes the specified user
  user:disable                           disables the specified user
  user:enable                            enables the specified user
  user:info                              show user info
  user:lastseen                          shows when the user was logged in last time
  user:list                              list configured users
  user:report                            shows how many users have access
  user:resetpassword                     Resets the password of the named user
  user:setting                           Read and modify user settings
 versions
  versions:cleanup                       Delete versions
  versions:expire                        Expires the users file versions
 workflows
  workflows:list                         Lists configured workflows

sudo docker exec -itu 33 nextcloud php occ group:removeuser admin username

# "Your server has no Nextcloud Subscription." email spam
https://github.com/nextcloud/server/issues/16258
https://github.com/nextcloud/server/issues/11811
disable support app

```sql
select uid, json_extract_path(data::json, 'email', 'value') from oc_accounts limit 10;
select uid, json_extract_path(data::json, 'email', 'value') from oc_accounts where json_extract_path(data::json, 'email', 'value')::varchar like '"fa%' limit 20; -- please notice the leading " in the like operator right hand side member
select oc_accounts.uid, json_extract_path(oc_accounts.data::json, 'email', 'value'), gid from oc_accounts left join oc_group_user on oc_accounts.uid = oc_group_user.uid where json_extract_path(data::json, 'email', 'value')::varchar like '"fab%' limit 20;
select oc_accounts.uid, json_extract_path(oc_accounts.data::json, 'email', 'value'), gid from oc_accounts left join oc_group_user on oc_accounts.uid = oc_group_user.uid where json_extract_path(data::json, 'email', 'value')::varchar like '"mar%' limit 20;
select oc_accounts.uid, json_extract_path(oc_accounts.data::json, 'email', 'value'), gid from oc_accounts left join oc_group_user on oc_accounts.uid = oc_group_user.uid where gid = 'admin';
select oc_groups.displayname, json_extract_path(oc_accounts.data::json, 'email')->>'value' as email, oc_accounts.uid from oc_accounts left join oc_group_user on oc_accounts.uid = oc_group_user.uid left join oc_groups on oc_group_user.gid = oc_groups.gid where lower(oc_groups.displayname) like '%monaco%' or lower(oc_groups.displayname) like '%iom%' order by oc_groups.displayname, email, oc_accounts.uid; -- group membership
select oc_groups.displayname, json_extract_path(oc_accounts.data::json, 'email')->>'value' as email, oc_accounts.uid from oc_accounts left join oc_group_user on oc_accounts.uid = oc_group_user.uid left join oc_groups on oc_group_user.gid = oc_groups.gid where oc_accounts.uid not like '10166%' and (lower(oc_groups.displayname) like '%monaco%' or lower(oc_groups.displayname) like '%iom%') order by oc_groups.displayname, email, oc_accounts.uid; -- group membershi:
select oc_accounts.uid, json_extract_path(oc_accounts.data::json, 'displayname', 'value') as displayname, json_extract_path(oc_accounts.data::json, 'email', 'value') as email, gid from oc_accounts left join oc_group_user on oc_accounts.uid = oc_group_user.uid where gid = 'admin';
```

```sh
docker exec -e OC_PASS=uaeoh..............EAU15353 -itu 33 nextcloud php occ user:add --password-from-env --display-name "John Majer" myuserid
docker exec -itu 33 nextcloud php occ user:setting myuserid settings email bob@apple.com
docker exec -itu 33 nextcloud php occ group:adduser "MYGROUP" "userid"
docker exec -itu 33 nextcloud php occ encryption:fix-encrypted-version MYUSERNAME
docker exec -itu 33 nextcloud php occ encryption:fix-encrypted-version --path MYPATH -- MYUSERNAME
```


# What's the difference between NC hubs and NC versions?
No difference, just a new name and starting from number 1. Internal it's called Nextcloud 25. Frank answered this question at the conference on Saturday.
https://www.reddit.com/r/NextCloud/comments/xtlqzn/announcing_nextcloud_hub_3_brand_new_design_and/


# local client exclude list
* https://help.nextcloud.com/t/how-can-i-edit-the-default-ignored-files-list/5004/6
In C:\Users%username%\AppData\Local\Nextcloud adds a file named sync-exclude.lst if you add other extensions that not the default ones.
In NextCloud client, in the tab “General” you have “Advanced” - Edit Ignored Files, there are the default ones, if you add anything to there, it will create the sync-exclude.lst file.
```sh
/PhotoPreviews/   # Documents/ifolor/Photobooks/*/PhotoPreviews/
/PhotoThumbnails/ # Documents/ifolor/Photobooks/*/PhotoThumbnails
                                               ```


# chat webrtc
https://apps.nextcloud.com/apps/spreed
https://github.com/nextcloud/spreed


# push mobile
This is the unsupported community build of Nextcloud. Given the size of this instance, performance, reliability and scalability cannot be guaranteed. Push notifications are limited to avoid overloading our free service.
* GDPR data processor third party https://help.nextcloud.com/t/this-is-the-unsupported-community-build-of-nextcloud-with-push-for-500-users/154477/10
