FROM alpine:3.21

# ---- Minimal benötigte Tools ----
RUN apk add --no-cache docker-cli

# Copy revive script
COPY revive.sh /usr/local/bin/revive.sh
RUN chmod +x /usr/local/bin/revive.sh

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD pgrep -f /usr/local/bin/revive.sh || exit 1

# Set default command
CMD ["/usr/local/bin/revive.sh"]
