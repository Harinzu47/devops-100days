# Day 4: Script Execution Permissions & Bash Scripting

## Konsep yang Dipelajari
- Shebang: `#!/bin/bash` vs `#!/usr/bin/env bash`
- `chmod +x`, `chmod 755`, `chmod 700` untuk scripts
- `set -euo pipefail`: safety net wajib production
- Exit codes: 0=sukses, 1-255=error
- Fungsi, loop, kondisional, trap, heredoc
- Variable scope dengan `local`

## Scripts
| Script | Fungsi |
|--------|--------|
| `scripts/health-check.sh` | Monitor disk, memory, dan services |
| `scripts/backup.sh` | Backup direktori dengan rotasi otomatis |

## Cara Pakai
```bash
# Health check
bash scripts/health-check.sh

# Backup dengan rotasi 7 hari (default)
bash scripts/backup.sh /source /destination

# Backup dengan rotasi 3 hari
sudo bash scripts/backup.sh /etc/ssh /tmp/backup 3
```

## Pelajaran dari Error
- `trap cleanup_on_error ERR` terbukti bekerja: saat tar gagal karena
  permission denied, script otomatis cleanup file parsial
- `set -e` terbukti menghentikan script saat error, berbeda dengan
  script tanpa set -e yang terus lanjut meski ada kegagalan
