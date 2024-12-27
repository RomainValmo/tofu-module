# tofu-module
This is a great place to get modules for tofu. - tofu is a fork of terraform -


# How it's work? 

At first, you must install tofu. 

It's availaible at this place [here](https://opentofu.org/docs/intro/install/)

After if you are used with Terraform , the most of command are similiar 

# What modules are availaible ? 

1. Create a Kubernetes cluster on GCP provider. 

Can be used to create a dev or trainning. Not be used from scratch to prod Env.

    Contain: Masternode(desired number), Workernode(desired number), network and subnetwork (used by k8s), and install script for Masternode and Wokernode with Kubeadm,Kube-dashboard, Falco, and cilium