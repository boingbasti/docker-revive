# Revive - Minimalist Docker Container Watcher

Revive automatically monitors all **stopped Docker containers** on your host and restarts them. Perfect for ensuring critical services always stay running.

---

## Features

- Minimal, multi-architecture container (~37 MB)
- Monitors **all containers** with status `exited`
- Automatically restarts stopped containers
- Logs only on restarts, with date & time
- Built-in healthcheck
- Multi-arch support: `amd64`, `arm64`, `arm/v7`
- Configurable check interval via environment variable

---

## Usage

### Docker CLI

```bash
docker run -d \
  --name revive \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -e REVIVE_INTERVAL=60 \
  boingbasti/revive:latest
```

- `REVIVE_INTERVAL` – interval in seconds to check for stopped containers (default: 60s); must be a positive integer — invalid values are ignored and fall back to 60s

---

### Docker Compose / Portainer Stack

```yaml
version: "3.9"

services:
  revive:
    image: boingbasti/revive:latest
    container_name: docker-revive
    restart: always
    environment:
      - REVIVE_INTERVAL=60
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
```

---

## Logging

- Logs are printed **only when a stopped container is restarted**
- Timestamps in format `YYYY-MM-DD HH:MM:SS`

---

## License

- MIT License, open source

