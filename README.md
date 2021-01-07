# k8s
how to use xCITE kubernetes cluster 

## MAC users
If you have a mac you can directly access the cluster from your built in terminal without having to ssh onto the headnode
```
$ brew install kubernetes-cli
$ scp -r username@169.226.59.--:/home/username/.kube ~/.kube
```

## Linux users
Download the latest release and make executable
```
$ curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
$ chmod +x ./kubectl
```
Move the binary in to your PATH and test installation
```
$ sudo mv ./kubectl /usr/local/bin/kubectl
```

## Access cluster
Create a private key 
```
$ sudo openssl genrsa -out username.key 2048
```
specify your username and group in the -subj section (CN is for the username and O for the group, email me if not sure of group you are in)
```
$ sudo openssl req -new -key username.key -out username.csr -subj "/CN=username/O=asrc"
```
### NOTE:
#### If you are coming multiple groups
``` 
-subj "/CN=jean/O=$group1/O=$group2/O=$group3" 
```
#### If error: Can't load /home/username/.rnd into RNG
Removing (or commenting out) RANDFILE = $ENV::HOME/.rnd from /etc/ssl/openssl.cnf

### Sign the CSR with the Kubernetes CA. Email me your .csr file to receive your .crt certificate for access!

Create a “.certs” directory, store the public and private key
```
$ mkdir .certs && mv username.crt username.key .certs
$ chown -R username: /home/username/.certs
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

### test
```
$ kubectl --context=username-context get pods
```

### Monitor and edit your jobs, deployments and resources using Lens
Mac users:
```
$ brew cask install lens
```
Releases for windows and linux platforms: 
https://github.com/lensapp/lens/releases/tag/v3.6.9

### Lens
click on the big plus botton on the left menu to add a cluster. Select your kubeconfig file from the instructions above:
```
Mac:
/Users/<user>/.kube/config
```
Linux:
```
/home/<user>/.kube/config
```
Next select your contexts from the dropdown that you will use (you can select multiple)
```
Add cluster(s)
```
You can now see your added clusters for each context on the left side menu

## Usage:
### CMD run:
```
$ kubectl run gpu-test --rm -t -i --restart=Never --image=akurbanovas/od_tf1:v1 --limits=nvidia.com/gpu=1 -- nvidia-smi
```

### Run and execute python file with args
```
$ kubectl run gpu-job --rm -t -i --restart=Never --image=akurbanovas/od_tf1:v1 --limits=nvidia.com/gpu=1 -- python "train.py --logtostderr --train_dir=training/ --pipeline_config_path=training/ssd_mobilenet_v1_pets.config"
```

### Convert run into manifest file and save to pod.yaml
```
kubectl run gpu-job --restart=Never --image=akurbanovas/od_tf1:v1 --limits=nvidia.com/gpu=1 python "train.py --logtostderr --train_dir=training/ --pipeline_config_path=training/ssd_mobilenet_v1_pets.config" --dry-run -o yaml > pod.yaml
```

### Get commands with basic output
```
kubectl get services                 # List all services in the namespace
kubectl get pods --all-namespaces    # List all pods in all namespaces
kubectl get pods -o wide             # List all pods in the namespace, with more details
kubectl get deployment my-dep        # List a particular deployment
```

### Describe commands with verbose output
```
kubectl describe nodes <node-name>
kubectl describe pods <pod-name>
```

### Deleting Resources
```
kubectl delete <pod-name>
kubectl delete -f ./pod.yaml                   # Delete a pod using the type and name specified in pod.yaml
```

### Get into the bash console of one of your pods:
```
kubectl exec -it <pod-name> — /bin/bash
```

### Get current namespace and switch namespace using kubens
```
kubectl ns
kubectl ns <namespace-name>
```

### Get current context and switch context using kubectx
```
kubectl ctx
kubectl ctx <context-name>
```
### Forward a local port to a port in a Pod 
Note: make sure to sepcify containerPort in yaml file ( can use this for services too)
```
kubectl port-forward pod-name 7000:6379
```
or (deployment, pods or replicaset)
```
kubectl port-forward deployment or pods or replicaset/deployment-name 7000:6379
```
or (service)
```
kubectl port-forward service/redis-master 7000:redis
```

### Labeling
put labeling in metadata ex:
```
metadata:
  name: testPod
  labels:
    env: development
```
#### get pods and show labels
```
kubectl get pods --show-labels
```
#### add another label to a running pod
```
kubectl label pods testPod owner=arnold
```
#### filer pods by owner (can use --selector or shorthand -l)
```
kubectl get pods --selector owner=arnold
```
#### delete multiple pods by using a filter 
```
kubectl delete pods -l 'env in (production, development)'
```

### User Roles
Every user needs a role and binding to use the k8s API
#### delete role
```
kubectl delete role jupyter-user
```
#### delete binding
```
kubectl delete rolebinding jupyter-user-binding
```
#### list roles and bindings 
```
kubectl get rolebindings,roles \
--all-namespaces  \
-o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name'
```
