FROM ubuntu:15.04

MAINTAINER Hussani Oliveira

WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y make autoconf bison re2c apache2-dev git wget libgmp-dev libcurl4-openssl-dev libmcrypt-dev libxml2-dev libjpeg-dev libjpeg62 libfreetype6-dev libmysqlclient-dev libgmp-dev libpspell-dev libicu-dev librecode-dev

WORKDIR /php7-binaries

RUN pwd
RUN wget https://github.com/php/php-src/archive/master.tar.gz
RUN tar -zxvf master.tar.gz

WORKDIR /php7-binaries/php-src-master

RUN apt-get install -y make autoconf bison

RUN ls -la
RUN ./buildconf

RUN apt-get install -y systemtap-sdt-dev 
RUN apt-get install -y pkg-config
RUN apt-get install -y libssl-dev
RUN apt-get install -y libz-dev

RUN apt-get install -y zlib1g-dbg
RUN apt-get install -y libbz2-dev
RUN apt-get install -y libdb-dev
RUN apt-get install -y libedit-dev


RUN apt-get install -y mlocate
RUN apt-get install -y libicu-dev
RUN updatedb && locate libdb | grep -v php7-binaries

RUN apt-get install -y libgdbm-dev
RUN apt-get install -y unixodbc-dev
RUN apt-get install -y libxslt-dev
RUN apt-get install -y libldb-dev

#RUN ./configure 

 RUN ./configure \
     --prefix=/usr/local/php7/7.0.0 \
     --localstatedir=/usr/local/var \
     --sysconfdir=/usr/local/etc/php/7 \
     --with-config-file-path=/usr/local/etc/php/7 \
     --with-config-file-scan-dir=/usr/local/etc/php/7/conf.d \
     --mandir=/usr/local/php7/7.0.0/share/man \
     --enable-bcmath \
     --enable-calendar \
     --enable-exif \
     --enable-ftp \
     --enable-gd-native-ttf \
     --enable-intl \
     --enable-mbregex \
     --enable-mbstring \
     --enable-shmop \
     --enable-soap \
     --enable-sockets \
     --enable-sysvmsg \
     --enable-sysvsem \
     --enable-sysvshm \
     --enable-wddx \
     --enable-zip \
     --with-freetype-dir=/usr/local/opt/freetype \
     --with-gd \
     --with-gettext=/usr/local/opt/gettext \
     --with-iconv-dir=/usr \
     --with-icu-dir=/usr \
     --with-jpeg-dir=/usr/local/opt/jpeg \
     --with-kerberos=/usr \
     --with-libedit \
     --with-mhash \
     --with-openssl \
     --with-zlib \
     --with-apxs2=/usr/bin/apxs2 \
     --with-bz2 \
     --with-apxs2=/usr/bin/apxs2 \
     --enable-fpm \
     --with-fpm-user=_www \
     --with-fpm-group=_www \
     --disable-debug \
     --with-pdo-odbc=unixODBC,/usr \
     --with-png-dir=/usr \
     --libexecdir=/usr/local/php7/7.0.0/libexec \
     --with-curl \
     --with-xsl=/usr \
     --with-mysql-sock=/tmp/mysql.sock \
     --with-mysqli=mysqlnd \
     --with-pdo-mysql=mysqlnd \
     --enable-pcntl \
     --disable-opcache \
     --enable-dtrace \
     --disable-phpdbg \
     --enable-zend-signals
     
#     --with-ndbm=/usr \
#     --with-ldap-sasl=/usr \
#     --with-ldap \

RUN apt-get install -y apache2

RUN make && make install
RUN /usr/local/php7/7.0.0/bin/php -v


