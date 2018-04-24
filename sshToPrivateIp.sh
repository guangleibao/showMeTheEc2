#!/bin/bash
if [[ $# -gt 0 && ${1} == "vw" ]]; then
	edit ${0}
else
echo 
# S C R I P T  B E G I N

NAME=${1}

IP=`aws ec2 describe-instances --filters "Name=tag:Name,Values=${NAME}" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text`
echo SSH to ${IP}
ssh -A ec2-user@${IP}

# S C R I P T  E N D
echo
fi;