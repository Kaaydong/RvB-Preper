#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'

sudo apt-get update -y
sudo apt-get install apache2 apache2-utils -y
sudo systemctl enable apache2
sudo systemctl start apache2

status=$(sudo systemctl status | sed '2!d' | tr -d '[:space:]')

if [[ "$status" == "State:running" ]]; then

        echo -e "${RED}Apache2 Running${NC}"

else 

        echo -e "${RED}Apache2 Not Running${NC}" 
fi

sudo ufw allow in "Apache"

sudo apt-get install mysql-client mysql-server -y
sudo apt-get install mariadb-server mariadb-client -y
sudo mysql_secure_installation
sudo apt-get install php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml >
sudo systemctl restart apache2

sudo touch /var/www/html/info.php
sudo -- sh -c 'echo "<?php\nphpinfo();\n?>" > /var/www/html/info.php'

sudo wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo mysql -u root -p
