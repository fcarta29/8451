#!/bin/bash
kubectl apply -f tiller-rbac-config.yml
helm init --service-account tiller
