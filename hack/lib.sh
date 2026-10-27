#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Shared helpers for hack/ scripts. Source this file; do not execute it.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Component discovery rule (docs/governance/COMPONENT_CONTRACT.md):
#   - api/ is a single component
#   - every direct child directory of the layer directories below is a
#     component, except docs/
#   - every libs/<language>/<name>/ directory is a shared-library component
LAYERS=(fabric-manager traffic-optimization data-acceleration security field-test)

list_components() {
  echo "api"
  local layer dir
  for layer in "${LAYERS[@]}"; do
    for dir in "$REPO_ROOT/$layer"/*/; do
      [ -d "$dir" ] || continue
      dir="${dir%/}"
      [ "$(basename "$dir")" = "docs" ] && continue
      echo "${dir#$REPO_ROOT/}"
    done
  done
  for dir in "$REPO_ROOT"/libs/*/*/; do
    [ -d "$dir" ] || continue
    dir="${dir%/}"
    echo "${dir#$REPO_ROOT/}"
  done
}

# A component is "deployable" when it ships a Dockerfile.
is_deployable() {
  [ -f "$REPO_ROOT/$1/Dockerfile" ]
}

list_deployable_components() {
  local c
  for c in $(list_components); do
    is_deployable "$c" && echo "$c"
  done
  return 0
}
