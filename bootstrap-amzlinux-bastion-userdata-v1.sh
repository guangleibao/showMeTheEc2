#!/bin/bash

# USERDATA for AMZ Linux

REGION_CODE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//g'`

# Configure AWSCLI for ec2-user and root.
mkdir ~ec2-user/.aws
echo [default] > ~ec2-user/.aws/config
echo region = ${REGION_CODE} >> ~ec2-user/.aws/config
chown -R ec2-user:ec2-user ~ec2-user/.aws
mkdir ~/.aws
cp ~ec2-user/.aws/config ~/.aws/
chown root:root ~/.aws/config

# Configure CloudWatch Logs.
# Install utils mandantory and optionals.
yum -y install httpd awslogs links
service httpd restart
sed -i -e "s/region = us-east-1/region = ${REGION_CODE}/" /etc/awslogs/awscli.conf

echo " " >> /etc/awslogs/awslogs.conf
echo "# httpd configuration" >> /etc/awslogs/awslogs.conf
echo "[/var/log/httpd/access_log_bastion]" >> /etc/awslogs/awslogs.conf
echo "datetime_format = %d/%b/%Y:%H:%M:%S" >> /etc/awslogs/awslogs.conf
echo "file = /var/log/httpd/access_log" >> /etc/awslogs/awslogs.conf
echo "buffer_duration = 5000" >> /etc/awslogs/awslogs.conf
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.conf
echo "initial_position = start_of_file" >> /etc/awslogs/awslogs.conf
echo "log_group_name = /var/log/httpd/access_log_bastion" >> /etc/awslogs/awslogs.conf

echo " " >> /etc/awslogs/awslogs.conf
echo "# cloud-init configuration" >> /etc/awslogs/awslogs.conf
echo "[/var/log/cloud-init-output.log_bastion]" >> /etc/awslogs/awslogs.conf
echo "file = /var/log/cloud-init-output.log" >> /etc/awslogs/awslogs.conf
echo "buffer_duration = 5000" >> /etc/awslogs/awslogs.conf
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.conf
echo "initial_position = start_of_file" >> /etc/awslogs/awslogs.conf
echo "log_group_name = /var/log/cloud-init-output.log_bastion" >> /etc/awslogs/awslogs.conf

echo " " >> /etc/awslogs/awslogs.conf
echo "# messages configuration" >> /etc/awslogs/awslogs.conf
echo "[/var/log/messages_bastion]" >> /etc/awslogs/awslogs.conf
echo "file = /var/log/messages" >> /etc/awslogs/awslogs.conf
echo "buffer_duration = 5000" >> /etc/awslogs/awslogs.conf
echo "log_stream_name = {instance_id}" >> /etc/awslogs/awslogs.conf
echo "initial_position = start_of_file" >> /etc/awslogs/awslogs.conf
echo "log_group_name = /var/log/messages_bastion" >> /etc/awslogs/awslogs.conf

service awslogs restart

# Install utils.
yum -y install fio mlocate libffi-devel python-devel links openssl-devel gcc java-1.8.0-openjdk git libaio-devel wget autoconf automake readline readline-devel libtool docker
easy_install pip

# Docker setup.
usermod -a -G docker ec2-user
service docker start
chkconfig docker on
su - ec2-user -c "`aws ecr get-login --no-include-email --region ${REGION_CODE}`"
cd ~

# PG client.
yum -y install postgresql96

# MySQL.
yum -y install mysql57 mysql57-devel

cd ~ec2-user

# Redis client.
mkdir ~/redis
cd ~/redis
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make install
cd

# rlwrap.
mkdir ~/rlwrap
cd ~/rlwrap
git clone https://github.com/hanslub42/rlwrap.git
cd rlwrap
autoreconf --install
./configure
make install
cd

# VAR.
updatedb
LIBMYSQLCLIENT_PATH=`locate libmysqlclient.so | sed 's/\/libmysqlclient\..*//g' | uniq`
echo "export LD_LIBRARY_PATH=${LIBMYSQLCLIENT_PATH}" >> /home/ec2-user/.bashrc
echo "export LD_LIBRARY_PATH=${LIBMYSQLCLIENT_PATH}" >> ~/.bashrc
echo "export REGION_CODE=${REGION_CODE}" >> /home/ec2-user/.bashrc
echo "export REGION_CODE=${REGION_CODE}" >> ~/.bashrc

# Scripts.
echo -e '`aws ecr get-login --no-include-email --region ${REGION_CODE}`' > /home/ec2-user/ecrLogin.sh

# Scripts Permission.
chmod +x /home/ec2-user/*.sh
chown ec2-user:ec2-user /home/ec2-user/*.sh


# Utils.
# EC2
cd ~ec2-user
git clone https://github.com/guangleibao/showMeTheEc2.git
chown -R ec2-user:ec2-user showMeTheEc2
# Sysbench
cd ~
git clone https://github.com/akopytov/sysbench.git
cd ~/sysbench
git checkout 0.5
sleep 3
./autogen.sh
sleep 3
./configure
sleep 3
make && make install
# Redshift
git clone https://github.com/awslabs/amazon-redshift-utils.git
chown -R ec2-user:ec2-user amazon-redshift-utils

# Return home
cd ~

# Anti Virus
yum install -y clamav clamav-update clamd clamav-db
groupadd clamav
useradd -g clamav -s /bin/false -c "ClamAV" clamav
freshclam
touch /var/log/freshclam.log
chmod 600 /var/log/freshclam.log
chown clamav /var/log/freshclam.log
echo -e "ScanOnAccess yes\nOnAccessMountPath /\nOnAccessPrevention yes\nLocalSocket /var/run/clamd.scan/clamd.sock\nLogFile /var/log/clamd.log\n" > /etc/clamd.d/scan.conf
mkdir /var/run/clamd.scan/
chown clamav /var/run/clamd.scan/
chkconfig clamd.scan on
service clamd.scan start


