# Day 7: Linux SSH Authentication

## Konsep yang Dipelajari
- ssh-agent: simpan key di memori, ketik passphrase sekali
- ssh-add: tambah/hapus/list key di agent
- Agent forwarding: gunakan key lokal dari server remote
- Multiple keys: key berbeda untuk konteks berbeda
- ~/.ssh/config: manage banyak server dengan alias
- ProxyJump: SSH multi-hop via bastion/jump host
- SSH tunneling: local/remote/dynamic port forwarding

## Bukti Lab
- `ssh devops-lab` → Connected via id_ed25519 (explicit dari config)
- `ssh dev-work` → Connected via id_work (explicit dari config)
- Verbose output: "Offering public key... explicit" membuktikan IdentitiesOnly bekerja

## Command Penting
```bash
eval $(ssh-agent -s)           # start agent
ssh-add ~/.ssh/id_ed25519      # tambah key ke agent
ssh-add -l                     # list key di agent
ssh-add -t 8h ~/.ssh/id_key    # tambah key dengan timeout 8 jam
ssh -A user@bastion            # SSH dengan agent forwarding
ssh -J bastion user@private    # SSH via jump host
ssh -L 8080:localhost:80 host  # local port forward
ssh-keygen -R hostname         # hapus known_hosts entry
```

## SSH Config yang Dibuat
- `devops-lab` → localhost dengan id_ed25519
- `dev-work`   → localhost dengan id_work
- `bastion`    → contoh jump host dengan ForwardAgent
- `prod-web`   → contoh server private via ProxyJump bastion
- `github.com` → GitHub dengan id_ed25519
