# ex: set ts=4 sw=4 expandtab:

template(name="gelf" type="list") {
    constant(value="{  \"version\":     \"1.1")
    constant(value="\",\"segmentation\":\"myteamname")
    constant(value="\",\"tag\":\"")           property(name="syslogtag")
    constant(value="\",\"filename\":\"")      property(name="$!metadata!filename")
    constant(value="\",\"host\":\"")          property(name="hostname")
    constant(value="\",\"short_message\":\"") property(name="msg" format="json")
    constant(value="\",\"timestamp\":\"")     property(name="timegenerated" dateformat="unixtimestamp")
    constant(value="\",\"level\":\"")         property(name="syslogseverity")
    constant(value="\"}")
}

module(load="omkafka")
ruleset(name="sendtokafka") {
    action(
        type="omkafka"
        broker=["192.168.168.118:9092",
                "192.168.168.115:9092",
                "192.168.168.109:9092"]
        topic="log.gelf.fsp" confParam="compression.codec=snappy"
        queue.dequeuebatchsize="1"
        key="unique_key_per_machine_ksonar-usb-staging.no-need-for-identifiable"
        template="gelf"
        )
}

module(load="imfile" PollingInterval="10")
input(type="imfile"
      File="/webapps/octopus/logs/octopus.main.log"
      Tag="octopus-staging"
      ruleset="sendtokafka"
        addMetadata="on"
        )

input(type="imfile"
      File="/tmp/graylog-debug.log"
      Tag="octopus-staging-debug"
      ruleset="sendtokafka"
        addMetadata="on"
        )

input(type="imfile"
      File="/tmp/kafka-heartbeat.log"
      Tag="heartbeat"
      ruleset="sendtokafka"
        addMetadata="on"
        )


action(type="omfwd" Target="p-infra-graylog-001.kaesse.net" Port="5514" Protocol="tcp" Device="eth0" TCP_Framing="octet-counted")
module(load="imfile" PollingInterval="10")
input(type="imfile"
        File="/var/log/jenkins/audit.log.0"
        Tag="mrjenkinstag"
        Severity="info"
        Facility="user"
        escapelf="off"
        readMode="2"
        PersistStateInterval="0"
    )
