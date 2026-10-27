# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

COMPONENT      := __NAME__
COMPONENT_PATH := __PATH__
REPO_ROOT      := $(abspath __ROOT__)

REGISTRY ?= ghcr.io/acryl-fabric/gpubase-fabric
IMAGE    ?= $(REGISTRY)/$(COMPONENT)
TAG      ?= dev
VERSION  ?= $(TAG)

.PHONY: build test image chart-lint run clean

build:
	cd $(REPO_ROOT) && CGO_ENABLED=0 go build -trimpath \
		-ldflags "-s -w -X main.version=$(VERSION)" \
		-o $(CURDIR)/bin/$(COMPONENT) ./$(COMPONENT_PATH)/cmd/$(COMPONENT)

test: chart-lint
	cd $(REPO_ROOT) && go vet ./$(COMPONENT_PATH)/... && go test -race -count=1 ./$(COMPONENT_PATH)/...

image:
	docker build -f $(CURDIR)/Dockerfile --build-arg VERSION=$(VERSION) \
		-t $(IMAGE):$(TAG) $(REPO_ROOT)

chart-lint:
	@if command -v helm >/dev/null 2>&1; then helm lint chart; else echo "helm not found; skipping chart lint"; fi

run: build
	./bin/$(COMPONENT)

clean:
	rm -rf bin
