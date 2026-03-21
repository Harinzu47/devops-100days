#!/bin/bash
# cron-health-check.sh — versi cron-friendly
set -euo pipefail

LOG_FILE="/home/harinzu/devops-100days/day06-cron/logs/health-$(date +%Y%m%d).log"
DISK_THRESHOLD=80
MEM_THRESHOLD=90

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"; }

log "=== Health Check Start ==="

DISK=$(/bin/df / | /usr/bin/awk 'NR==2 {print $5}' | /usr/bin/tr -d '%')
if [ "$DISK" -gt "$DISK_THRESHOLD" ]; then
    log "[WARN] Disk: ${DISK}% (threshold: ${DISK_THRESHOLD}%)"
else
    log "[OK] Disk: ${DISK}%"
fi

MEM=$(/usr/bin/free | /usr/bin/awk '/Mem:/ {printf "%.0f", $3/$2*100}')
if [ "$MEM" -gt "$MEM_THRESHOLD" ]; then
    log "[WARN] Memory: ${MEM}%"
else
    log "[OK] Memory: ${MEM}%"
fi

for svc in ssh cron; do
    if /usr/sbin/service "$svc" status &>/dev/null; then
        log "[OK] Service $svc: running"
    else
        log "[FAIL] Service $svc: NOT RUNNING"
    fi
done

log "=== Health Check Done ==="
