#!/bin/sh

yum update -y
yum install docker -y
#yum install httpd24 php70-mbstring.x86_64 php70-zip.x86_64 wget -y
service docker start
#service httpd start
chkconfig docker on
#chkconfig httpd on
usermod -a -G docker ec2-user
#usermod -a -G apache ec2-user
#chown -R ec2-user:apache /var/www
#chmod 2775 /var/www
#find /var/www -type d -exec sudo chmod 2775 {} \;
#find /var/www -type f -exec sudo chmod 0664 {} \;
#cd /var/www/html
#wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
#mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
#rm phpMyAdmin-latest-all-languages.tar.gz
cd /home/ec2-user
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
