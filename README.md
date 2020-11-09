# k8s
how to use xCITE kubernetes cluster 

# MAC users
If you have a mac you can directly access the cluster from your built in terminal without having to ssh onto the headnode
```
$ brew install kubernetes-cli
$ scp -r username@169.226.59.--:/home/username/.kube ~/.kube
$ mkdir .certs && scp -r username@169.226.59.--:/home/username/.certs ~/
```

# Linux users
Download the latest release and make executable
```
$ curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
$ chmod +x ./kubectl
```
Move the binary in to your PATH and test installation
```
$ sudo mv ./kubectl /usr/local/bin/kubectl
```

#Access cluster
Create a private key 
```
$ sudo openssl genrsa -out vanessa.key 2048
```
specify your username and group in the -subj section (CN is for the username and O for the group, email me if not sure of group you are in)
```
$ sudo openssl req -new -key username.key -out username.csr -subj "/CN=username/O=asrc"
```
###NOTE:
####If you are coming multiple groups
``` 
-subj "/CN=jean/O=$group1/O=$group2/O=$group3" 
```
####If error: Can't load /home/username/.rnd into RNG
Removing (or commenting out) RANDFILE = $ENV::HOME/.rnd from /etc/ssl/openssl.cnf

###Sign the CSR with the Kubernetes CA. Email me your .csr file to receive your .crt certificate for access!

Create a “.certs” directory, store the public and private key
```
$ mkdir .certs && mv username.crt username.key .certs
```
Create Kubernetes config file.
```
$ kubectl config set-credentials username --client-certificate=/home/username/.certs/username.crt  --client-key=/home/username/.certs/username.key
```
Create a context.
```
$ kubectl config set-context username-context --cluster=cluster.local --namespace=asrc --user=username
```
Namespace can be made custom if needed

In user account /home/username/.kube (mac users: /Users/username/.kube) edit config and add cluster (specifically “certificate-authority-data” and “server” variables, these variables will be emailed to you with the above .crt)

###test
```
$ kubectl --context=username-context get pods
```
