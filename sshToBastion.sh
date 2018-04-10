#!/bin/bash
if [[ $# -gt 0 && ${1} == "vw" ]]; then
edit ${0}
else

# S C R I P T  B E G I N

BASTION_NAME=${1}
PROFILE=${2}
SGID=`aws ec2 describe-instances --filters "Name=tag:Name,Values=${BASTION_NAME}" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].SecurityGroups[0].GroupId" --output text --profile ${PROFILE}`
CIDR=0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id ${SGID} --protocol tcp --port 22 --cidr ${CIDR} --profile ${PROFILE}
IP=`aws ec2 describe-instances --filters "Name=tag:Name,Values=${BASTION_NAME}" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PublicIpAddress" --output text --profile ${PROFILE}`
echo SSH to ${IP}
ssh -A ec2-user@${IP}
aws ec2 revoke-security-group-ingress --group-id ${SGID} --protocol tcp --port 22 --cidr ${CIDR} --profile ${PROFILE}

# S C R I P T  E N D

fi;
