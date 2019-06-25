#!/bin/bash
INGRESS=`kubectl get service istio-ingressgateway -n istio-system -o json | jq .status.loadBalancer.ingress[0].hostname -r`

echo "http://${INGRESS}/productpage"
