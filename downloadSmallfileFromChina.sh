# Don't run this script, it's private, permission will be denied.

rm -f small-file
echo "time aws s3 cp s3://bgl-beijing/small-file . --region cn-north-1"
time aws s3 cp s3://bgl-beijing/small-file . --region cn-north-1
rm -f small-file
echo "time aws s3 cp s3://bgl-ningxia/small-file . --region cn-northwest-1"
time aws s3 cp s3://bgl-ningxia/small-file . --region cn-northwest-1

rm -f small-file
echo "time aws s3 cp s3://bgl-virginia/small-file . --profile gs3 --region us-east-1"
time aws s3 cp s3://bgl-virginia/small-file . --profile gs3 --region us-east-1
rm -f small-file
echo "time aws s3 cp s3://bgl-ohio/small-file . --profile gs3 --region us-east-2"
time aws s3 cp s3://bgl-ohio/small-file . --profile gs3 --region us-east-2
rm -f small-file
echo "time aws s3 cp s3://bgl-california/small-file . --profile gs3 --region us-west-1"
time aws s3 cp s3://bgl-california/small-file . --profile gs3 --region us-west-1
rm -f small-file
echo "time aws s3 cp s3://bgl-oregon/small-file . --profile gs3 --region us-west-2"
time aws s3 cp s3://bgl-oregon/small-file . --profile gs3 --region us-west-2
rm -f small-file
echo "time aws s3 cp s3://bgl-ireland/small-file . --profile gs3 --region eu-west-1"
time aws s3 cp s3://bgl-ireland/small-file . --profile gs3 --region eu-west-1
rm -f small-file
echo "time aws s3 cp s3://bgl-london/small-file . --profile gs3 --region eu-west-2"
time aws s3 cp s3://bgl-london/small-file . --profile gs3 --region eu-west-2
rm -f small-file
echo "time aws s3 cp s3://bgl-paris/small-file . --profile gs3 --region eu-west-3"
time aws s3 cp s3://bgl-paris/small-file . --profile gs3 --region eu-west-3
rm -f small-file
echo "time aws s3 cp s3://bgl-frankfurt/small-file . --profile gs3 --region eu-central-1"
time aws s3 cp s3://bgl-frankfurt/small-file . --profile gs3 --region eu-central-1
rm -f small-file
echo "time aws s3 cp s3://bgl-mumbai/small-file . --profile gs3 --region ap-south-1"
time aws s3 cp s3://bgl-mumbai/small-file . --profile gs3 --region ap-south-1
rm -f small-file
echo "time aws s3 cp s3://bgl-singapore/small-file . --profile gs3 --region ap-southeast-1"
time aws s3 cp s3://bgl-singapore/small-file . --profile gs3 --region ap-southeast-1
rm -f small-file
echo "time aws s3 cp s3://bgl-sydney/small-file . --profile gs3 --region ap-southeast-2"
time aws s3 cp s3://bgl-sydney/small-file . --profile gs3 --region ap-southeast-2
rm -f small-file
echo "time aws s3 cp s3://bgl-tokyo/small-file . --profile gs3 --region ap-northeast-1"
time aws s3 cp s3://bgl-tokyo/small-file . --profile gs3 --region ap-northeast-1
rm -f small-file
echo "time aws s3 cp s3://bgl-seoul/small-file . --profile gs3 --region ap-northeast-2"
time aws s3 cp s3://bgl-seoul/small-file . --profile gs3 --region ap-northeast-2
rm -f small-file
echo "time aws s3 cp s3://bgl-sanpaulo/small-file . --profile gs3 --region sa-east-1"
time aws s3 cp s3://bgl-sanpaulo/small-file . --profile gs3 --region sa-east-1
rm -f small-file
echo "time aws s3 cp s3://bgl-canada/small-file . --profile gs3 --region ca-central-1"
time aws s3 cp s3://bgl-canada/small-file . --profile gs3 --region ca-central-1
