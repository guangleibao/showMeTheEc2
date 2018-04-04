#!/bin/bash
if [[ $# -gt 0 && ${1} == "vw" ]]; then
edit ${0}
else

# S C R I P T  B E G I N

# Terminate the AMZ Linux launched by waypointStart.sh
PROFILE=${1}
TAG=waypoint
KEY=${TAG}-${PROFILE}-key
WAYPOINT_ID=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" "Name=tag-key,Values=Name" "Name=tag-value,Values=${TAG}" --query "Reservations[*].Instances[*].InstanceId" --output text --profile ${PROFILE}`
echo "WAYPOINT_ID: ${WAYPOINT_ID}"

CID=`echo $WAYPOINT_ID | sed 's/ */#/g'`

if [ $CID = "#" ]; then
  echo "${TAG} was already gone."
else
  aws ec2 delete-key-pair --key-name ${KEY} --profile ${PROFILE}
  aws ec2 terminate-instances --instance-ids ${WAYPOINT_ID} --profile ${PROFILE}
  aws ec2 wait instance-terminated --instance-ids ${WAYPOINT_ID} --profile ${PROFILE}
fi


# S C R I P T  E N D

fi;
