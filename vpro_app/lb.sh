#!/bin/bash


lsb_release -a

if [ $? == 0 ]

then 

             echo "THIS IS DEBIAN"

#installing nginx
             echo "installing nginx"
             sudo apt-get install nginx -y
             sudo systemctl start nginx
             sudo systemctl enable nginx
             sudo systemctl status nginx


cat <<EOT > vproapp

upstream vproapp {

 server app01.com:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT
		cp -rf vproapp /etc/nginx/sites-available/

		rm -rf /etc/nginx/sites-enabled/default

		ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
                sudo systemctl restart nginx

#enable firewall

            echo "enable firewall"
           #sudo ufw enable
            sudo ufw allow 80/tcp
            sudo ufw status numbered

else



           echo "THIS IS REDHAT"

#nginx installation
         
          echo "nginx installation"
          sudo yum update
          sudo yum install epel-release -y
          sudo yum install nginx -y
          sudo systemcttl start nginx
          sudo systemctl enable nginx
          sudo yum install firewalld -y
          sudo systemctl start firewalld
		

cat <<EOT > vproapp

upstream vproapp {

 server app:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT

		mv vproapp /etc/nginx/sites-available/vproapp

		rm -rf /etc/nginx/sites-enabled/default

		ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp


#firewall enabiling
         echo"enable firewall"
         firewall-cmd --get-active-zones
         firewall-cmd --zone=public --add-port=80/tcp --permanent
         firewall-cmd --reload
         systemctl restart nginx

fi
