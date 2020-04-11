#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
sed -i "s#{{IP}}#$IP#g" /var/www/html/index.php
