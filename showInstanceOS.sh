PROFILE=${1}
echo
for i in `aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --filter "Name=instance-state-name,Values=running" --profile ${PROFILE} --output text`; do
	IMAGE_ID=`aws ec2 describe-instances --instance-ids ${i} --query "Reservations[0].Instances[0].ImageId" --output text`
	IMAGE_DESC=`aws ec2 describe-images --image-ids ${IMAGE_ID} --query "Images[0].Description" --output text`
	echo INSTANCE_ID:${i} IMAGE:${IMAGE_DESC}
done;
echo