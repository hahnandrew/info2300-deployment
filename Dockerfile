ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

WORKDIR /var/www/html

RUN apk add --no-cache \
  curl \
  nginx \
  php83 \
  php83-ctype \
  php83-dom \
  php83-fileinfo \
  php83-fpm \
  php83-gd \
  php83-intl \
  php83-mbstring \
  php83-mysqli \
  php83-opcache \
  php83-sqlite3 \
  php83-pdo \
  php83-pdo_sqlite \
  php83-openssl \
  php83-phar \
  php83-session \
  supervisor

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/conf.d /etc/nginx/conf.d/

ENV PHP_INI_DIR /etc/php83
COPY config/fpm-pool.conf ${PHP_INI_DIR}/php-fpm.d/www.conf
COPY config/php.ini ${PHP_INI_DIR}/conf.d/custom.ini

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

RUN ln -s /usr/bin/php83 /usr/bin/php

USER nobody

COPY --chown=nobody src/ /var/www/html/

EXPOSE 8080

# CMD ["php", "-S", "0.0.0.0:8080"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping || exit 1
