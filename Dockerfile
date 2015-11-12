FROM ubuntu:15.04

MAINTAINER Hussani Oliveira

WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y make autoconf bison re2c apache2-dev git wget libgmp-dev libcurl4-openssl-dev libmcrypt-dev libxml2-dev libjpeg-dev libjpeg62 libfreetype6-dev libmysqlclient-dev libgmp-dev libpspell-dev libicu-dev librecode-dev apache2 systemtap-sdt-dev pkg-config libssl-dev libz-dev zlib1g-dbg libbz2-dev libdb-dev libedit-dev libicu-dev libgdbm-dev unixodbc-dev libxslt-dev libldb-dev

WORKDIR /php7-binaries

RUN wget https://github.com/php/php-src/archive/master.tar.gz
RUN tar -zxvf master.tar.gz

WORKDIR /php7-binaries/php-src-master

RUN ./buildconf
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

RUN make && make install

RUN /usr/local/php7/7.0.0/bin/php -v
