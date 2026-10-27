# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Repository-level helpers. Component Makefiles live in each component directory.

COMPONENTS := $(shell bash -c 'source hack/lib.sh; list_components')

.PHONY: help components verify build test lint-charts diagrams

help:
	@echo "make components   list components"
	@echo "make verify       component contract + license header checks"
	@echo "make build test   build/test every component"
	@echo "make lint-charts  helm lint the umbrella chart"
	@echo "make diagrams     regenerate docs/images/*.svg"

components:
	@printf '%s\n' $(COMPONENTS)

verify:
	hack/verify-contract.sh
	hack/check-mpl-header.sh --all

build:
	@set -e; for c in $(COMPONENTS); do echo "==> $$c"; $(MAKE) -s -C $$c build; done

test:
	@set -e; for c in $(COMPONENTS); do echo "==> $$c"; $(MAKE) -s -C $$c test; done

lint-charts:
	$(MAKE) -C deploy lint

diagrams:
	python3 hack/diagrams/arch.py
	python3 hack/diagrams/workflow.py
	hack/diagrams/consortium.sh
