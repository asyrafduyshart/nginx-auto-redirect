FROM fabiocicerchia/nginx-lua:1.21.6-debian11.3-compat

# Install OpenSSL so we can generate SSL certs if needed
RUN apt-get update; apt-get install -y openssl

# Add nginx configuration and static HTML
RUN mkdir -p /etc/nginx/certs
ADD default.conf.template /etc/nginx/conf.d/default.conf.template
ADD blacklist.conf /etc/nginx/conf.d/blacklist.conf
ADD block_cf.conf /etc/nginx/conf.d/block_cf.conf


# Add entrypoint script for creating a self-signed certificate
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod a+x /usr/local/bin/entrypoint.sh

ADD anti_ddos_challange.lua.template /etc/nginx/anti_ddos_challenge.lua.template

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]