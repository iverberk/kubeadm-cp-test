apt-get update && apt-get install -y apt-transport-https curl ca-certificates software-properties-common
apt-get remove docker docker-engine docker.io
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl docker-ce
apt-mark hold kubelet kubeadm kubectl

echo "KUBELET_EXTRA_ARGS=--resolv-conf=/run/systemd/resolve/resolv.conf" > /etc/default/kubelet
systemctl restart kubelet

kubeadm join 10.11.0.1:6443 --token abcdef.0123456789abcdef --apiserver-advertise-address 10.11.0.12 --node-name controller-2 --discovery-token-unsafe-skip-ca-verification=true --experimental-control-plane
