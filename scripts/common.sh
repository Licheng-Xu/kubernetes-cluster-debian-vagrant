# enable network forwarding
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

# modify apt sources and update softwares
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp /vagrant/scripts/apt/sources.list /etc/apt
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# [optional] install zstd vim htop net-tools
sudo apt-get install -y zstd vim htop net-tools

# install necessary softwares
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

# install cri-o kubelet kubeadm kubectl
curl -fsSL https://mirrors.ustc.edu.cn/kubernetes/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] http://mirrors.ustc.edu.cn/kubernetes/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://mirrors.ustc.edu.cn/kubernetes/addons:/cri-o:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] http://mirrors.ustc.edu.cn/kubernetes/addons:/cri-o:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/cri-o.list
sudo apt-get update
sudo apt-get install -y cri-o kubelet kubeadm kubectl
sudo apt-mark hold cri-o kubelet kubeadm kubectl

# modify pause image repository，start cri-o
sudo sed -i 's/\[crio\.image\]/[crio.image]\npause_image="registry.aliyuncs.com\/google_containers\/pause:3.9"/' /etc/crio/crio.conf.d/10-crio.conf
sudo systemctl start crio && sudo systemctl enable crio
