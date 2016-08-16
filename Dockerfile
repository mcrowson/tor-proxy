# run a tor socks proxy in a container
#
# docker run -d \
#	--restart always \
#	-v /etc/localtime:/etc/localtime:ro \
#	-p 9050:9050 \
# 	--name torproxy \
# 	jess/tor-proxy
#
FROM alpine:latest
MAINTAINER Jessica Frazelle <jess@docker.com>

RUN apk --no-cache add \
	--repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
	tor

# expose socks port
EXPOSE 9050

# copy in our torrc file
COPY torrc.default /etc/tor/torrc.default

# make sure files are owned by tor user
RUN chown -R tor /etc/tor

USER tor

ENTRYPOINT [ "tor" ]
CMD [ "-f", "/etc/tor/torrc.default" ]
