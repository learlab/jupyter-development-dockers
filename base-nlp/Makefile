#Dockerfile vars
cuda=12.8

#vars
image=base-nlp
repo=langdonholmes
tag=cuda-${cuda}
IMAGEFULLNAME=${repo}/${image}:${tag}


.PHONY: help build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo ":repo: = ${repo} - DockerHub Repository"
	    @echo ":image: = ${image} - Name of image to build"
	    @echo ":cuda: = ${cuda} - CUDA Version"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "push"
	    @echo "all"

.DEFAULT_GOAL := all

build:
	    @docker build -t ${IMAGEFULLNAME} .

push:
	    @docker push ${IMAGEFULLNAME}

all: build push
