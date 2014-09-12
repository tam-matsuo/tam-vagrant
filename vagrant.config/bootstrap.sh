#!/bin/sh

# update
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm


# ntp, timezone
yum -y install ntp
/sbin/service ntpd start
/sbin/chkconfig ntpd on
cp -p /usr/share/zoneinfo/Japan /etc/localtime


# iptables
iptables -F
service iptables stop
chkconfig iptables off


# php
yum -y install --enablerepo=remi --enablerepo=remi-php55 php php-common php-opcache php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-gd php-bcmath
mv /etc/php.ini /etc/php.ini.org
cp /vagrant/vagrant.config/php.ini /etc/php.ini


# apache2
yum -y install httpd
cp /vagrant/vagrant.config/httpd.conf /etc/httpd/conf.d/vagrant.conf
mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.org
chkconfig httpd on


# mysql
yum -y install mysql-server phpMyAdmin
chkconfig mysqld on
/etc/rc.d/init.d/mysqld start
mysqladmin -f -u root drop test
mysqladmin -u root password 'mysql'

# phpmyadmin
mv /etc/httpd/conf.d/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf.org
cp /vagrant/vagrant.config/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf

# git
yum -y install git


# postgresql
yum -y install postgresql-server
service postgresql initdb --encoding=UTF8 --no-locale
mv /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf.org
cp /vagrant/vagrant.config/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf

/etc/init.d/postgresql start
chkconfig postgresql on

psql -c "ALTER USER postgres WITH PASSWORD 'postgres';" -d postgres -U postgres

# phpgadmin インストール
yum --enablerepo=remi,remi-php55 -y install phpPgAdmin
mv /etc/httpd/conf.d/phpPgAdmin.conf /etc/httpd/conf.d/phpPgAdmin.conf.org
cp /vagrant/vagrant.config/phpPgAdmin.conf /etc/httpd/conf.d/phpPgAdmin.conf

# phpgadmin アクセス設定
mv /etc/phpPgAdmin/config.inc.php /etc/phpPgAdmin/config.inc.php.org
cp /vagrant/vagrant.config/phpPgAdmin.config.inc.php /etc/phpPgAdmin/config.inc.php

#psql -U postgres -d postgres ALTER USER postgres WITH PASSWORD 'postgres'


# ToDo: xdebug
# ToDo: ssl


# services
service httpd start
