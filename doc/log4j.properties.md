https://logging.apache.org/log4j/2.x/

# CVE-2021-44832
fixed by log4j 2.17.1, 2.3.2 (for Java 6), 2.12.4 (for Java 7), or 2.17.1 (for Java 8 and later)

# CVE-2021-45105
fixed by log4j 2.17.0


# CVE-2021-44228
# CVE-2021-45046
# CVE-2021-45105
LOG4J_FORMAT_MSG_NO_LOOKUPS: "true"
https://mcas-proxyweb.mcas.ms/certificate-checker?login=false&originalUrl=https%3A%2F%2Fgithub.com.mcas.ms%2FNeo23x0%2Flog4shell-detector%3FMcasTsid%3D28375&McasCSRF=6b197ad6d78755470a1863ee40c4a42026a4e1740491092c8d72b121bbc6afc8

# CVE-2021-45046
# CVE-2021-45105
fixed by log4j 2.16.0

# layout pattern patternlayout expansion
https://logging.apache.org/log4j/2.x/manual/layouts.html#PatternLayout
%C    # package + classname of the caller
%c    # package + classname of the logger (so if fact it could be any arbitrary name, not specifically an existing package + name)
%c{1} # class name

# log4j 1
```ini
log4j.rootLogger=TRACE, stdout, mr0

log4j.logger.com.tensorsys.validator.Fin=DEBUG
log4j.logger.tools.Io=DEBUG

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d{HH:mm:ss,SSS} %-5p %c{1} - %m%n
log4j.appender.stdout.target=System.err

log4j.appender.mr0=org.apache.log4j.MrDailyRollingFileAppender
log4j.appender.mr0.file=logs/mr0
log4j.appender.mr0.datePattern='.'yyyy-MM-dd
log4j.appender.mr0.layout=org.apache.log4j.PatternLayout
log4j.appender.mr0.layout.ConversionPattern=%d [%t] %-5p %-16c{1} %m%n
log4j.appender.stdout.layout.ConversionPattern=%d{HH:mm:ss,SSS} %-5p %c{1}.%M(%L): %m%n # method and line number
log4j.appender.mr0.threshold=TRACE
log4j.appender.mr0.keep=2
```

# log4j 2
%d{yyyy-MM-dd HH:mm:ss}{GMT+0}

