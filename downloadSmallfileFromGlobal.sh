# Don't run this script, it's private, permission will be denied.
rm -f small-file
time aws s3 cp s3://bgl-virginia/small-file . --region us-east-1
rm -f small-file
time aws s3 cp s3://bgl-ohio/small-file . --region us-east-2
rm -f small-file
time aws s3 cp s3://bgl-california/small-file . --region us-west-1
rm -f small-file
time aws s3 cp s3://bgl-oregon/small-file . --region us-west-2
rm -f small-file
time aws s3 cp s3://bgl-ireland/small-file . --region eu-west-1
rm -f small-file
time aws s3 cp s3://bgl-london/small-file . --region eu-west-2
rm -f small-file
time aws s3 cp s3://bgl-paris/small-file . --region eu-west-3
rm -f small-file
time aws s3 cp s3://bgl-frankfurt/small-file . --region eu-central-1
rm -f small-file
time aws s3 cp s3://bgl-mumbai/small-file . --region ap-south-1
rm -f small-file
time aws s3 cp s3://bgl-singapore/small-file . --region ap-southeast-1
rm -f small-file
time aws s3 cp s3://bgl-sydney/small-file . --region ap-southeast-2
rm -f small-file
time aws s3 cp s3://bgl-tokyo/small-file . --region ap-northeast-1
rm -f small-file
time aws s3 cp s3://bgl-seoul/small-file . --region ap-northeast-2
rm -f small-file
time aws s3 cp s3://bgl-sanpaulo/small-file . --region sa-east-1
rm -f small-file
time aws s3 cp s3://bgl-canada/small-file . --region ca-central-1

rm -f small-file
time aws s3 cp s3://bgl-beijing/small-file . --profile cs3 --region cn-north-1
rm -f small-file
time aws s3 cp s3://bgl-ningxia/small-file . --profile cs3 --region cn-northwest-1
