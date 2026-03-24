# Day 8: Install Ansible

## Konsep yang Dipelajari
- Ansible architecture: agentless, control node, managed nodes
- Inventory: INI format, groups, [all:vars]
- ansible.cfg: konfigurasi lokal project
- Playbook: YAML-based automation
- Modules: apt, service, file, copy, uri, debug
- Idempotency: run pertama changed=1, run berikutnya changed=0
- Check mode (--check): dry run sebelum apply
- Handlers: hanya jalan jika task berubah (notify)

## Bukti Idempotency
- Run 1: changed=1 (/opt/scripts dibuat)
- Run 2: changed=0 (semua sudah sesuai, tidak ada yang diubah)

## Playbooks
| File | Fungsi |
|------|--------|
| setup-server.yml | Install packages, buat dirs, set group |
| install-nginx.yml | Install nginx + config + index page + verify 200 |

## Command Penting
```bash
ansible all -m ping                     # test koneksi
ansible-inventory --graph               # lihat struktur inventory
ansible-playbook playbook.yml --check   # dry run
ansible-playbook playbook.yml -v        # verbose
ansible all -m shell -a "uptime"        # ad-hoc command
ansible all -m setup                    # kumpulkan facts server
```
