FROM alpine

RUN apk add git alpine-sdk automake autoconf zlib-dev libevent-dev openssl-dev

RUN git clone --depth 1 https://git.torproject.org/tor.git

WORKDIR /tor

RUN ./autogen.sh
RUN ./configure --disable-asciidoc
RUN make -j 4
RUN make install

RUN echo "SocksPort 0.0.0.0:9150" > /usr/local/etc/tor/torrc

RUN adduser -s /bin/sh -D tor
USER tor

ENTRYPOINT [ "tor" ]
