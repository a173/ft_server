#!/bin/bash

db_name='wp_base'
username='root'
hostname='localhost'

service mysql start
#skip password root
mysql -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='$username';"

# WordPress database
mysql -e "CREATE DATABASE $db_name;"
mysql -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$username'@'$hostname' WITH GRANT OPTION;"

#phpmyadmin database
mysql < /var/www/phpmyadmin/sql/create_tables.sql
