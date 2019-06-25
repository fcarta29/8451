build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build -f build.dockerfile -t us01-3-hbr1.oc.vmware.com/octo/prtc-build:$$TAG .; \
	docker tag us01-3-hbr1.oc.vmware.com/octo/prtc-build:$$TAG us01-3-hbr1.oc.vmware.com/octo/prtc-build:latest

clean:
	docker stop prtc-build
	docker rm prtc-build

rebuild: clean build

push:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker push us01-3-hbr1.oc.vmware.com/octo/prtc-build:$$TAG; \
	docker push us01-3-hbr1.oc.vmware.com/octo/prtc-build:latest

run:
	docker run --name prtc-build -td us01-3-hbr1.oc.vmware.com/octo/prtc-build:latest
	docker exec -it prtc-build bash

default: build
