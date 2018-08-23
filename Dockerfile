FROM nginx:alpine
MAINTAINER justin.wilson@melbourneit.com.au

# I removed adding files for now, but I might need to use this to upload SSL certs to container?
#COPY files/ /etc/nginx/

EXPOSE 80 443

RUN apk update && apk upgrade

# send logs to stdout so they can be seen with docker lgos:
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# add git so we can download nginx config:
RUN apk add git
#RUN mkdir -v /data && git clone https://github.com/sudo-justinwilson/nginx-config.git /data
#RUN cp -v /data/conf.d/* /etc/nginx/conf.d/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off; error_log stderr info;"]
