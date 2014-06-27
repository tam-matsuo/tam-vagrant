#!/bin/sh

# update
rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm


# ntp, timezone
yum -y install ntp
/sbin/service ntpd start
/sbin/chkconfig ntpd on
cp -p /usr/share/zoneinfo/Japan /etc/localtime


# php
yum -y install --enablerepo=remi --enablerepo=remi-php55 php php-opcache php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug


# apache2
rm /etc/httpd/conf/httpd.conf
ln -s /vagrant/vagrant.config/httpd.conf /etc/httpd/conf/httpd.conf
service httpd start
chkconfig httpd on


# mysql
yum -y install mysql-server
chkconfig mysqld on
/etc/rc.d/init.d/mysqld start
mysqladmin -f -u root drop test
mysqladmin -u root password 'mysql'

# phpmyadmin
yum -y install phpMyAdmin


# git
yum -y install git


# ToDo: xdebug
# ToDo: ssl
