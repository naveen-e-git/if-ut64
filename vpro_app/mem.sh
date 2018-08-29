#!/bin/bash


lsb_release -a

if [ $? == 0 ]

then

echo "THIS IS DEBIAN"

#install memcached

echo "install memcached"
sudo apt install memcached -y
sudo apt update -y


#enable firewall

#sudo ufw enable
sudo ufw allow 11211/tcp
sudo ufw status numbered

#<<<<<<<<<<<memcache installed>>>>>>>>>>>
else

echo "THIS IS REDHAT"

#adding repository and installing memcache	

   sudo	yum update
   sudo	yum install epel-release -y
   sudo	yum install memcached -y
   sudo	systemctl start memcached
   sudo	systemctl enable memcached
   sudo	systemctl status memcached

#<<<<<<<<firewall>>>>>>>
        
   sudo systemctl enable firewalld
   sudo systemctl start firewalld
   sudo systemctl status firewalld
   sudo	firewall-cmd --add-port=11211/tcp --permanent
   firewall-cmd --reload
fi
