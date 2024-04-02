#!/bin/bash

IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
sed -i "s#{{IP}}#${IPV4}#g" /var/www/html/index.php
