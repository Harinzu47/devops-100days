# Day 3: Secure Root SSH Access

## Yang Dipelajari
- Kriptografi asimetris: public/private key pair
- Perbedaan Ed25519 vs RSA 4096
- Anatomy /etc/ssh/sshd_config
- Defence in depth: 6 layer SSH hardening
- fail2ban: log monitoring + auto-ban brute force

## Hardening yang Diterapkan
| Directive | Value | Alasan |
|---|---|---|
| PermitRootLogin | no | Root tidak bisa SSH langsung |
| PasswordAuthentication | no | Wajib key-based auth |
| PubkeyAuthentication | yes | Aktifkan key auth |
| MaxAuthTries | 3 | Batasi percobaan login |
| LoginGraceTime | 30 | Timeout autentikasi |
| X11Forwarding | no | Matikan fitur tidak perlu |
| AllowUsers | harinzu | Whitelist user |

## Hasil Verifikasi
- Key-based SSH login: BERHASIL
- Root login via SSH: DITOLAK (Permission denied publickey)
- Banner peringatan: AKTIF
- fail2ban jail sshd: AKTIF, monitoring 0 banned IP

## File Penting
- `sshd_config.hardened` — konfigurasi setelah hardening
- `sshd_config.original` — backup config asli
- `fail2ban-jail.local` — konfigurasi fail2ban
- `banner.txt` — banner legal warning

## Command Penting
```bash
sudo sshd -t                          # test syntax sebelum restart
ssh -i ~/.ssh/id_ed25519 user@host    # SSH dengan key spesifik
sudo fail2ban-client status sshd      # cek status ban
sudo fail2ban-client unban <IP>       # unban IP manual
```
