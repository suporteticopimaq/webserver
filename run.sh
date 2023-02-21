#!/bin/sh

echo "root:$ROOT_PASSWORD" | chpasswd
echo "cd /var/www/html/" >> /root/.bashrc

service ssh start
service apache2 start

sleep infinity
