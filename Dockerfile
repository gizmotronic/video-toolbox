FROM alpine:latest

WORKDIR /build

RUN apk update \
 && apk upgrade \
 && apk add --update \
        bash \
        alpine-sdk \
        autoconf \
        automake \
        coreutils \
        ffmpeg-dev \
        libtool \
        linux-headers \
        nasm

# libargtable2
RUN wget --no-check-certificate https://sourceforge.net/projects/argtable/files/argtable/argtable-2.13/argtable2-13.tar.gz \
 && zcat argtable2*tar.gz | tar xf - \
 && ( \
        cd argtable2-*/ \
        && ./configure --disable-shared --enable-static && make && make install \
    )

RUN git clone https://github.com/erikkaashoek/Comskip.git comskip \
 && ( \
        cd comskip \
        && ./autogen.sh \
        && ./configure \
        && make \
    )

FROM gizmotronic/ccextractor

RUN apk update \
 && apk upgrade \
 && apk add --update ffmpeg

COPY --from=0 /build/comskip/comskip /usr/local/bin

ENTRYPOINT
