#!/bin/bash
# health-check.sh — System health monitoring script
# Usage: ./health-check.sh [--json] [--quiet]

set -euo pipefail

# ── CONFIG ─────────────────────────────────────────────
DISK_THRESHOLD=80      # alert jika disk > 80%
MEM_THRESHOLD=90       # alert jika memory > 90%
LOG_FILE="logs/health-check.log"
SERVICES=("ssh" "cron")  # services yang dicek

# ── LOGGING ────────────────────────────────────────────
log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"; }
ok()  { log "[OK]    $*"; }
warn(){ log "[WARN]  $*"; }
fail(){ log "[FAIL]  $*"; }

# ── CHECKS ─────────────────────────────────────────────
check_disk() {
    local usage
    usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    if [ "$usage" -gt "$DISK_THRESHOLD" ]; then
        warn "Disk usage tinggi: ${usage}% (threshold: ${DISK_THRESHOLD}%)"
        return 1
    fi
    ok "Disk usage: ${usage}%"
}

check_memory() {
    local usage
    usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')
    if [ "$usage" -gt "$MEM_THRESHOLD" ]; then
        warn "Memory usage tinggi: ${usage}%"
        return 1
    fi
    ok "Memory usage: ${usage}%"
}

check_services() {
    for svc in "${SERVICES[@]}"; do
        if service "$svc" status &>/dev/null; then
            ok "Service $svc: running"
        else
            fail "Service $svc: NOT RUNNING"
        fi
    done
}

# ── MAIN ───────────────────────────────────────────────
main() {
    log "=== Health Check: $(hostname) ==="
    check_disk
    check_memory
    check_services
    log "=== Done ==="
}

main "$@"
