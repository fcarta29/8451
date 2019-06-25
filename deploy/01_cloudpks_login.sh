#!/bin/bash
export $(grep -v '^#' data/vke.conf | xargs -d '\n' )

vke account login -t $CLOUDPKS_ORG_ID -r $CLOUDPKS_API_REFRESH_TOKEN
vke cluster auth setup $K8S_CLUSTER_NAME
