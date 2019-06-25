
build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build -f loadgen.dockerfile -t fcarta29/prtc-loadgen:$$TAG .; \
	docker tag fcarta29/prtc-loadgen:$$TAG fcarta29/prtc-loadgen:latest
clean:
	docker stop prtc-loadgen
	docker rm prtc-loadgen

rebuild: clean build

push:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker push fcarta29/prtc-loadgen:$$TAG; \
	docker push fcarta29/prtc-loadgen:latest

#run:
#	docker run --name prtc-loadgen -td fcarta29/prtc-loadgen:latest
#	docker exec -it prtc-loadgen bash

default: build
