# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

CHART := gpubase-fabric

.PHONY: deps lint template package

deps:
	helm dependency update $(CHART)

lint: deps
	helm lint $(CHART)

template: deps
	helm template $(CHART) $(CHART) >/dev/null

package: deps
	helm package $(CHART) -d dist
