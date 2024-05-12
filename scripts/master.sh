sudo kubeadm config images pull \
    --cri-socket=unix:///var/run/crio/crio.sock \
    --image-repository=registry.aliyuncs.com/google_containers

sudo kubeadm init \
    --token=jjqjxb.rlc42bg7hkp9f6s5 \
    --apiserver-advertise-address=192.168.100.10 \
    --pod-network-cidr=10.244.0.0/16 \
    --cri-socket=unix:///var/run/crio/crio.sock \
    --image-repository=registry.aliyuncs.com/google_containers

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl create -f /vagrant/scripts/cni/kube-flannel.yml
