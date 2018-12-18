# Purpose

This is a test repo to debug kubeadm HA controlplane bootstrapping.

# Prerequisites

* Docker
* Vagrant / Virtualbox

# Instructions

1. Run ```create-controllers.sh```
2. Run ```copy-certs.sh``` (if it fails, try again, the SSH connection might take a while)
3. Run ```vagrant provision controller-2```
