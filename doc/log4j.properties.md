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
