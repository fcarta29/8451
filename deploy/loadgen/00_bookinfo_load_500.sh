#!/bin/bash
INGRESS=`kubectl get service istio-ingressgateway -n istio-system -o json | jq .status.loadBalancer.ingress[0].hostname -r`

LOADGEN_IMAGE_REPO="fcarta29/prtc-loadgen:latest"
BOOKINFO_URL="http://${INGRESS}/productpage"

# clear out and loadgen jobs running
kubectl delete namespace loadgen

cat product-page-load.yaml.tmpl > product-page-load.yaml
sed -i \
-e "s@BOOKINFO_URL@${BOOKINFO_URL}@g" \
-e "s/THREADS/250/g" \
-e "s/CONNECTIONS/500/g" \
-e "s/DURATION/2h/g" \
-e "s@LOADGEN_IMAGE_REPO@${LOADGEN_IMAGE_REPO}@g" \
product-page-load.yaml
kubectl apply -f product-page-load.yaml
