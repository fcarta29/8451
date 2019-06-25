#!/bin/bash

ISTIO_NAMESPACE=`kubectl -o json get namespace istio-system | jq  .status.phase -r`
ALLSPARK_NAMESPACE=`kubectl -o json get namespace allspark | jq  .status.phase -r`


if [ "$ALLSPARK_NAMESPACE" = "Active" ]; then
        echo "This cluster has Allspark which already has an optimized Istio installed."
        exit 1
fi


if [ "$ISTIO_NAMESPACE" = "Active" ]; then
	echo "The Istio namespace already exists.  Istio is most likely already installed"
        exit 1
else
	echo "Installing Istio"
	make cloudpks-istio
fi