```ini
# https://logging.apache.org/log4j/2.x/manual/configuration.html#Properties
# https://logging.apache.org/log4j/2.x/manual/configuration.html#ConfigurationSyntax
status = info
shutdownHook = disable

appender.stdout.type = Console
appender.stdout.name = myconsolename
appender.stdout.layout.type = PatternLayout
#appender.stdout.layout.pattern = [%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %c{1} - %msg%n
appender.stdout.layout.pattern = %d{HH:mm:ss,SSS} %.1p %c %m%n

# Rotate log file
appender.mr0.type = RollingFile
appender.mr0.name = mr0name
#appender.mr0.fileName = logs/app.log
#appender.mr0.filePattern = logs/$${date:yyyy-MM}/app-%d{MM-dd-yyyy}-%i.log.gz
appender.mr0.filePattern = logs/mr0.%d{yyyy.MM.dd}.log
appender.mr0.layout.type = PatternLayout
appender.mr0.layout.pattern = %d %p %C{1.} [%t] %m%n
appender.mr0.policies.type = Policies
appender.mr0.policies.time.type = TimeBasedTriggeringPolicy

# DefaultRolloverStrategy
# DirectWriteRolloverStrategy helps when current log file should be dated such as in tsys
# it does not have the max from DefaultRolloverStrategy, but has a maxFiles which seems a
# as it needs a %i in the pattern to be used and likely a SizeBasedTriggeringPolicy to trigger
# the rotation.
appender.mr0.strategy.type = DirectWriteRolloverStrategy
#appender.mr0.policies.time.interval = 10
#appender.mr0.policies.time.modulate = false
#appender.mr0.policies.size.type = SizeBasedTriggeringPolicy
#appender.mr0.policies.size.size=5kb
# DirectFileRolloverStrategy
#appender.mr0.strategy.maxFiles = 3

# Log to console and rolling file
logger.app.name = com.mkyong
logger.app.level = debug
logger.app.additivity = false
logger.app.appenderRef.myref1.ref = mr0name
logger.app.appenderRef.mfref2.ref = myconsolename

rootLogger.level = info
rootLogger.appenderRef.stdout.ref = myconsolename
rootLogger.appenderRef.tofile.ref = mr0name

# delete files 1
appender.b.strategy.action.type = Delete
appender.b.strategy.action.basepath = logs
appender.b.strategy.action.maxDepth = 1
appender.b.strategy.action.a.type = IfAll
appender.b.strategy.action.a.a.type = IfFileName
appender.b.strategy.action.a.a.glob = ccc.*.log
appender.b.strategy.action.a.b.type = IfLastModified
appender.b.strategy.action.a.b.age  = 30s

# delete files 2 more careful, yet dangerous with regex and properties
property.logdir = logs
property.a.create_pattern       =  ddd.%d{yyyy.MM.dd-HH.mm.ss}.log
property.a.delete_regex_pattern =  ddd\\.20\\d{2}\\.\\d{2}.\\d{2}-\\d{2}\\.\\d{2}.\\d{2}\\.log
appender.b.type = RollingFile
appender.b.name = mr0
appender.b.filePattern = ${logdir}/${a.create_pattern}
appender.b.layout.type = PatternLayout
appender.b.layout.pattern = %d [%t] %-5p %-16c{1} %m%n
appender.b.policies.type = Policies
appender.b.policies.time.type = TimeBasedTriggeringPolicy
appender.b.policies.time.interval = 5
appender.b.policies.time.modulate = true
appender.b.strategy.type = DirectWriteRolloverStrategy
appender.b.strategy.action.type = Delete
appender.b.strategy.action.basepath = ${logdir}
appender.b.strategy.action.maxDepth = 1
appender.b.strategy.action.a.type = IfAll
appender.b.strategy.action.a.a.type = IfFileName
appender.b.strategy.action.a.a.regex = ${a.delete_regex_pattern}
appender.b.strategy.action.a.b.type = IfLastModified
appender.b.strategy.action.a.b.age  = 15s

# delete files, keep at least 30 files no matter what, delete older then 5s
property.logdir = logs
property.a.create_pattern       =  sd2.%d{yyyy.MM.dd-HH.mm.ss}.log
property.a.delete_regex_pattern =  sd2\\.20\\d{2}\\.\\d{2}.\\d{2}-\\d{2}\\.\\d{2}.\\d{2}\\.log
appender.b.type = RollingFile
appender.b.name = mr0
appender.b.filePattern = ${logdir}/${a.create_pattern}
appender.b.layout.type = PatternLayout
appender.b.layout.pattern = %d [%t] %-5p %-16c{1} %m%n
appender.b.policies.type = Policies
appender.b.policies.time.type = TimeBasedTriggeringPolicy
appender.b.policies.time.interval = 1
appender.b.policies.time.modulate = true
appender.b.strategy.type = DirectWriteRolloverStrategy
appender.b.strategy.a.type = Delete
appender.b.strategy.a.basepath = ${logdir}
appender.b.strategy.a.maxDepth = 1
appender.b.strategy.a.a.type = IfFileName
appender.b.strategy.a.a.regex = ${a.delete_regex_pattern}
appender.b.strategy.a.a.a.type = IfAccumulatedFileCount
appender.b.strategy.a.a.a.exceeds = 30
appender.b.strategy.a.a.a.a.type = IfLastModified
appender.b.strategy.a.a.a.a.age  = 5s

```

