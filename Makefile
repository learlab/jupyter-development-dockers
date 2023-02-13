#Dockerfile vars
cuda=11.6

#vars
IMAGENAME=base_nlp
TAG=latest
REPO=langdonholmes
IMAGEFULLNAME=${REPO}/${IMAGENAME}:${cuda}

.PHONY: help build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "cuda - CUDA Version"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "push"
	    @echo "all"

.DEFAULT_GOAL := all

print:
		@echo docker build --build-arg CUDA_VERSION=${cuda} -t ${IMAGEFULLNAME} .

build:
	    @docker build --build-arg CUDA_VERSION=${cuda} -t ${IMAGEFULLNAME} .

push:
	    @docker push ${IMAGEFULLNAME}

all: build push