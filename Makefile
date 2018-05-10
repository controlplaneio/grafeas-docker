NAME := grafeas
PKG := github.com/controlplane/$(NAME)
REGISTRY := docker.io/controlplane

SHELL := /bin/bash
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

CONTAINER_TAG ?= $(GIT_SHA)
CONTAINER_NAME := $(REGISTRY)/$(NAME):$(CONTAINER_TAG)
CONTAINER_NAME_LATEST := $(REGISTRY)/$(NAME):latest

NETWORK_NAME := "grafeas"

#POSTGRES_IMAGE := "postgres:10.3-alpine"
POSTGRES_IMAGE := "postgres:10.3-alpine"
SERVER_IMAGE  := "grafeas-server"

ifeq ($(NODAEMON), true)
	RUN_MODE := 
else
	RUN_MODE := "-d"
endif

.PHONY: all 
.SILENT:

all: help

.PHONY: build
build: ## builds a docker image
	@echo "+ $@"
	docker build ./database --tag grafeas-database:latest
	docker build ./server --tag grafeas-server:latest

.PHONY: run-prod-network
run-prod-network: ## create bridge network shared b/w grafeas & postgres
	@echo "+ $@"
	docker network create ${NETWORK_NAME} || true

# define db-init-script
 	# set 
	# 123
	# ggg
# endef

define nwln

endef

define ANNOUNCE_BODY
Version of has been released.

It can be downloaded from here.

etc, etc.
endef

PASSWORD := 9Ptd5EQZFLoufuIby
SCRIPT_FILENAME := "init-grafeas-db.sh"

.PHONY: generate-db-init-script
generate-db-init-script:
	@printf \
	"#!/bin/bash\n\
	set -e\n\n\
	psql -v ON_ERROR_STOP=1 --username \"$$"POSTGRES_USER"\" <<-EOSQL\n\
		CREATE USER grafeas WITH LOGIN PASSWORD '$(PASSWORD)';\n\
		CREATE DATABASE grafeas;\n\
		GRANT ALL PRIVILEGES ON DATABASE grafeas TO grafeas;\n\
	EOSQL\n\
	" > $(SCRIPT_FILENAME)

	chmod a+x $(SCRIPT_FILENAME)

define pre-run
	@echo "+ pre-run"

	docker  rm --force grafeas || true
	docker  rm --force postgres || true

endef

.PHONY: run 
run: ## runs the last build docker image
	@echo "+ $@"

	@echo ${shell pwd}

	$(pre-run)
	$(run-postgres)
	$(run-server)

define run-postgres
	docker container run ${RUN_MODE} \
		--restart always \
		--name postgres \
		--network ${NETWORK_NAME} \
		-v "${shell pwd}/init-grafeas-db.sh":"/docker-entrypoint-initdb.d/init-grafeas-db.sh" \
		-e GRAFEAS_PASSWORD=9Ptd5EQZFLoufuIby \
		-e POSTGRES_PASSWORD=7b1pGaZAwknlblLp \
		"${POSTGRES_IMAGE}"
endef

define run-server
	docker container run ${RUN_MODE} \
		--restart always \
		--name grafeas \
		-p 8080:8080 \
		--network ${NETWORK_NAME} \
		-e GRAFEAS_PASSWORD=9Ptd5EQZFLoufuIby \
		"${SERVER_IMAGE}"
endef

.PHONY: push
push: ## runs the last build docker image
	@echo "+ $@"

.PHONY: clean
clean:
	@echo "+ $@"
	docker rm --force grafeas-docker_server grafeas-docker_database || true
	docker rmi --force grafeas-docker_server:latest grafeas-docker_database:latest || true
	docker rm --force grafeas postgres || true
	docker rmi --force "${SERVER_IMAGE}":latest "${POSTGRES_IMAGE}":latest || true

.PHONY: help
help: ## parse jobs and descriptions from this Makefile
	@grep -E '^[ a-zA-Z0-9_-]+:([^=]|$$)' $(MAKEFILE_LIST) \
    | grep -Ev '^help\b[[:space:]]*:' \
    | sort \
    | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