# https://stackoverflow.com/questions/35982475/how-to-use-current-date-pattern-in-log4j2-filename/35982557
Remove the filename attribute. It worked for me. (got the solution from: https://issues.apache.org/jira/browse/LOG4J2-1859) Here is my working configuration

    <RollingFile name="File" filePattern="${basePath}/api_test_execution_log_%d{yyyy-MM-dd}_%d{HH-mm-ss}_%i.log" immediateFlush="true">
       <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>

       <Policies>
            <TimeBasedTriggeringPolicy interval="1" modulate="true"/>
            <SizeBasedTriggeringPolicy size="32 MB" />
            <OnStartupTriggeringPolicy/>
       </Policies>
    </RollingFile>


# https://logging.apache.org/log4j/2.x/manual/layouts.html
Conversion Pattern	Description
c{precision}
logger{precision}
Outputs the name of the logger that published the logging event. The logger conversion specifier can be optionally followed by precision specifier, which consists of a decimal integer, or a pattern starting with a decimal integer.

When the precision specifier is an integer value, it reduces the size of the logger name. If the number is positive, the layout prints the corresponding number of rightmost logger name components. If negative, the layout removes the corresponding number of leftmost logger name components. If the precision contains periods then the number before the first period identifies the length to be printed from items that precede tokens in the rest of the pattern. If the number after the first period is followed by an asterisk it indicates how many of the rightmost tokens will be printed in full. See the table below for abbreviation examples.

If the precision contains any non-integer characters, then the layout abbreviates the name based on the pattern. If the precision integer is less than one, the layout still prints the right-most token in full. By default, the layout prints the logger name in full.

Conversion Pattern	Logger Name	Result
%c{1}	org.apache.commons.Foo	Foo
%c{2}	org.apache.commons.Foo	commons.Foo
%c{10}	org.apache.commons.Foo	org.apache.commons.Foo
%c{-1}	org.apache.commons.Foo	apache.commons.Foo
%c{-2}	org.apache.commons.Foo	commons.Foo
%c{-10}	org.apache.commons.Foo	org.apache.commons.Foo
%c{1.}	org.apache.commons.Foo	o.a.c.Foo
%c{1.1.~.~}	org.apache.commons.test.Foo	o.a.~.~.Foo
%c{.}	org.apache.commons.test.Foo	....Foo
%c{1.1.1.*}	org.apache.commons.test.Foo	o.a.c.test.Foo
%c{1.2.*}	org.apache.commons.test.Foo	o.a.c.test.Foo
%c{1.3.*}	org.apache.commons.test.Foo	o.a.commons.test.Foo
%c{1.8.*}	org.apache.commons.test.Foo	org.apache.commons.test.Foo
C{precision}
class{precision}
Outputs the fully qualified class name of the caller issuing the logging request. This conversion specifier can be optionally followed by precision specifier, that follows the same rules as the logger name converter.

Generating the class name of the caller (location information) is an expensive operation and may impact performance. Use with caution.

d{pattern}
date{pattern}
Outputs the date of the logging event. The date conversion specifier may be followed by a set of braces containing a date and time pattern string per SimpleDateFormat .

The predefined named formats are:

Pattern	Example
%d{DEFAULT}	2012-11-02 14:34:02,123
%d{DEFAULT_MICROS}	2012-11-02 14:34:02,123456
%d{DEFAULT_NANOS}	2012-11-02 14:34:02,123456789
%d{ISO8601}	2012-11-02T14:34:02,781
%d{ISO8601_BASIC}	20121102T143402,781
%d{ISO8601_OFFSET_DATE_TIME_HH}	2012-11-02'T'14:34:02,781-07
%d{ISO8601_OFFSET_DATE_TIME_HHMM}	2012-11-02'T'14:34:02,781-0700
%d{ISO8601_OFFSET_DATE_TIME_HHCMM}	2012-11-02'T'14:34:02,781-07:00
%d{ABSOLUTE}	14:34:02,781
%d{ABSOLUTE_MICROS}	14:34:02,123456
%d{ABSOLUTE_NANOS}	14:34:02,123456789
%d{DATE}	02 Nov 2012 14:34:02,781
%d{COMPACT}	20121102143402781
%d{UNIX}	1351866842
%d{UNIX_MILLIS}	1351866842781
You can also use a set of braces containing a time zone id per java.util.TimeZone.getTimeZone. If no date format specifier is given then the DEFAULT format is used.

You can define custom date formats:

Pattern	Example
%d{HH:mm:ss,SSS}	14:34:02,123
%d{HH:mm:ss,nnnn} to %d{HH:mm:ss,nnnnnnnnn}	14:34:02,1234 to 14:34:02,123456789
%d{dd MMM yyyy HH:mm:ss,SSS}	02 Nov 2012 14:34:02,123
%d{dd MMM yyyy HH:mm:ss,nnnn} to %d{dd MMM yyyy HH:mm:ss,nnnnnnnnn}	02 Nov 2012 14:34:02,1234 to 02 Nov 2012 14:34:02,123456789
%d{HH:mm:ss}{GMT+0}	18:34:02
%d{UNIX} outputs the UNIX time in seconds. %d{UNIX_MILLIS} outputs the UNIX time in milliseconds. The UNIX time is the difference, in seconds for UNIX and in milliseconds for UNIX_MILLIS, between the current time and midnight, January 1, 1970 UTC. While the time unit is milliseconds, the granularity depends on the operating system (Windows). This is an efficient way to output the event time because only a conversion from long to String takes place, there is no Date formatting involved.

Log4j 2.11 adds limited support for timestamps more precise than milliseconds when running on Java 9. Note that not all DateTimeFormatter formats are supported. Only timestamps in the formats mentioned in the table above may use the "nano-of-second" pattern letter n instead of the "fraction-of-second" pattern letter S.

Users may revert back to a millisecond-precision clock when running on Java 9 by setting system property log4j2.Clock to SystemMillisClock.

enc{pattern}{[HTML|XML|JSON|CRLF]}
encode{pattern}{[HTML|XML|JSON|CRLF]}
Encodes and escapes special characters suitable for output in specific markup languages. By default, this encodes for HTML if only one option is specified. The second option is used to specify which encoding format should be used. This converter is particularly useful for encoding user provided data so that the output data is not written improperly or insecurely.

A typical usage would encode the message %enc{%m} but user input could come from other locations as well, such as the MDC %enc{%mdc{key}}

Using the HTML encoding format, the following characters are replaced:

Character	Replacement
'\r', '\n'	Converted into escaped strings "\\r" and "\\n" respectively
&, <, >, ", ', /	Replaced with the corresponding HTML entity
Using the XML encoding format, this follows the escaping rules specified by the XML specification:

Character	Replacement
&, <, >, ", '	Replaced with the corresponding XML entity
Using the JSON encoding format, this follows the escaping rules specified by RFC 4627 section 2.5:

Character	Replacement
U+0000 - U+001F	\u0000 - \u001F
Any other control characters	Encoded into its \uABCD equivalent escaped code point
"	\"
\	\\
For example, the pattern {"message": "%enc{%m}{JSON}"} could be used to output a valid JSON document containing the log message as a string value.

Using the CRLF encoding format, the following characters are replaced:

Character	Replacement
'\r', '\n'	Converted into escaped strings "\\r" and "\\n" respectively
equals{pattern}{test}{substitution}
equalsIgnoreCase{pattern}{test}{substitution}
Replaces occurrences of 'test', a string, with its replacement 'substitution' in the string resulting from evaluation of the pattern. For example, "%equals{[%marker]}{[]}{}" will replace '[]' strings produces by events without markers with an empty string.

The pattern can be arbitrarily complex and in particular can contain multiple conversion keywords.

ex|exception|throwable
{
  [ "none"
   | "full"
   | depth
   | "short"
   | "short.className"
   | "short.fileName"
   | "short.lineNumber"
   | "short.methodName"
   | "short.message"
   | "short.localizedMessage"]
}
  {filters(package,package,...)}
  {suffix(pattern)}
  {separator(separator)}
Outputs the Throwable trace bound to the logging event, by default this will output the full trace as one would normally find with a call to Throwable.printStackTrace().

You can follow the throwable conversion word with an option in the form %throwable{option}.

%throwable{short} outputs the first line of the Throwable.

%throwable{short.className} outputs the name of the class where the exception occurred.

%throwable{short.methodName} outputs the method name where the exception occurred.

%throwable{short.fileName} outputs the name of the class where the exception occurred.

%throwable{short.lineNumber} outputs the line number where the exception occurred.

%throwable{short.message} outputs the message.

%throwable{short.localizedMessage} outputs the localized message.

%throwable{n} outputs the first n lines of the stack trace.

Specifying %throwable{none} or %throwable{0} suppresses output of the exception.

Use {filters(packages)} where packages is a list of package names to suppress matching stack frames from stack traces.

Use {suffix(pattern)} to add the output of pattern at the end of each stack frames.

Use a {separator(...)} as the end-of-line string. For example: separator(|). The default value is the line.separator system property, which is operating system dependent.

F
file
Outputs the file name where the logging request was issued.

Generating the file information (location information) is an expensive operation and may impact performance. Use with caution.

highlight{pattern}{style}
Adds ANSI colors to the result of the enclosed pattern based on the current event's logging level. (See Jansi configuration.)

The default colors for each level are:

Level	ANSI color
FATAL	Bright red
ERROR	Bright red
WARN	Yellow
INFO	Green
DEBUG	Cyan
TRACE	Black (looks dark grey)
The color names are ANSI names defined in the AnsiEscape class.

The color and attribute names and are standard, but the exact shade, hue, or value.

Color table
Intensity Code	0	1	2	3	4	5	6	7
Normal	Black	Red	Green	Yellow	Blue	Magenta	Cyan	White
Bright	Black	Red	Green	Yellow	Blue	Magenta	Cyan	White
You can use the default colors with:

%highlight{%d [%t] %-5level: %msg%n%throwable}
You can override the default colors in the optional {style} option. For example:

%highlight{%d [%t] %-5level: %msg%n%throwable}{FATAL=white, ERROR=red, WARN=bright_blue, INFO=black, DEBUG=bright_green, TRACE=blue}
At the same time it is possible to use true colors (24 bit). For example:

%highlight{%d [%t] %-5level: %msg%n%throwable}{FATAL=white, ERROR=red, WARN=bg_#5792e6 fg_#eef26b bold, INFO=black, DEBUG=#3fe0a8, TRACE=blue}
You can highlight only the a portion of the log event:

%d [%t] %highlight{%-5level: %msg%n%throwable}
You can style one part of the message and highlight the rest the log event:

%style{%d [%t]}{black} %highlight{%-5level: %msg%n%throwable}
You can also use the STYLE key to use a predefined group of colors:

%highlight{%d [%t] %-5level: %msg%n%throwable}{STYLE=Logback}
The STYLE value can be one of:
Style	Description
Default	See above
Logback
Level	ANSI color
FATAL	Blinking bright red
ERROR	Bright red
WARN	Red
INFO	Blue
DEBUG	Normal
TRACE	Normal
K{key}
map{key}
MAP{key}
Outputs the entries in a MapMessage, if one is present in the event. The K conversion character can be followed by the key for the map placed between braces, as in %K{clientNumber} where clientNumber is the key. The value in the Map corresponding to the key will be output. If no additional sub-option is specified, then the entire contents of the Map key value pair set is output using a format {{key1,val1},{key2,val2}}

l
location
Outputs location information of the caller which generated the logging event.

The location information depends on the JVM implementation but usually consists of the fully qualified name of the calling method followed by the callers source the file name and line number between parentheses.

Generating location information is an expensive operation and may impact performance. Use with caution.

L
line
Outputs the line number from where the logging request was issued.

Generating line number information (location information) is an expensive operation and may impact performance. Use with caution.

m{ansi}
msg{ansi}
message{ansi}
Outputs the application supplied message associated with the logging event.

From Log4j 2.16.0, support for lookups in log messages has been removed for security reasons. Both the{lookups} and the {nolookups} options on the %m, %msg and %message pattern are now ignored. If either is specified a message will be logged.

Add {ansi} to render messages with ANSI escape codes (requires JAnsi, see configuration.)

The default syntax for embedded ANSI codes is:

@|code(,code)* text|@
For example, to render the message "Hello" in green, use:

@|green Hello|@
To render the message "Hello" in bold and red, use:

@|bold,red Warning!|@
You can also define custom style names in the configuration with the syntax:

%message{ansi}{StyleName=value(,value)*( StyleName=value(,value)*)*}%n
For example:

%message{ansi}{WarningStyle=red,bold KeyStyle=white ValueStyle=blue}%n
The call site can look like this:

logger.info("@|KeyStyle {}|@ = @|ValueStyle {}|@", entry.getKey(), entry.getValue());
M
method
Outputs the method name where the logging request was issued.

Generating the method name of the caller (location information) is an expensive operation and may impact performance. Use with caution.

marker	The full name of the marker, including parents, if one is present.
markerSimpleName	The simple name of the marker (not including parents), if one is present.
maxLen
maxLength
Outputs the result of evaluating the pattern and truncating the result. If the length is greater than 20, then the output will contain a trailing ellipsis. If the provided length is invalid, a default value of 100 is used.

Example syntax: %maxLen{%p: %c{1} - %m%notEmpty{ =>%ex{short}}}{160} will be limited to 160 characters with a trailing ellipsis. Another example: %maxLen{%m}{20} will be limited to 20 characters and no trailing ellipsis.

n
Outputs the platform dependent line separator character or characters.

This conversion character offers practically the same performance as using non-portable line separator strings such as "\n", or "\r\n". Thus, it is the preferred way of specifying a line separator.

N
nano
Outputs the result of System.nanoTime() at the time the log event was created.

pid{[defaultValue]}
processId{[defaultValue]}
Outputs the process ID if supported by the underlying platform. An optional default value may be specified to be shown if the platform does not support process IDs.

variablesNotEmpty{pattern}
varsNotEmpty{pattern}
notEmpty{pattern}
Outputs the result of evaluating the pattern if and only if all variables in the pattern are not empty.

For example:

%notEmpty{[%marker]}
%p|level{level=label, level=label, ...} p|level{length=n} p|level{lowerCase=true|false}
Outputs the level of the logging event. You provide a level name map in the form "level=value, level=value" where level is the name of the Level and value is the value that should be displayed instead of the name of the Level.

For example:

%level{WARN=Warning, DEBUG=Debug, ERROR=Error, TRACE=Trace, INFO=Info}
Alternatively, for the compact-minded:

%level{WARN=W, DEBUG=D, ERROR=E, TRACE=T, INFO=I}
More succinctly, for the same result as above, you can define the length of the level label:

%level{length=1}
If the length is greater than a level name length, the layout uses the normal level name.
You can combine the two kinds of options:

%level{ERROR=Error, length=2}
This give you the Error level name and all other level names of length 2.
Finally, you can output lower-case level names (the default is upper-case):

%level{lowerCase=true}
r
relative	Outputs the number of milliseconds elapsed since the JVM was started until the creation of the logging event.
R{string}{length}
repeat{string}{length}	Produces a string containing the requested number of instances of the specified string. For example, "%repeat{*}{2}" will result in the string "**".
replace{pattern}{regex}{substitution}
Replaces occurrences of 'regex', a regular expression, with its replacement 'substitution' in the string resulting from evaluation of the pattern. For example, "%replace{%msg}{\s}{}" will remove all spaces contained in the event message.

The pattern can be arbitrarily complex and in particular can contain multiple conversion keywords. For instance, "%replace{%logger %msg}{\.}{/}" will replace all dots in the logger or the message of the event with a forward slash.

rEx|rException|rThrowable
  {
    ["none" | "short" | "full" | depth]
    [,filters(package,package,...)]
    [,separator(separator)]
  }
  {ansi(
    Key=Value,Value,...
    Key=Value,Value,...
    ...)
  }
  {suffix(pattern)}
The same as the %throwable conversion word but the stack trace is printed starting with the first exception that was thrown followed by each subsequent wrapping exception.

The throwable conversion word can be followed by an option in the form %rEx{short} which will only output the first line of the Throwable or %rEx{n} where the first n lines of the stack trace will be printed.

Specifying %rEx{none} or %rEx{0} will suppress printing of the exception.

Use filters(packages) where packages is a list of package names to suppress matching stack frames from stack traces.

Use a separator string to separate the lines of a stack trace. For example: separator(|). The default value is the line.separator system property, which is operating system dependent.

Use rEx{suffix(pattern) to add the output of pattern to the output only when there is a throwable to print.

sn
sequenceNumber	Includes a sequence number that will be incremented in every event. The counter is a static variable so will only be unique within applications that share the same converter Class object.
style{pattern}{ANSI style}
Uses ANSI escape sequences to style the result of the enclosed pattern. The style can consist of a whitespace separated list of style names from the following table. (See Jansi configuration.)

Style Name	Description
Normal	Normal display
Bright	Bold
Dim	Dimmed or faint characters
Underline	Underlined characters
Blink	Blinking characters
Reverse	Reverse video
Hidden
Black or FG_Black	Set foreground color to black
Red or FG_Red	Set foreground color to red
Green or FG_Green	Set foreground color to green
Yellow or FG_Yellow	Set foreground color to yellow
Blue or FG_Blue	Set foreground color to blue
Magenta or FG_Magenta	Set foreground color to magenta
Cyan or FG_Cyan	Set foreground color to cyan
White or FG_White	Set foreground color to white
Default or FG_Default	Set foreground color to default (white)
BG_Black	Set background color to black
BG_Red	Set background color to red
BG_Green	Set background color to green
BG_Yellow	Set background color to yellow
BG_Blue	Set background color to blue
BG_Magenta	Set background color to magenta
BG_Cyan	Set background color to cyan
BG_White	Set background color to white
For example:

%style{%d{ISO8601}}{black} %style{[%t]}{blue} %style{%-5level:}{yellow} %style{%msg%n%throwable}{green}
You can also combine styles:

%d %highlight{%p} %style{%logger}{bright cyan} %C{1.} %msg%n
You can also use % with a color like %black, %blue, %cyan, and so on. For example:

%black{%d{ISO8601}} %blue{[%t]} %yellow{%-5level:} %green{%msg%n%throwable}
%T
%tid
%threadId	Outputs the ID of the thread that generated the logging event.
%t
%tn
%thread
%threadName	Outputs the name of the thread that generated the logging event.
%tp
%threadPriority	Outputs the priority of the thread that generated the logging event.
fqcn	Outputs the fully qualified class name of the logger.
endOfBatch	Outputs the EndOfBatch status of the logging event, as "true" or "false".
x
NDC	Outputs the Thread Context Stack (also known as the Nested Diagnostic Context or NDC) associated with the thread that generated the logging event.
X{key[,key2...]}
mdc{key[,key2...]}
MDC{key[,key2...]}
Outputs the Thread Context Map (also known as the Mapped Diagnostic Context or MDC) associated with the thread that generated the logging event. The X conversion character can be followed by one or more keys for the map placed between braces, as in %X{clientNumber} where clientNumber is the key. The value in the MDC corresponding to the key will be output.

If a list of keys are provided, such as %X{name, number}, then each key that is present in the ThreadContext will be output using the format {name=val1, number=val2}. The key/value pairs will be printed in the order they appear in the list.

If no sub-options are specified then the entire contents of the MDC key value pair set is output using a format {key1=val1, key2=val2}. The key/value pairs will be printed in sorted order.

See the ThreadContext class for more details.

u{"RANDOM" | "TIME"}
uuid	Includes either a random or a time-based UUID. The time-based UUID is a Type 1 UUID that can generate up to 10,000 unique ids per millisecond, will use the MAC address of each host, and to try to insure uniqueness across multiple JVMs and/or ClassLoaders on the same host a random number between 0 and 16,384 will be associated with each instance of the UUID generator Class and included in each time-based UUID generated. Because time-based UUIDs contain the MAC address and timestamp they should be used with care as they can cause a security vulnerability.
xEx|xException|xThrowable
  {
    ["none" | "short" | "full" | depth]
    [,filters(package,package,...)]
    [,separator(separator)]
  }
  {ansi(
    Key=Value,Value,...
    Key=Value,Value,...
    ...)
  }
  {suffix(pattern)}
The same as the %throwable conversion word but also includes class packaging information.

At the end of each stack element of the exception, a string containing the name of the jar file that contains the class or the directory the class is located in and the "Implementation-Version" as found in that jar's manifest will be added. If the information is uncertain, then the class packaging data will be preceded by a tilde, i.e. the '~' character.

The throwable conversion word can be followed by an option in the form %xEx{short} which will only output the first line of the Throwable or %xEx{n} where the first n lines of the stack trace will be printed. Specifying %xEx{none} or %xEx{0} will suppress printing of the exception.

Use filters(packages) where packages is a list of package names to suppress matching stack frames from stack traces.

Use a separator string to separate the lines of a stack trace. For example: separator(|). The default value is the line.separator system property, which is operating system dependent.

The ansi option renders stack traces with ANSI escapes code using the JAnsi library. (See configuration.) Use {ansi} to use the default color mapping. You can specify your own mappings with key=value pairs. The keys are:

Prefix
Name
NameMessageSeparator
Message
At
CauseLabel
Text
More
Suppressed
StackTraceElement.ClassName
StackTraceElement.ClassMethodSeparator
StackTraceElement.MethodName
StackTraceElement.NativeMethod
StackTraceElement.FileName
StackTraceElement.LineNumber
StackTraceElement.Container
StackTraceElement.ContainerSeparator
StackTraceElement.UnknownSource
ExtraClassInfo.Inexact
ExtraClassInfo.Container
ExtraClassInfo.ContainerSeparator
ExtraClassInfo.Location
ExtraClassInfo.Version
The values are names from JAnsi's Code class like blue, bg_red, and so on (Log4j ignores case.)

The special key StyleMapName can be set to one of the following predefined maps: Spock, Kirk.

As with %throwable, the %xEx{suffix(pattern) conversion will add the output of pattern to the output only if there is a throwable to print.

%	The sequence %% outputs a single percent sign.
