#!/bin/sh
INTERVAL="${REVIVE_INTERVAL:-60}"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] [revive] starting with interval: ${INTERVAL}s"

while true; do
  for c in $(docker ps -a -q -f status=exited); do
    name=$(docker inspect -f "{{.Name}}" "$c" | sed "s|/||")
    auto_remove=$(docker inspect -f "{{.HostConfig.AutoRemove}}" "$c")
    if [ "$auto_remove" = "true" ]; then
      echo "[$(date '+%Y-%m-%d %H:%M:%S')] [revive] skipping auto-remove container: $name"
      continue
    fi
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [revive] restarting exited container: $name"
    docker start "$c" >/dev/null && echo "[$(date '+%Y-%m-%d %H:%M:%S')] [revive] -> started $name"
  done
  sleep "$INTERVAL"
done
