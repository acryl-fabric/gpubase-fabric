# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

COMPONENT := __NAME__
REPO_ROOT := $(abspath __ROOT__)

REGISTRY ?= ghcr.io/acryl-fabric/gpubase-fabric
IMAGE    ?= $(REGISTRY)/$(COMPONENT)
TAG      ?= dev
VERSION  ?= $(TAG)

PYTHON ?= python3
VENV   := .venv
PY     := $(VENV)/bin/python
STAMP  := $(VENV)/.installed

.PHONY: build test image chart-lint run clean

$(STAMP): pyproject.toml
	$(PYTHON) -m venv $(VENV)
	$(PY) -m pip install -q --upgrade pip
	$(PY) -m pip install -q -e '.[test]'
	@touch $(STAMP)

build: $(STAMP)
	$(PY) -m compileall -q src

test: $(STAMP) chart-lint
	$(PY) -m pytest -q tests

image:
	docker build -f $(CURDIR)/Dockerfile --build-arg VERSION=$(VERSION) \
		-t $(IMAGE):$(TAG) $(REPO_ROOT)

chart-lint:
	@if command -v helm >/dev/null 2>&1; then helm lint chart; else echo "helm not found; skipping chart lint"; fi

run: $(STAMP)
	$(PY) -m __PYNAME__

clean:
	rm -rf $(VENV) build dist src/*.egg-info
