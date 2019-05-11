FROM alpine:latest

# Install runtime dependencies. The versions are pinned for reproducible,
# deterministic, pure builds.
ENV DNS 8.8.8.8
ADD ./dockerentry /
RUN apk --update add openvpn && \
	chmod 500 /dockerentry

# Ensure that openvpn was initialized and still running
HEALTHCHECK --interval=10s --timeout=15s \
  CMD if [ -f /vpn/up ] && ps -a | grep openvpn | grep -v grep > /dev/null; then exit 0; else exit 1; fi;

# This is where the configuration files will go.
VOLUME [ "/vpn/config" ]

CMD [ "/dockerentry" ]
