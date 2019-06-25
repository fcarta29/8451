#!/bin/bash

kubectl create namespace bookinfo
kubectl label namespace bookinfo istio-injection=enabled --overwrite=true

kubectl apply -n bookinfo -f istio/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply -n bookinfo -f istio/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl apply -n bookinfo -f istio/samples/bookinfo/networking/destination-rule-all.yaml
