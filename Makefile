NAME := grafeas
PKG := github.com/controlplane/$(NAME)
REGISTRY := docker.io/controlplane

SHELL := /bin/bash
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

CONTAINER_TAG ?= $(GIT_SHA)
CONTAINER_NAME := $(REGISTRY)/$(NAME):$(CONTAINER_TAG)
CONTAINER_NAME_LATEST := $(REGISTRY)/$(NAME):latest

.PHONY: all 
.SILENT:

all: help

.PHONY: build
build: ## builds a docker image
	@echo "+ $@"
	docker build ./database --tag grafeas-database:latest
	docker build ./server --tag grafeas-server:latest

define pre-run
	@echo "+ pre-run"

	pwd
endef

.PHONY: run
run: ## runs the last build docker image
	@echo "+ $@"

	$(pre-run)

.PHONY: push
push: ## runs the last build docker image
	@echo "+ $@"

.PHONY: clean
clean:
	@echo "+ $@"
	docker rm grafeas-docker_server grafeas-docker_database || true
	docker rmi grafeas-docker_server:latest grafeas-docker_database:latest || true
	docker rm grafeas-server grafeas-database || true
	docker rmi grafeas-server:latest grafeas-database:latest || true

.PHONY: help
help: ## parse jobs and descriptions from this Makefile
	@grep -E '^[ a-zA-Z0-9_-]+:([^=]|$$)' $(MAKEFILE_LIST) \
    | grep -Ev '^help\b[[:space:]]*:' \
    | sort \
    | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

