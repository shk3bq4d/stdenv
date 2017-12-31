docker run -d -p 8081:8080 plantuml/plantuml-server:jetty
http://http://localhost:8081
http://plantuml.com/

@startuml
Bob -> Alice : hello
@enduml


@startuml
artifact "logstash" {
	artifact ls_in_syslog
	artifact ls_in_gelf
	artifact ls_out_syslog
	artifact ls_out_gelf
}
artifact "kafka" {
	artifact k_syslog
	artifact k_gelf
}
artifact "graylog" {
	artifact g_syslog
	artifact g_gelf
}
ls_in_syslog --> ls_out_syslog
ls_in_gelf --> ls_out_gelf
ls_out_syslog --> k_syslog
k_syslog --> g_syslog
ls_out_gelf --> k_gelf
k_gelf --> g_gelf
@enduml


@startuml
artifact "logstash" {
	artifact ls_in_syslog
	artifact ls_in_gelf
	artifact ls_out_gelf
}
artifact "kafka" {
	artifact k_gelf
}
artifact "graylog" {
	artifact g_gelf
}
ls_in_syslog --> ls_out_gelf
ls_in_gelf --> ls_out_gelf
ls_out_gelf --> k_gelf
k_gelf --> g_gelf
@enduml
curl http://localhost:8081/svg/IomgoKnBJ2vHKCh9JoykIIpEK5Aevk9CX0dd5CTdviKNLnO3fJ64qrDpqb05yqjB8AArN71XfUp4jEn4L6EpCLMb5oLM0Yr1LPSEKuVi3WLTNJiKon2kmIO5OuFbe1Pd8qGWLW00 > a.svg
