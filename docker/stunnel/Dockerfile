FROM alpine:edge

RUN apk add --no-cache stunnel libressl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["stunnel"]

