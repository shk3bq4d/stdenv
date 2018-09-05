https://us-east-2.console.aws.amazon.com/vpc/home?region=us-east-2# # VPC
https://gl.center/search?rangetype=relative&fields=message%2Csource&width=1420&highlightMessage=&relative=1209600&q=DescribeInstanceStatus
https://us-east-2.console.aws.amazon.com/cloudtrail/home?region=us-east-2#/events?StartTime=2018-08-19T22:00:00.000Z&EndTime=2018-08-21T06:00:00.000Z # logs events


# cloudwatch (CPU credits)
https://docs.gitlab.com/ee/user/project/integrations/prometheus_library/cloudwatch.html#configuring-prometheus-to-monitor-for-cloudwatch-metrics
https://github.com/prometheus/cloudwatch_exporter
https://forums.aws.amazon.com/thread.jspa?messageID=557913 # Check EC2 CPU Credit Balance Programatically?
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/t2-unlimited.html



https://aws.amazon.com/ec2/pricing/
spot instance # launched at AWS convenience, Amazon EC2 Spot instances allow you to request spare Amazon EC2 computing capacity for up to 90% off the On-Demand price
on-demand # With On-Demand instances, you pay for compute capacity by per hour or per second depending on which instances you run. No longer-term commitments or upfront payments are needed.
Reserved Instances # provide you with a significant discount (up to 75%) compared to On-Demand instance pricing. In addition, when Reserved Instances are assigned to a specific Availability Zone, they provide a capacity reservation, giving you additional confidence in your ability to launch instances when you need them. Best if you can commit to one year
Dedicated Hosts # A Dedicated Host is a physical EC2 server dedicated for your use. Can be purchased On-Demand (hourly).  Can be purchased as a Reservation for up to 70% off the On-Demand price. Useful for compliance or license requirement

# aws cli
source ~/env/kops_grey_bravo
venv.switch grey-ansible
aws ec2  describe-instances --region us-east-2
aws ec2  describe-instances --region us-east-2 --output text --query "Reservations[].Instances[].[PrivateIpAddress, Tags[?Key=='Name'].Value]"
aws ec2  describe-instances --region us-east-2 --output text --query "Reservations[].Instances[].[PrivateIpAddress, Tags[?Key=='Name'].Value]" | sed 'N;s/\n/ /'
