#!/bin/bash

./k8s-api.sh

vagrant destroy -f
vagrant up controller-1
vagrant up controller-2 --no-provision
