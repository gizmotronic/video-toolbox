FROM gizmotronic/ccextractor

RUN apk update \
 && apk upgrade \
 && apk add --update ffmpeg

ENTRYPOINT
