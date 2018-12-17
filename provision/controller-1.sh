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

cat <<EOF > /etc/kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: InitConfiguration
bootstrapTokens:
- ttl: 60m
  token: abcdef.0123456789abcdef
nodeRegistration:
  name: controller-1
  kubeletExtraArgs:
    node-ip: 10.11.0.11
    hostname-override: controller-1
localAPIEndpoint:
  advertiseAddress: 10.11.0.11
---
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: 1.13.1
clusterName: kubernetes
useHyperKubeImage: true
apiServer:
  certSANs:
  - "10.11.0.1"
  extraArgs:
    advertise-address: 10.11.0.11
controlPlaneEndpoint: "10.11.0.1:6443"
networking:
  podSubnet: "10.200.0.0/16"
EOF

echo "KUBELET_EXTRA_ARGS=--resolv-conf=/run/systemd/resolve/resolv.conf" > /etc/default/kubelet
systemctl restart kubelet

kubeadm init --config /etc/kubeadm-config.yaml
