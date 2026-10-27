#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Print a JSON array of components touched between BASE and HEAD.
# Usage: hack/changed-components.sh <base-ref> [head-ref] [--deployable]
# Shared inputs (go.mod, api/, libs/, hack/, CI workflow) mark every component changed.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

base="${1:?base ref required}"
head="${2:-HEAD}"
only_deployable="${3:-}"

mapfile -t files < <(git -C "$REPO_ROOT" diff --name-only "$base" "$head")
mapfile -t components < <(list_components)

declare -A hit=()
all=false
for f in "${files[@]}"; do
  case "$f" in
    go.mod|go.sum|libs/*|hack/lib.sh|hack/templates/*|.github/workflows/ci.yml|.github/workflows/images.yml|Makefile)
      all=true ;;
  esac
  for c in "${components[@]}"; do
    [[ "$f" == "$c/"* ]] && hit["$c"]=1
  done
done
# api/ is consumed by every Go component.
[ -n "${hit[api]:-}" ] && all=true

out=()
for c in "${components[@]}"; do
  if $all || [ -n "${hit[$c]:-}" ]; then
    if [ "$only_deployable" = "--deployable" ] && ! is_deployable "$c"; then
      continue
    fi
    out+=("$c")
  fi
done

printf '['
sep=''
for c in "${out[@]}"; do printf '%s"%s"' "$sep" "$c"; sep=','; done
printf ']\n'
