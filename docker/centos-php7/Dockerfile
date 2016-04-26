FROM centos:7
MAINTAINER Semen Shestakov <shestakovsemen@gmail.com>

# https://www.digitalocean.com/community/tutorials/how-to-upgrade-to-php-7-on-centos-7
RUN curl 'https://setup.ius.io/' | bash
RUN yum remove -y php-fpm php-cli php-common

# https://github.com/docker/hub-feedback/issues/461
RUN yum install \
        httpd \
        mod_php70u \
        php70u-cli \
        php70u-common \
        php70u-dba \
        php70u-intl \
        php70u-json \
        php70u-mbstring \
        php70u-mysqlnd \
        php70u-pdo \
        php70u-xml \
    -y || true
RUN mkdir -p /var/www/html /var/log/httpd

RUN yum install -y less vim-tiny
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --filename=composer --install-dir=/usr/local/bin

# Apache2
ENV APACHE_LOG_DIR /var/log/httpd
ENV APP_DOCUMENT_ROOT /app/web

# https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-centos-7
ADD vhost.conf /etc/httpd/sites-available/000-default.conf
RUN set -xe;\
    echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf;\
    mkdir /etc/httpd/sites-enabled;\
    ln -s ../sites-available/000-default.conf /etc/httpd/sites-enabled/

EXPOSE 80
WORKDIR /app
VOLUME /app
CMD ["/usr/sbin/httpd", "-X"]
