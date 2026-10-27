#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Check every component against docs/governance/COMPONENT_CONTRACT.md.
set -uo pipefail
source "$(dirname "$0")/lib.sh"
cd "$REPO_ROOT"

errors=0
fail() { echo "::error file=$1::$2"; errors=$((errors + 1)); }

README_FIELDS=("개요" "담당 기관" "개발 연차" "계획서상 산출물명" "상태" "빌드·실행" "라이선스")

for c in $(list_components); do
  name="$(basename "$c")"
  [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || fail "$c" "component name must be lowercase-hyphen"
  if [ -f "$c/README.md" ]; then
    for field in "${README_FIELDS[@]}"; do
      grep -q "$field" "$c/README.md" || fail "$c/README.md" "README is missing section/field: $field"
    done
  else
    fail "$c" "README.md is missing"
  fi
  if [ -f "$c/Makefile" ]; then
    for t in build test; do
      grep -qE "^$t:" "$c/Makefile" || fail "$c/Makefile" "Makefile is missing target: $t"
    done
  else
    fail "$c" "Makefile is missing"
  fi
  [ -d "$c/tests" ] || fail "$c" "tests/ directory is missing"

  if is_deployable "$c"; then
    grep -qE "^image:" "$c/Makefile" 2>/dev/null || fail "$c/Makefile" "deployable component needs an image target"
    if [ -f "$c/chart/Chart.yaml" ]; then
      grep -qE "^name: $name$" "$c/chart/Chart.yaml" || fail "$c/chart/Chart.yaml" "chart name must be $name"
      grep -q "repository: ghcr.io/acryl-fabric/gpubase-fabric/$name$" "$c/chart/values.yaml" 2>/dev/null \
        || fail "$c/chart/values.yaml" "image.repository must be ghcr.io/acryl-fabric/gpubase-fabric/$name"
    else
      fail "$c" "deployable component needs chart/Chart.yaml"
    fi
    grep -q "name: $name$" deploy/gpubase-fabric/Chart.yaml \
      || echo "::warning file=deploy/gpubase-fabric/Chart.yaml::$c is deployable but not in the umbrella chart"
  fi
done

# research/: README per experiment directory (headers are checked by check-mpl-header.sh)
for d in research/*/; do
  [ -d "$d" ] || continue
  [ -f "$d/README.md" ] || fail "$d" "research experiment needs README.md"
done

# GitHub-hosted runners only
if grep -rnE "runs-on:.*self-hosted" .github/workflows/ 2>/dev/null; then
  fail ".github/workflows" "self-hosted runners are not allowed"
fi

if [ "$errors" -gt 0 ]; then
  echo "component contract: $errors error(s)"
  exit 1
fi
echo "component contract: OK ($(list_components | wc -l) components)"
