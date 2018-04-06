#!/bin/bash
if [[ $# -gt 0 && ${1} == "vw" ]]; then
edit ${0}
else

# S C R I P T  B E G I N

# ssh to AMZ Linux launched by waypointStartAws.sh

PROFILE=${1}
TAG=waypoint-hibernate
KEY=${TAG}-${PROFILE}-key
WAYPOINT_PUBLIC_IP=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" "Name=tag-key,Values=Name" "Name=tag-value,Values=${TAG}" --profile ${PROFILE} --query "Reservations[0].Instances[0].PublicIpAddress" --output text`
printf "Connecting to waypoint: ${WAYPOINT_PUBLIC_IP}\n"
ssh -i ~/${KEY}.pem ec2-user@${WAYPOINT_PUBLIC_IP}

# S C R I P T  E N D

fi;
