# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

REPO_ROOT := $(abspath ..)

.PHONY: build test

build:
	cd $(REPO_ROOT) && go build ./api/...

test:
	cd $(REPO_ROOT) && go vet ./api/... && go test -race -count=1 ./api/...
