# Show Me The EC2 #

## Prerequisites
+ An working AWS account.

+ MacOS or Linux with AWSCLI [installed](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

+ AWSCLI configured with profile names, for example:

		[profile virginia-aws]
		region = us-east-1

+ Writable 	`~/temp` folder exists under home directory. 

***CAUTION: Make sure that you don't have private key named `waypoint-<profilename>-key.pem` under home directory!!! Or it will be overwritten.***

## Scripts
+ **showMetadata.sh**
	- Run on EC2 Linux instance to fetch all metadata values. 
	- Usage: `showMetadata.sh`
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