# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acaryn <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/23 15:36:04 by acaryn            #+#    #+#              #
#    Updated: 2020/11/25 17:29:32 by acaryn           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install nginx mariadb-server
RUN apt-get -y install php-fpm php-mysql
RUN apt-get -y install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

RUN apt-get -y install wget
RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
RUN mv wordpress/ /var/www/wp
COPY ./srcs/wp-config.php /var/www/wp
RUN chown -R www-data:www-data /var/www/wp && find /var/www/wp -type d -exec chmod 775 {} + && find /var/www/wp -type f -exec chmod 664 {} +
RUN chmod 660 /var/www/wp/wp-config.php

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && tar -xzvf phpMyAdmin-5.0.4-all-languages.tar.gz && rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages /var/www/phpmyadmin
RUN mkdir -p /var/www/phpmyadmin/tmp && chown www-data:www-data /var/www/phpmyadmin/tmp && chmod 700 /var/www/phpmyadmin/tmp
COPY ./srcs/config.inc.php /var/www/phpmyadmin

COPY ./srcs/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled
COPY ./srcs/db.sh .
RUN bash db.sh && rm -rf db.sh
COPY ./srcs/ssl.sh .
RUN bash ssl.sh && rm -rf ssl.sh
COPY ./srcs/autoindex.sh .
COPY ./srcs/start.sh .

EXPOSE 80 443
CMD bash start.sh
