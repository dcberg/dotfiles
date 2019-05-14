#!/bin/bash

# Download all IBM Cloud Kubernetes Service (IKS) cluster configurations for each cluster
# that the currently logged in user has access. Ensure that you have not restricted
# visibility to a single region using the `ibmcloud ks init` command.

# IBM Cloud Kubernetes Service cluster config dir
clustersdir=~/.bluemix/plugins/container-service/clusters

for arg in "$@"
do
    if [ "$arg" == "-d" ] || [ "$arg" == "--delete-configs" ]
    then
        echo "Deleting existing IKS cluster config files."
        rm -rf $clustersdir
    fi
done

echo "Downloading all IKS cluster configs."
for i in `ibmcloud ks clusters | awk '!/Name|OK/{print $1}'`; do 
  ibmcloud ks cluster-config --export $i | awk -F "=" '{print $NF}'; 
done