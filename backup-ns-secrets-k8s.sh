#!/usr/bin/bash
# This script is based on this one https://kevinsimper.medium.com/how-to-dump-all-kubernetes-secrets-to-yaml-files-b5afcf2d1f56
# But also it reads every namespace in your current default context and dumps it's secrets as a file named as the namespace and yml extension
# Tested on non-productive environments.
kubectl get namespaces | awk '{print $1}' | xargs -I{} sh -c 'kubectl get secrets -o yaml -n "$1" --no-headers >> "$1.yaml"' - {} 
