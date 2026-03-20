#!/bin/bash
# backup.sh — Directory backup with rotation
# Usage: ./backup.sh <source_dir> <backup_dir> [keep_days]

set -euo pipefail

SOURCE_DIR=${1:?"Usage: $0 <source> <dest> [days]"}
BACKUP_DIR=${2:?"Backup destination required"}
KEEP_DAYS=${3:-7}
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/backup_${TIMESTAMP}.tar.gz"
LOG_FILE="logs/backup.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"; }

cleanup_on_error() {
    log "[ERROR] Backup gagal! Membersihkan file parsial..."
    rm -f "$BACKUP_FILE"
}
trap cleanup_on_error ERR

if [ ! -d "$SOURCE_DIR" ]; then
    log "[ERROR] Source tidak ditemukan: $SOURCE_DIR"
    exit 1
fi

mkdir -p "$BACKUP_DIR"

log "Memulai backup: $SOURCE_DIR → $BACKUP_FILE"
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"
SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
log "[OK] Backup selesai: $BACKUP_FILE ($SIZE)"

log "Menghapus backup lebih dari $KEEP_DAYS hari..."
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +"$KEEP_DAYS" -delete
log "[OK] Rotasi backup selesai"
