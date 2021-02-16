FROM alpine:latest

# Add curl
RUN apk add --update curl

# Launch updater script
COPY pinger.sh /
RUN ["chmod", "+x", "/pinger.sh"]
ENTRYPOINT ["sh","/pinger.sh"]