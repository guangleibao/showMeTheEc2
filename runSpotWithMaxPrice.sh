#!/bin/bash
if [[ $# -gt 0 && ${1} == "vw" ]]; then
edit ${0}
else

# S C R I P T  B E G I N

# Version 1
# Spin up an AMZ Linux blindly, for cost control we use Spot instance with specified max price.
# Resources will use tag name `spot-<max-price>`, please make sure there is no confilict with your existing AWS resources.
# By default, please be aware of c4.large spot price, current suggestion is: 0.7 RMB/hr

PRICE=${1}
INSTANCE_TYPE=c4.large
TAG=spot-${PRICE}
PROFILE=${2}
WAYPOINT_SG=${TAG}-sg
KEY=${TAG}-${PROFILE}-key

echo "For price: ${PRICE}"

set -x

# Finding Waypoint
NO_WAYPOINT=`aws ec2 describe-instances --filters "Name=tag-key,Values=Name" "Name=tag-value,Values=${TAG}" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PublicIpAddress" --output text --profile ${PROFILE} | grep None | wc -l | sed -E 's/.*([[:digit:]]+).*/\1/g'`
if [ $NO_WAYPOINT -eq 1 ]; then
  aws ec2 delete-key-pair --key-name ${KEY} --profile ${PROFILE}
  DEFAULT_VPCID=`aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text --profile ${PROFILE}`
  DEFAULT_SUBNETID=`aws ec2 describe-subnets --filters "Name=vpc-id,Values=${DEFAULT_VPCID}" --query "Subnets[1].SubnetId" --output text --profile ${PROFILE}`
  WAYPOINT_SGID=`aws ec2 create-security-group --group-name ${WAYPOINT_SG} --vpc-id ${DEFAULT_VPCID} --description ${WAYPOINT_SG} --query "GroupId" --output text --profile ${PROFILE}`
  if [ $? = 255 ]; then
    echo "=> Waypoint security group exists, please ensure you think allowing inbound port 22 is ok for it."
    WAYPOINT_SGID=`aws ec2 describe-security-groups --filters "Name=group-name,Values=${WAYPOINT_SG}" --query "SecurityGroups[0].GroupId" --output text --profile ${PROFILE}`
  fi
  aws ec2 create-key-pair --key-name ${KEY} --query "KeyMaterial" --output text --profile ${PROFILE} > ~/temp/${KEY}.pem
  if [ $? = 255 ]; then
    echo "=> Key ${KEY} exists, please ensure you have access on ~/${KEY}.pem"
  else
    cat ~/temp/${KEY}.pem > ~/${KEY}.pem
  fi
  aws ec2 authorize-security-group-ingress --group-id ${WAYPOINT_SGID} --protocol tcp --port 22 --cidr 0.0.0.0/0 --profile ${PROFILE}
  if [ $? = 255 ]; then
    echo "=> port 22 is open for public already."
  fi
  AMIID=`aws ec2 describe-images --filters "Name=name,Values=*amzn-ami-hvm*gp2" "Name=architecture,Values=x86_64" "Name=hypervisor,Values=xen" "Name=owner-alias,Values=amazon" "Name=state,Values=available" "Name=virtualization-type,Values=hvm" --query "Images[*].ImageId" --profile ${PROFILE} | sed -En 's/^.*\"(ami-[[:xdigit:]]{1,})\".*$/\1/p' | sed -n 1p`
  echo "AMIID: ${AMIID}"
  ID=`aws ec2 run-instances \
       --image-id ${AMIID} \
       --key-name ${KEY} \
       --security-group-ids ${WAYPOINT_SGID} \
       --instance-type ${INSTANCE_TYPE} \
       --count 1 \
       --associate-public-ip-address \
       --subnet-id ${DEFAULT_SUBNETID} \
       --instance-market-options MarketType=spot,SpotOptions=\{MaxPrice=${PRICE},SpotInstanceType=one-time,InstanceInterruptionBehavior=terminate\} \
       --profile ${PROFILE} \
       --query "Instances[0].InstanceId" | sed s/\"//g`
  echo "Waypoint instance-id: ${ID}"
  aws ec2 wait instance-running --instance-ids ${ID} --profile ${PROFILE}
  aws ec2 describe-instances --instance-id ${ID} --profile ${PROFILE} --query "Reservations[0].Instances[0].PublicIpAddress" --output text
  aws ec2 create-tags --resources ${ID} --tags Key=Name,Value=${TAG} --profile ${PROFILE}
  echo "New instance tagged with Name:${TAG}." 
else 
  echo -n "=> ${TAG} already exists: "
  aws ec2 describe-instances --filters "Name=tag-key,Values=Name" "Name=tag-value,Values=${TAG}" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PublicIpAddress"  --output text --profile ${PROFILE}
  echo
fi
chmod 600 ~/${KEY}.pem

echo "Now you can SSH to it with: sshToSpot.sh ${PRICE} ${PROFILE}"

# S C R I P T  E N D

fi;
