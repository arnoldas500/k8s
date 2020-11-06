# k8s
how to use xCITE kubernetes cluster 

# MAC users
If you have a mac you can directly access the cluster from your built in terminal without having to ssh onto the headnode
```
$ *brew install kubernetes-cli*
$ *scp -r username@169.226.59.--:/home/username/.kube ~/.kube*
$ *mkdir .certs && scp -r username@169.226.59.--:/home/username/.certs ~/*
```
