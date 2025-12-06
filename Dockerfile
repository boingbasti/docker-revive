# Builder: nur nötig, wenn du extra Tools kompilieren willst, hier nicht nötig
FROM alpine:3.18 AS builder

# ---- Minimal benötigte Tools ----
RUN apk add --no-cache bash docker-cli

# Copy revive script
COPY revive.sh /usr/local/bin/revive.sh
RUN chmod +x /usr/local/bin/revive.sh

# Set default command
CMD ["/usr/local/bin/revive.sh"]
