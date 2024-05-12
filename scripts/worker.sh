sudo kubeadm join 192.168.100.10:6443 \
    --token jjqjxb.rlc42bg7hkp9f6s5 \
    --discovery-token-unsafe-skip-ca-verification \
    --cri-socket=unix:///var/run/crio/crio.sock
