/* ex: set filetype=java: */
# string format date
	System.out.println(String.format("mrstub %tY.%<tm.%<td %<tH.%<tM.%<tS-%<tL", new Date()));
String.format("%-10s   #left align
String.format("%10s    #right align
String.format("%,6d    #locale thousand grouping separator which counts as character count
String.format("%03d    #007


{@link java.math.BigDecimal#abs()}
Tag & Parameter           Usage                                                Applies to
@author John Smith        Describes an author.                                 Class, Interface, Enum
@version version          Provides software version entry.                     Class, Interface, Enum
@since since-text         Describes when this functionality has first existed. Class, Interface, Enum, Field, Method
@see reference            Provides a link to other element of documentation.   Class, Interface, Enum, Field, Method
@param name desc          Describes a method parameter.                        Method
@return desc              Describes the return value.                          Method
@exception classname desc Describes an exception that may be thrown.           Method
@throws classname desc    Describes an exception that may be thrown.           Method
@deprecated desc          Describes an outdated method.                        Method
{@inheritDoc}             Copies the description from the overridden method.   Overriding Method
{@link reference}         Link to other symbol.                                Class, Interface, Enum, Field, Method
{@value #STATIC_FIELD}    Return the value of a static field.                  Static Field


# Web service
#ws import being part of jdk
wsimport -keep  -s source C:\Users\me\global\apps\Talend-4.2.4\workspacemroffline\MG\process\FibuBooking.wsdl

jar cf ..\jarname.jar .


new java.text.SimpleDateFormat("yyyy.MM.dd 'at' HH:mm:ss").format(new java.util.Date())
	=> 2001.07.04 AD at 12:08:56 PDT

G 	Era designator 			Text 				AD
y 	Year 					Year 				1996; 96
M 	Month in year 			Month 				July; Jul; 07
w 	Week in year 			Number 				27
W 	Week in month 			Number 				2
D 	Day in year 			Number 				189
d 	Day in month 			Number 				10
F 	Day of week in month 	Number 				2
E 	Day in week 			Text 				Tuesday; Tue
a 	Am/pm marker 			Text 				PM
H 	Hour in day (0-23) 		Number 				0
k 	Hour in day (1-24) 		Number 				24
K 	Hour in am/pm (0-11) 	Number 				0
h 	Hour in am/pm (1-12) 	Number 				12
m 	Minute in hour 			Number 				30
s 	Second in minute 		Number 				55
S 	Millisecond 			Number 				978
z 	Time zone 				General time zone 	Pacific Standard Time; PST; GMT-08:00
Z 	Time zone 				RFC 822 time zone 	-0800

"yyyy.MM.dd G 'at' HH:mm:ss z" 				2001.07.04 AD at 12:08:56 PDT
"EEE, MMM d, ''yy" 							Wed, Jul 4, '01
"h:mm a" 									12:08 PM
"hh 'o''clock' a, zzzz" 					12 o'clock PM, Pacific Daylight Time
"K:mm a, z" 								0:08 PM, PDT
"yyyyy.MMMMM.dd GGG hh:mm aaa" 				02001.July.04 AD 12:08 PM
"EEE, d MMM yyyy HH:mm:ss Z" 				Wed, 4 Jul 2001 12:08:56 -0700
"yyMMddHHmmssZ" 							010704120856-0700
"yyyy-MM-dd'T'HH:mm:ss.SSSZ" 				2001-07-04T12:08:56.235-0700
"yyyy.MM.dd_HH.mm.ss" 				        2001.07.04_12.08.56

"abcdea".matches("[.]+"); // # => false
"......".matches("[.]+"); // # => true

regexp
Construct 	Matches
 
Characters
x 	The character x
\\ 	The backslash character
\0n 	The character with octal value 0n (0 <= n <= 7)
\0nn 	The character with octal value 0nn (0 <= n <= 7)
\0mnn 	The character with octal value 0mnn (0 <= m <= 3, 0 <= n <= 7)
\xhh 	The character with hexadecimal value 0xhh
\uhhhh 	The character with hexadecimal value 0xhhhh
\t 	The tab character ('\u0009')
\n 	The newline (line feed) character ('\u000A')
\r 	The carriage-return character ('\u000D')
\f 	The form-feed character ('\u000C')
\a 	The alert (bell) character ('\u0007')
\e 	The escape character ('\u001B')
\cx 	The control character corresponding to x
 
Character classes
[abc] 	a, b, or c (simple class)
[^abc] 	Any character except a, b, or c (negation)
[a-zA-Z] 	a through z or A through Z, inclusive (range)
[a-d[m-p]] 	a through d, or m through p: [a-dm-p] (union)
[a-z&&[def]] 	d, e, or f (intersection)
[a-z&&[^bc]] 	a through z, except for b and c: [ad-z] (subtraction)
[a-z&&[^m-p]] 	a through z, and not m through p: [a-lq-z](subtraction)
 
Predefined character classes
. 	Any character (may or may not match line terminators)
\d 	A digit: [0-9]
\D 	A non-digit: [^0-9]
\s 	A whitespace character: [ \t\n\x0B\f\r]
\S 	A non-whitespace character: [^\s]
\w 	A word character: [a-zA-Z_0-9]
\W 	A non-word character: [^\w]
 
POSIX character classes (US-ASCII only)
\p{Lower} 	A lower-case alphabetic character: [a-z]
\p{Upper} 	An upper-case alphabetic character:[A-Z]
\p{ASCII} 	All ASCII:[\x00-\x7F]
\p{Alpha} 	An alphabetic character:[\p{Lower}\p{Upper}]
\p{Digit} 	A decimal digit: [0-9]
\p{Alnum} 	An alphanumeric character:[\p{Alpha}\p{Digit}]
\p{Punct} 	Punctuation: One of !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
\p{Graph} 	A visible character: [\p{Alnum}\p{Punct}]
\p{Print} 	A printable character: [\p{Graph}\x20]
\p{Blank} 	A space or a tab: [ \t]
\p{Cntrl} 	A control character: [\x00-\x1F\x7F]
\p{XDigit} 	A hexadecimal digit: [0-9a-fA-F]
\p{Space} 	A whitespace character: [ \t\n\x0B\f\r]
 
java.lang.Character classes (simple java character type)
\p{javaLowerCase} 	Equivalent to java.lang.Character.isLowerCase()
\p{javaUpperCase} 	Equivalent to java.lang.Character.isUpperCase()
\p{javaWhitespace} 	Equivalent to java.lang.Character.isWhitespace()
\p{javaMirrored} 	Equivalent to java.lang.Character.isMirrored()
 
Classes for Unicode blocks and categories
\p{InGreek} 	A character in the Greek block (simple block)
\p{Lu} 	An uppercase letter (simple category)
\p{Sc} 	A currency symbol
\P{InGreek} 	Any character except one in the Greek block (negation)
[\p{L}&&[^\p{Lu}]]  	Any letter except an uppercase letter (subtraction)
 
Boundary matchers
^ 	The beginning of a line
$ 	The end of a line
\b 	A word boundary
\B 	A non-word boundary
\A 	The beginning of the input
\G 	The end of the previous match
\Z 	The end of the input but for the final terminator, if any
\z 	The end of the input
 
Greedy quantifiers
X? 	X, once or not at all
X* 	X, zero or more times
X+ 	X, one or more times
X{n} 	X, exactly n times
X{n,} 	X, at least n times
X{n,m} 	X, at least n but not more than m times
 
Reluctant quantifiers
X?? 	X, once or not at all
X*? 	X, zero or more times
X+? 	X, one or more times
X{n}? 	X, exactly n times
X{n,}? 	X, at least n times
X{n,m}? 	X, at least n but not more than m times
 
Possessive quantifiers
X?+ 	X, once or not at all
X*+ 	X, zero or more times
X++ 	X, one or more times
X{n}+ 	X, exactly n times
X{n,}+ 	X, at least n times
X{n,m}+ 	X, at least n but not more than m times
 
Logical operators
XY 	X followed by Y
X|Y 	Either X or Y
(X) 	X, as a capturing group
 
Back references
\n 	Whatever the nth capturing group matched, However in replaceAll, refer to groups as $n
 
Quotation
\ 	Nothing, but quotes the following character
\Q 	Nothing, but quotes all characters until \E
\E 	Nothing, but ends quoting started by \Q
 
Special constructs (non-capturing)
(?:X) 	X, as a non-capturing group
(?idmsux-idmsux)  	Nothing, but turns match flags i d m s u x on - off
(?idmsux-idmsux:X)   	X, as a non-capturing group with the given flags i d m s u x on - off
(?=X) 	X, via zero-width positive lookahead
(?!X) 	X, via zero-width negative lookahead
(?<=X) 	X, via zero-width positive lookbehind
(?<!X) 	X, via zero-width negative lookbehind
(?>X) 	X, as an independent, non-capturing group


javax.mail
mail.smtp.user 	String 	Default user name for SMTP.
mail.smtp.host 	String 	The SMTP server to connect to.
mail.smtp.port 	int 	The SMTP server port to connect to, if the connect() method doesn't explicitly specify one. Defaults to 25.
mail.smtp.connectiontimeout 	int 	Socket connection timeout value in milliseconds. Default is infinite timeout.
mail.smtp.timeout 	int 	Socket I/O timeout value in milliseconds. Default is infinite timeout.
mail.smtp.from 	String 	Email address to use for SMTP MAIL command. This sets the envelope return address. Defaults to msg.getFrom() or InternetAddress.getLocalAddress(). NOTE: mail.smtp.user was previously used for this.
mail.smtp.localhost 	String 	Local host name used in the SMTP HELO or EHLO command. Defaults to InetAddress.getLocalHost().getHostName(). Should not normally need to be set if your JDK and your name service are configured properly.
mail.smtp.localaddress 	String 	Local address (host name) to bind to when creating the SMTP socket. Defaults to the address picked by the Socket class. Should not normally need to be set, but useful with multi-homed hosts where it's important to pick a particular local address to bind to.
mail.smtp.localport 	int 	Local port number to bind to when creating the SMTP socket. Defaults to the port number picked by the Socket class.
mail.smtp.ehlo 	boolean 	If false, do not attempt to sign on with the EHLO command. Defaults to true. Normally failure of the EHLO command will fallback to the HELO command; this property exists only for servers that don't fail EHLO properly or don't implement EHLO properly.
mail.smtp.auth 	boolean 	If true, attempt to authenticate the user using the AUTH command. Defaults to false.
mail.smtp.auth.mechanisms 	String 	If set, lists the authentication mechanisms to consider, and the order in which to consider them. Only mechanisms supported by the server and supported by the current implementation will be used. The default is "LOGIN PLAIN DIGEST-MD5 NTLM", which includes all the authentication mechanisms supported by the current implementation.
mail.smtp.auth.login.disable 	boolean 	If true, prevents use of the AUTH LOGIN command. Default is false.
mail.smtp.auth.plain.disable 	boolean 	If true, prevents use of the AUTH PLAIN command. Default is false.
mail.smtp.auth.digest-md5.disable 	boolean 	If true, prevents use of the AUTH DIGEST-MD5 command. Default is false.
mail.smtp.auth.ntlm.disable 	boolean 	If true, prevents use of the AUTH NTLM command. Default is false.
mail.smtp.auth.ntlm.domain 	String 	The NTLM authentication domain.
mail.smtp.auth.ntlm.flags 	int 	NTLM protocol-specific flags. See http://curl.haxx.se/rfc/ntlm.html#theNtlmFlags for details.
mail.smtp.submitter 	String 	The submitter to use in the AUTH tag in the MAIL FROM command. Typically used by a mail relay to pass along information about the original submitter of the message. See also the setSubmitter method of SMTPMessage. Mail clients typically do not use this.
mail.smtp.dsn.notify 	String 	The NOTIFY option to the RCPT command. Either NEVER, or some combination of SUCCESS, FAILURE, and DELAY (separated by commas).
mail.smtp.dsn.ret 	String 	The RET option to the MAIL command. Either FULL or HDRS.
mail.smtp.allow8bitmime 	boolean 	If set to true, and the server supports the 8BITMIME extension, text parts of messages that use the "quoted-printable" or "base64" encodings are converted to use "8bit" encoding if they follow the RFC2045 rules for 8bit text.
mail.smtp.sendpartial 	boolean 	If set to true, and a message has some valid and some invalid addresses, send the message anyway, reporting the partial failure with a SendFailedException. If set to false (the default), the message is not sent to any of the recipients if there is an invalid recipient address.
mail.smtp.sasl.enable 	boolean 	If set to true, attempt to use the javax.security.sasl package to choose an authentication mechanism for login. Defaults to false.
mail.smtp.sasl.mechanisms 	String 	A space or comma separated list of SASL mechanism names to try to use.
mail.smtp.sasl.authorizationid 	String 	The authorization ID to use in the SASL authentication. If not set, the authentication ID (user name) is used.
mail.smtp.sasl.realm 	String 	The realm to use with DIGEST-MD5 authentication.
mail.smtp.quitwait 	boolean 	If set to false, the QUIT command is sent and the connection is immediately closed. If set to true (the default), causes the transport to wait for the response to the QUIT command.
mail.smtp.reportsuccess 	boolean 	If set to true, causes the transport to include an SMTPAddressSucceededException for each address that is successful. Note also that this will cause a SendFailedException to be thrown from the sendMessage method of SMTPTransport even if all addresses were correct and the message was sent successfully.
mail.smtp.socketFactory 	SocketFactory 	If set to a class that implements the javax.net.SocketFactory interface, this class will be used to create SMTP sockets. Note that this is an instance of a class, not a name, and must be set using the put method, not the setProperty method.
mail.smtp.socketFactory.class 	String 	If set, specifies the name of a class that implements the javax.net.SocketFactory interface. This class will be used to create SMTP sockets.
mail.smtp.socketFactory.fallback 	boolean 	If set to true, failure to create a socket using the specified socket factory class will cause the socket to be created using the java.net.Socket class. Defaults to true.
mail.smtp.socketFactory.port 	int 	Specifies the port to connect to when using the specified socket factory. If not set, the default port will be used.
mail.smtp.ssl.enable 	boolean 	If set to true, use SSL to connect and use the SSL port by default. Defaults to false for the "smtp" protocol and true for the "smtps" protocol.
mail.smtp.ssl.checkserveridentity 	boolean 	If set to true, check the server identity as specified by RFC 2595. These additional checks based on the content of the server's certificate are intended to prevent man-in-the-middle attacks. Defaults to false.
mail.smtp.ssl.trust 	String 	If set, and a socket factory hasn't been specified, enables use of a MailSSLSocketFactory. If set to "*", all hosts are trusted. If set to a whitespace separated list of hosts, those hosts are trusted. Otherwise, trust depends on the certificate the server presents.
mail.smtp.ssl.socketFactory 	SSLSocketFactory 	If set to a class that extends the javax.net.ssl.SSLSocketFactory class, this class will be used to create SMTP SSL sockets. Note that this is an instance of a class, not a name, and must be set using the put method, not the setProperty method.
mail.smtp.ssl.socketFactory.class 	String 	If set, specifies the name of a class that extends the javax.net.ssl.SSLSocketFactory class. This class will be used to create SMTP SSL sockets.
mail.smtp.ssl.socketFactory.port 	int 	Specifies the port to connect to when using the specified socket factory. If not set, the default port will be used.
mail.smtp.ssl.protocols 	string 	Specifies the SSL protocols that will be enabled for SSL connections. The property value is a whitespace separated list of tokens acceptable to the javax.net.ssl.SSLSocket.setEnabledProtocols method.
mail.smtp.ssl.ciphersuites 	string 	Specifies the SSL cipher suites that will be enabled for SSL connections. The property value is a whitespace separated list of tokens acceptable to the javax.net.ssl.SSLSocket.setEnabledCipherSuites method.
mail.smtp.starttls.enable 	boolean 	If true, enables the use of the STARTTLS command (if supported by the server) to switch the connection to a TLS-protected connection before issuing any login commands. Note that an appropriate trust store must configured so that the client will trust the server's certificate. Defaults to false.
mail.smtp.starttls.required 	boolean 	If true, requires the use of the STARTTLS command. If the server doesn't support the STARTTLS command, or the command fails, the connect method will fail. Defaults to false.
mail.smtp.socks.host 	string 	Specifies the host name of a SOCKS5 proxy server that will be used for connections to the mail server. (Note that this only works on JDK 1.5 or newer.)
mail.smtp.socks.port 	string 	Specifies the port number for the SOCKS5 proxy server. This should only need to be used if the proxy server is not using the standard port number of 1080.
mail.smtp.mailextension 	String 	Extension string to append to the MAIL command. The extension string can be used to specify standard SMTP service extensions as well as vendor-specific extensions. Typically the application should use the SMTPTransport method supportsExtension to verify that the server supports the desired service extension. See RFC 1869 and other RFCs that define specific extensions.
mail.smtp.userset 	boolean 	If set to true, use the RSET command instead of the NOOP command in the isConnected method. In some cases sendmail will respond slowly after many NOOP commands; use of RSET avoids this sendmail issue. Defaults to false.
mail.smtp.noop.strict 	boolean 	If set to true (the default), insist on a 250 response code from the NOOP command to indicate success. The NOOP command is used by the isConnected method to determine if the connection is still alive. Some older servers return the wrong response code on success, some servers don't implement the NOOP command at all and so always return a failure code. Set this property to false to handle servers that are broken in this way. Normally, when a server times out a connection, it will send a 421 response code, which the client will see as the response to the next command it issues. Some servers send the wrong failure response code when timing out a connection. Do not set this property to false when dealing with servers that are broken in this way. 

# list files classes in a jar file
jar tf JARNAME.jar
#
# alternative  on buch of files and grepping ConsoleProducer
for i in *jar; do unzip -l $i | grep ConsoleProducer | while read line; do echo "$i: $line"; done; done

# list functions in a class possibly inside a jar file
javap -cp "uc4.jar" com/uc4/communication/requests/FolderTree
javap -cp "uc4.jar" com.uc4.api.objects.IFolder


# list functions inside a jar
jar=uc4.jar; { for i in $(jar tf $jar | grep class$); do echo ${i//.class/}; done; } | xargs javap -cp $jar

# wildcard to create class path: WARNING: *.jar is wrong, only * works
java -cp "Test.jar;lib/*" my.package.MainClass
# or the shell trick
java -cp $(for i in lib/*.jar ; do echo -n $i: ; done). my.main.Class
java -cp $(echo lib/*.jar | tr ' ' ':')
java -cp "build/WEB-INF/lib/*" com.tor.fw.servlet.MrQrCode


javax.xml.bind.DatatypeConverter#parseDateTime(String xsdDateTime)


-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.port=29674
-Dcom.sun.management.jmxremote.rmi.port=9911
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.host=BINDIP # only avaiable since a recent update https://bugs.openjdk.java.net/browse/JDK-6425769

export JAVA_OPTS=-Xmx2048m

wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.rpm" --output-document="jdk-8-linux-x64.rpm"


# jmx cmdline
java -jar jmxterm-1.0-alpha-4-uber.jar  --verbose brief --url service:jmx:rmi:///jndi/rmi://s-kafka-001.ms.net:12345/jmxrmi
echo beans | java -jar jmxterm-1.0-alpha-4-uber.jar  --noninteract --verbose brief --url service:jmx:rmi:///jndi/rmi://s-kafka-001.ms.net:12345/jmxrmi

jcmd <PID> Thread.print # print stacktrace to stdout on java8
jstack PID              # print stacktrace to stdout

System.getenv("JAVA_HOME"); // get environment variable

# legacy log4j.properties line number in loge
#log4j.appender.stdout.layout.ConversionPattern=%d{HH:mm:ss,SSS} %l %.1p %c %m%n

java -noverify -jar signed.jar

docker run --rm -it mausch/docker-groovysh
docker run --rm -v $PWD:/myjar -it mausch/docker-groovysh bash bin/groovysh -cp '/myjar/json-20160810.jar'
'/myjar/*'
. /myjar/bip.groovy
// . /myjar/bip.groovy
// import org.json.JSONObject;
// c = "{\"id\":\"\"}";
// j = new JSONObject(c);
