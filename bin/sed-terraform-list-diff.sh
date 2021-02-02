#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 06 Mar 2019
##

set -euo pipefail

# function usage() { sed -r -n -e "s/__SCRIPT__/$\(basename $0\)/" -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i in path: $PATH && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
#
ANSI_CODE='\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]'

if [[ -n ${VIMF6+1} ]]; then # && echo running from vim-f6
    cat - << 'EOF'
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place
Terraform will perform the following actions:
  + openstack_networking_secgroup_rule_v2.kaboom_capsule_server-all_ipv4
      id:                <computed>
      ethertype:         "IPv4"
      port_range_max:    <computed>
      port_range_min:    <computed>
      protocol:          <computed>
      region:            <computed>
      tenant_id:         <computed>
  + openstack_networking_secgroup_rule_v2.kaboom_capsule_server-all_ipv6
      id:                <computed>
      direction:         "egress"
      ethertype:         "IPv6"
      port_range_max:    <computed>
      port_range_min:    <computed>
      protocol:          <computed>
      region:            <computed>
      remote_group_id:   <computed>
      remote_ip_prefix:  <computed>
      tenant_id:         <computed>
  + openstack_networking_secgroup_rule_v2.kaboom_capsule_server-default_kaboom_http
      id:                <computed>
      direction:         "ingress"
      ethertype:         "IPv4"
      region:            <computed>
      remote_group_id:   <computed>
      remote_ip_prefix:  <computed>
      tenant_id:         <computed>
-/+ aws_lb_target_group_attachment.gl_tga[0] (new resource required)
      id:                                        "arn:aws:elasticloadbalancing:us-east-2:855885086634:targetgroup/hehabd/0e073284f4a98cb3-20180925202239309700000002" => <computed> (forces new resource)
      port:                                      "80" => "80"
      target_group_arn:                          "arn:aws:elasticloadbalancing:us-east-2:855885086634:targetgroup/hehabd/0e073284f4a98cb3" => "arn:aws:elasticloadbalancing:us-east-2:855885086634:targetgroup/hehabd/0e073284f4a98cb3"
      target_id:                                 "i-078cfe5df255142f7" => "${element(aws_instance.habog.*.id, count.index)}" (forces new resource)
-/+ aws_lb_target_group_attachment.gl_tga[1] (new resource required)
      id:                                        "arn:aws:elasticloadbalancing:us-east-2:855885086634:targetgroup/hehabd/0e073284f4a98cb3-20180925202239257300000001" => <computed> (forces new resource)
      port:                                      "80" => "80"
      target_group_arn:                          "arn:aws:elasticloadbalancing:us-east-2:855885086634:targetgroup/hehabd/0e073284f4a98cb3" => "arn:aws:elasticloadbalancing:us-east-2:855885086634:targetgroup/hehabd/0e073284f4a98cb3"
      target_id:                                 "i-053276a23e1fd63b6" => "${element(aws_instance.habog.*.id, count.index)}" (forces new resource)
  ~ aws_route53_record.hehab-ernal
      records.#:                                 "" => <computed>
  + aws_volume_attachment.mongo_slave_attach[1]
      id:                                        <computed>
      device_name:                               "/dev/xvdf"
      instance_id:                               "${element(aws_instance.mongo-slave.*.id, count.index)}"
      volume_id:
  - aws_volume_attachment.mongo_slave_attach[2]
  + openstack_networking_secgroup_rule_v2.kaboom_zabbix_proxy-zabbix
      id:                <computed>
      direction:         "ingress"
      ethertype:         "IPv4"
      port_range_max:    "11059"
      port_range_min:    "11059"
      protocol:          "tcp"
      region:            <computed>
      remote_group_id:   <computed>
      remote_ip_prefix:  "10.96.211.222/32"
      security_group_id: "8149109d-bf02-4469-8df5-d8ea9c8fafec"
      tenant_id:         <computed>
  ~ openstack_networking_secgroup_v2.kaboom_capsule_server
      description:       "Reserved for Katello capsule" => "kaboom capsules server security group"
  ~ openstack_networking_secgroup_v2.kaboom_default
      description:       "Default security group for ABC kaboom" => "kaboom default security group"
  ~ openstack_networking_secgroup_v2.kaboom_ssh_from_ABC
      description:       "Default SSH access from ABC kaboom" => "kaboom ssh from ABC"
  ~ openstack_networking_secgroup_v2.kaboom_ssh_from_ABC_public
      description:       "SSH access from SOC public IP" => "kaboom ssh from ABC public"
  ~ openstack_networking_secgroup_v2.kaboom_swan_vpn
      description:       "Reserved for swan VPN" => "kaboom swan svpn security group"
  ~ openstack_networking_secgroup_v2.kaboom_nagios_agent
      description:       "Access to nagios-agent" => "kaboom nagios"
  ~ openstack_networking_secgroup_v2.kaboom_nagios_proxy
      description:       "Access to nagios-proxy" => "kaboom nagios"
Plan: 139 to add, 7 to change, 0 to destroy.
Do you want to perform these actions?
EOF
else
    cat "$@"
fi | sed -r -n -e "/^( |$ANSI_CODE)*[+~\-]/ p"


