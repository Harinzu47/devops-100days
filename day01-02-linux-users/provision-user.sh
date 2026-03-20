#!/bin/bash
# provision-user.sh - Automated user provisioning script
# Usage: provision-user.sh <username> <role: dev|devops|service>

set -euo pipefail

USERNAME=${1:?"Usage: $0 <username> <role>"}
ROLE=${2:?"Role required: dev | devops | service"}

if id "$USERNAME" &>/dev/null; then
     echo "[ERROR] User $USERNAME already exists"
     exit 1
fi

case "$ROLE" in
 dev)
     useradd -m -s /bin/bash -g developers "$USERNAME"
     chage -d 0 "$USERNAME"
     echo "[OK] Developer user $USERNAME created"
     ;;
 devops)
     useradd -m -s /bin/bash -g devops -G sudo "$USERNAME"
     echo "[OK] DevOps user $USERNAME created with sudo"
     ;;
 service)
     useradd -r -s /sbin/nologin -M "$USERNAME"
     echo "[OK] Service account $USERNAME created (no login)"
     ;;
 *)
     echo "[ERROR] Unknown role: $ROLE"; exit 1 ;;
esac
