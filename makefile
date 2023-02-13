#Dockerfile vars
cuda=11.6

#vars
image=base_nlp
repo=langdonholmes
IMAGEFULLNAME=${repo}/${image}:${tag}

ifeq ($(image),rstudio)
   tag=latest
else
   tag=cuda-${cuda}
endif

.PHONY: help build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo ":repo: = ${repo} - DockerHub Repository"
	    @echo ":image: = ${image} - Name of image to build"
	    @echo ":cuda: = ${cuda} - CUDA Version (no effect on rstudio build)"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "push"
	    @echo "all"

.DEFAULT_GOAL := all

build:
	    @docker build --build-arg CUDA_VERSION=${cuda} -t ${IMAGEFULLNAME} .

push:
	    @docker push ${IMAGEFULLNAME}

all: build push