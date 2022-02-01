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
