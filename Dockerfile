FROM alpine
ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/
RUN apk --no-cache add --virtual .build-dependencies git make g++ linux-headers wget ca-certificates libnl3-dev glib-dev \
 && mkdir -p /usr/src \
 && cd /usr/src \
 && git clone https://github.com/kotfenix/ndppd.git \
 && cd /usr/src/ndppd \
 && make \
 && make install \
 && cd / \
 && rm -rf /usr/src/ndppd \
 && apk del .build-dependencies \
 && apk -U upgrade \
 && apk add --update --no-cache openssl util-linux strongswan bash nftables iptables ip6tables libstdc++ libgcc \
 && rm -rf /var/cache/apk/* \
 && rm -f /etc/ipsec.secrets \
 && chmod +x /usr/bin/make-config.sh \
 && chmod +x /usr/bin/start-vpn.sh
VOLUME /etc /config
EXPOSE 500/udp 4500/udp
CMD /usr/bin/start-vpn.sh
