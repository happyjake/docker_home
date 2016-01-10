FROM nginx:1.9
COPY servers.conf /etc/nginx/conf.d/servers.conf
COPY ssl.conf /etc/nginx/ssl.conf
COPY ssl_borg.conf /etc/nginx/ssl_borg.conf
RUN mkdir -p /etc/nginx/ssl
VOLUME /var/log/nginx /etc/nginx/ssl
