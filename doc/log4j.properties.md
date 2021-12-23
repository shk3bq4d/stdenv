https://logging.apache.org/log4j/2.x/

# CVE-2021-45105
fixed by log4j 2.17.0


# CVE-2021-44228
LOG4J_FORMAT_MSG_NO_LOOKUPS: "true"
https://mcas-proxyweb.mcas.ms/certificate-checker?login=false&originalUrl=https%3A%2F%2Fgithub.com.mcas.ms%2FNeo23x0%2Flog4shell-detector%3FMcasTsid%3D28375&McasCSRF=6b197ad6d78755470a1863ee40c4a42026a4e1740491092c8d72b121bbc6afc8

# CVE-2021-45046
fixed by log4j 2.16.0

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
