FROM debian:jessie

MAINTAINER GLedoussal <contact@gwendal-ledoussal.fr>

WORKDIR /tmp

# Installing wget
RUN apt-get update && apt-get install -y wget

# Adding dotdeb mirror (Up to date php & apache2)
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.list && \
wget https://www.dotdeb.org/dotdeb.gpg && \
apt-key add dotdeb.gpg -y

# Installing packages
RUN apt-get update && \
apt-get install -q -y \
git \
curl \
apache2 \
libapache2-mod-php7.0 \
php7.0-cli \
php7.0-mysql \
php7.0-curl \
php7.0-mcrypt \
php7.0-zip \
php7.0-mbstring \
php7.0-xml

# Apache config
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
a2enmod rewrite && \
sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php/7.0/apache2/php.ini && \
echo ". /etc/environment" >> /etc/apache2/envvars

# Cloning project
RUN cd /srv && git clone https://github.com/GLedoussal/t412.git && cd t412 && bin/composer update

# Removing defaut apache virtualhost and moving ours
RUN rm /etc/apache2/sites-enabled/*
COPY config/t412-apache.conf /etc/apache2/sites-enabled

# Moving config files
COPY config/t412.class.php /srv/t412
COPY config/.htaccess /srv/t412
COPY config/config.sh /root
RUN chmod +x /root/config.sh

# Writing our env var in a file for apache to read them and starting apache
ENTRYPOINT /root/config.sh && service apache2 start && /bin/bash
EXPOSE 80 443
