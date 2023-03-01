#vars
image=nvidia-pytorch
repo=langdonholmes
tag=latest
IMAGEFULLNAME=${repo}/${image}:${tag}


.PHONY: help build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo ":repo: = ${repo} - DockerHub Repository"
	    @echo ":image: = ${image} - Name of image to build"
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