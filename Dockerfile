FROM ubuntu:14.04
MAINTAINER Gerald Fehringer <gfr@tiri.li>, tiri GmbH 2016

RUN apt-get update && \
apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /data/tiri.pot

WORKDIR /data/tiri.pot
RUN wget -nv https://github.com/gophish/gophish/releases/download/v0.1.2/gophish_linux_64bit.zip && \
unzip gophish_linux_64bit.zip && \
rm -f gophish_linux_64bit.zip

WORKDIR /data/tiri.pot/gophish_linux_64bit
RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json && \
chmod +x gophish

EXPOSE 3333 80
ENTRYPOINT ["./gophish"]


