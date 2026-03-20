# Day 1-2: Linux User Management

## Konsep yang Dipelajari
- User types: root (UID 0), system (1-999), regular (1000+)
- Non-interactive shell dengan /sbin/nologin
- File penting: /etc/passwd, /etc/shadow, /etc/group
- Permission octal: chmod 750, 770
- SGID bit pada directory (g+s)
- useradd, usermod, chage, chown, chmod

## Lab yang Dikerjakan
- Membuat 3 tipe user: developer, service account, devops+sudo
- Setup /opt/webapp/ dengan permission berbeda per subdirektori
- Membuktikan SGID inheritance: file di shared/ auto-inherit group developers
- Membuat automation script: provision-user.sh

## Bukti SGID Bekerja
```
shared/file-dari-webservice.txt  → group: developers  ← SGID inheritance
releases/file-di-releases.txt    → group: webservice   ← group default user
```

## Cara Pakai Script
```bash
sudo provision-user.sh <username> <dev|devops|service>

# Contoh:
sudo provision-user.sh budi dev
sudo provision-user.sh ani devops
sudo provision-user.sh nginx-svc service
```
