build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build -f deploy.dockerfile -t us01-3-hbr1.oc.vmware.com/octo/prtc-deploy:$$TAG .; \
	docker tag us01-3-hbr1.oc.vmware.com/octo/prtc-deploy:$$TAG us01-3-hbr1.oc.vmware.com/octo/prtc-deploy:latest

clean:
	docker stop prtc-deploy
	docker rm prtc-deploy

rebuild: clean build

push:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker push us01-3-hbr1.oc.vmware.com/octo/prtc-deploy:$$TAG; \
	docker push us01-3-hbr1.oc.vmware.com/octo/prtc-deploy:latest

run:
	docker run --name prtc-deploy --mount type=bind,source=$(shell pwd)/data,target=/home/data -td us01-3-hbr1.oc.vmware.com/octo/prtc-deploy:latest
	docker exec -it prtc-deploy bash

data/mongo.pem:
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	  -keyout data/mongo.pem -out data/mongo.pem \
	  -subj "/C=US/ST=CA/L=Palo-Alto/O=VMware/OU=Ibis/CN=mongoX.test"

data/mongoInteropKey:
	openssl rand -base64 741 > data/mongoInteropKey


data/istio.yaml:
	helm template --set kiali.enabled=true --set tracing.enabled=true --set grafana.enabled=true --set servicegraph.enabled=true --set kiali.dashboard.grafanaURL=http://grafana:3000 --set kiali.dashboard.jaegerURL=http://jaeger-query:16686 istio/install/kubernetes/helm/istio --name istio --namespace istio-system > data/istio.yaml
	sed -e '/nodePort:/ s/^#*/#/' -i data/istio.yaml

data/istio-init.yaml:
	helm template istio/install/kubernetes/helm/istio-init --name istio-init --namespace istio-system > data/istio-init.yaml

cloudpks-istio: data/istio.yaml data/istio-init.yaml
	-kubectl create namespace istio-system
	kubectl apply -f data/istio-init.yaml
	kubectl apply -f data/istio.yaml


default: build
