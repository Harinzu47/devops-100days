# Day 6: Cron Jobs

## Konsep yang Dipelajari
- Cron syntax: 5 field (menit jam hari bulan hari-minggu)
- Karakter spesial: * , - / dan @reboot @daily
- User crontab vs system cron (/etc/cron.d/)
- Environment variables di cron (PATH, SHELL, MAILTO)
- Best practice: path absolut di script cron

## Cron Jobs yang Dibuat
| Jadwal | Perintah | Fungsi |
|--------|----------|--------|
| `*/5 * * * *` | cron-health-check.sh | Monitor server tiap 5 menit |
| `0 23 * * *` | backup.sh | Backup harian jam 23:00 |
| `30 0 * * 0` | find -delete | Bersihkan log > 30 hari tiap Minggu |

## Bukti Cron Berjalan
- 17:41:07 — dijalankan manual: ssh NOT RUNNING
- 17:45:04 — dijalankan OTOMATIS oleh cron: semua OK

## Command Penting
```bash
crontab -e                          # edit crontab
crontab -l                          # lihat crontab
sudo grep CRON /var/log/syslog      # debug cron
sudo systemctl list-timers --all    # lihat semua systemd timer
```
