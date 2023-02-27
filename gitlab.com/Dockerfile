FROM alpine:3.15.1

RUN apk add nginx && \
    mkdir -p /usr/share/nginx/html
COPY ./template/default.conf /etc/nginx/http.d
COPY ./site/* /usr/share/nginx/html/
RUN chmod 0744 /usr/share/nginx/html/*
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
