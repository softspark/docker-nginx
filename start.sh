#!/bin/bash

if [ -z "$SERVER_APP" ]; then
    SERVER_APP="app"
fi

if [ -z "$SERVER_PORT" ]; then
    SERVER_PORT="9000"
fi

if [ -z "$MAGE_MODE" ]; then
    MAGE_MODE="production"
fi

if [ -z "$MAGE_ROOT" ]; then
    MAGE_ROOT="/var/www/html"
fi

if [ -z "$ALLOW_ORIGIN" ]; then
    ALLOW_ORIGIN="*"
fi

if [ -z "$CLIENT_MAX_BODY_SIZE" ]; then
    CLIENT_MAX_BODY_SIZE="10M"
fi

if [ -z "$PROTOCOL" ]; then 
    if [ "$MAGE_MODE" = "production" ]; then
        PROTOCOL="HTTPS";
    else 
        PROTOCOL="HTTP";
    fi
fi

if [ -z "$NGINX_KEEPALIVE_TIMEOUT" ]; then
    NGINX_KEEPALIVE_TIMEOUT="65"
fi

if [ -z "$NGINX_WORKER_CONNECTIONS" ]; then
    NGINX_WORKER_CONNECTIONS="1024"
fi

sed -i 's=__server_app__='"$SERVER_APP"'=g' /etc/nginx/conf.d/default.conf
sed -i 's=__server_port__='"$SERVER_PORT"'=g' /etc/nginx/conf.d/default.conf
sed -i 's=__mage_mode__='"$MAGE_MODE"'=g' /etc/nginx/conf.d/default.conf
sed -i 's=__mage_root__='"$MAGE_ROOT"'=g' /etc/nginx/conf.d/default.conf
sed -i 's=__allow_origin__='"$ALLOW_ORIGIN"'=g' /etc/nginx/conf.d/default.conf
sed -i 's=__client_max_body_size__='"$CLIENT_MAX_BODY_SIZE"'=g' /etc/nginx/conf.d/default.conf
sed -i 's=__protocol__='"$PROTOCOL"'=g' /etc/nginx/conf.d/default.conf

sed -i 's=__nginx_keepalive_timeout__='"$NGINX_KEEPALIVE_TIMEOUT"'=g' /etc/nginx/nginx.conf
sed -i 's=__nginx_worker_connections__='"$NGINX_WORKER_CONNECTIONS"'=g' /etc/nginx/nginx.conf


nginx -g 'daemon off;'
