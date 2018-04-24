# Show Me The EC2 #

## NOTE
+ No production warranty!

## Prerequisites
+ A working AWS account.

+ MacOS or Linux with AWSCLI [installed](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

+ AWSCLI configured with profile names, for example:

		[profile virginia-aws]
		region = us-east-1

+ Writable 	`~/temp` folder exists under home directory. 

***CAUTION: Make sure that you don't have private key named `waypoint-<profilename>-key.pem` under home directory!!! Or it will be overwritten.***

## Scripts
+ **sshToPrivateIp.sh**
	- SSH into other EC2 by its private IP address using the default profile.
	- Usage: `sshToPrivateIp.sh <name-tag-value> <profile-name>`
+ **sshToBastion.sh**
	- Open SSH ingress on bastion security group and then SSH into it, and close the SSH ingress rule after your SSH session exited.
	- Prerequisites
		* The bastion server is linux, and the default user is ec2-user.
		* The bastion server must have tag key *Name* and the tag value is unqiue.
	- Usage: `sshToBastion.sh <bastion-name> <profile-name>`
+ **showMetadata.sh**
	- Run on EC2 Linux instance to fetch all metadata values. 
	- Usage: `showMetadata.sh`
+ **showUserdata.sh**
	- Run on EC2 Linux instance to fetch user-data if any.
	- Usage: `showUserdata.sh`
+ **waypointStartSpotHibernate.sh**
	- Spin up a new Amazon Linux EC2 spot instance without any preparation. Default type is C4.large, and the maximum price is capped by on-demand price. And it's SSHable.
	- The 
	- The script will:
		* Check or create an ec2 key pair.
		* Check or create security group
		* Check or create EC2 Amazon Linux instance in default VPC's default subnet.
		* Make the root volume of 150 GB in size.
		* The EC2 will use latest AMI.
	- Usage: `waypointStartSpotHibernate.sh <profile-name>`
	- Example: `waypointStartSpotHibernate.sh virginia-aws`
+ **waypointStartAws.sh**
	- Spin up a new Amazon Linux EC2 instance without any preparation. And it's SSHable.
	- The script will:
		* Check or create an ec2 key pair.
		* Check or create security group
		* Check or create EC2 Amazon Linux instance in default VPC's default subnet.
	- Usage: `waypointStartAws.sh <profile-name>`
	- Example: `waypointStartAws.sh virginia-aws`
+ **waypointStopAws.sh**
	- Terminate the EC2 instance which was started by `waypointStartAws.sh`
	- Usage: `waypointStopAws.sh <profile-name>`
	- Example: `waypointStopAws.sh virginia-aws`
+ **sshToWaypointAws.sh**
	- Usage: `sshToWaypointAws.sh <profile-name>`
	- Example: `sshToWaypointAws.sh virginia-aws`
+ **sshToWaypointSpotHibernate.sh**
	- Usage: `sshToWaypointSpotHibernate.sh <profile-name>`
	- Example: `sshToWaypointSpotHibernate.sh virginia-aws`