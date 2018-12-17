#!/bin/bash

rm -rf pki/

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i .vagrant/machines/controller-1/virtualbox/private_key vagrant@10.11.0.11 "sudo chmod -R 777 /etc/kubernetes/pki && sudo cp -r /etc/kubernetes/pki /home/vagrant/pki && sudo chmod -R 600 /etc/kubernetes/pki"
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i .vagrant/machines/controller-1/virtualbox/private_key -r vagrant@10.11.0.11:pki pki/

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i .vagrant/machines/controller-2/virtualbox/private_key -r pki/ vagrant@10.11.0.12:pki
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i .vagrant/machines/controller-2/virtualbox/private_key vagrant@10.11.0.12 "sudo mkdir -p /etc/kubernetes/pki && sudo cp -r /home/vagrant/pki/* /etc/kubernetes/pki && sudo chmod -R 600 /etc/kubernetes/pki"
