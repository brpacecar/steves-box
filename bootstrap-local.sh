#!/bin/bash

# Setup Variables
mysql_root_password='password'
mysql_database='website'
mysql_user='webuser'
mysql_password='password'

# Update and setup repository
apt-add-repository -y ppa:ondrej/php  # ppa for php7
apt-get update

# Configure debconf
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password ${mysql_root_password}"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password ${mysql_root_password}"

# Install dependencies
apt-get install -y apache2 mysql-server-5.5 php7.0 php7.0-mbstring php7.0-zip git sendmail zip phantomjs ufw fail2ban redis-server

# setup user to own site files
useradd -d /var/www -s /usr/sbin/nologin webuser

mkdir - /var/www/app

# TODO finish setting up website stuff
# Setup and run composer
cd /usr/local/src/
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.2.0
php -r "unlink('composer-setup.php');"

# TODO finish setting up laravel
# setup laravel
composer global require "laravel/installer"

# TODO Setup apache config
a2enmod rewrite
echo '<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/app/public
    ErrorLog ${APACHE_LOG_DIR}/app_error.log
    CustomLog ${APACHE_LOG_DIR}/app_access.log combined
</VirtualHost>' > /etc/apache2/sites-available/website.conf
a2ensite website
a2dissite 000-default
service apache2 restart

# TODO Setup firewall
ufw allow ssh/tcp
ufw allow http/tcp
ufw allow https/tcp
ufw allow ftp/tcp
ufw --force enable

# TODO Setup ssh config to make sure direct root login is disabled
# TODO setup mysql database
mysql -uroot -p${mysql_root_password} -e "create database ${mysql_database}; create user ${mysql_user}@localhost identified by '${mysql_password}'; grant all privileges on ${mysql_database}.* to ${mysql_user}@localhost;"
