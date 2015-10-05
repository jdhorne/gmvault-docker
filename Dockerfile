FROM alpine:latest

ENV GMVAULT_DIR /config
ENV GMVAULT_EMAIL_ADDR test@example.com
 
RUN apk add --update \
        bash \
        ca-certificates \
        python \
        py-pip \
    && pip install gmvault \
    && rm -rf /var/cache/apk/*
    
VOLUME /db /config
RUN mkdir /app
COPY gmvault.sh /app/gmvault.sh

WORKDIR /app

CMD ["/app/gmvault.sh"]
