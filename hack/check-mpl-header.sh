#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Report source files without the MPL-2.0 header.
# Usage:
#   hack/check-mpl-header.sh --all              check every tracked source file
#   hack/check-mpl-header.sh <base-ref>         check files added since base-ref
# Missing headers are warnings, except under research/ where the header is
# part of the contract (docs/governance/COMPONENT_CONTRACT.md) and fails.
set -uo pipefail
source "$(dirname "$0")/lib.sh"
cd "$REPO_ROOT"

SRC_RE='\.(go|py|sh|bash|c|h|cc|cpp|hpp|cu|rs|ts|tsx|js|jsx|proto|p4)$'

if [ "${1:-}" = "--all" ]; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    mapfile -t files < <( { git ls-files; git ls-files --others --exclude-standard; } | sort -u | grep -E "$SRC_RE" )
  else
    mapfile -t files < <(find . -type f -not -path './.git/*' | sed 's|^\./||' | sort | grep -E "$SRC_RE")
  fi
else
  base="${1:?usage: $0 --all | <base-ref>}"
  mapfile -t files < <(git diff --name-only --diff-filter=A "$base" HEAD | grep -E "$SRC_RE")
fi

missing=0 research_missing=0
for f in "${files[@]}"; do
  [ -f "$f" ] || continue
  if ! head -n 15 "$f" | grep -qE "SPDX-License-Identifier: MPL-2.0|Mozilla Public License, v\. 2\.0"; then
    if [[ "$f" == research/* ]]; then
      echo "::error file=$f::missing MPL-2.0 header (required under research/)"
      research_missing=$((research_missing + 1))
    else
      echo "::warning file=$f::missing MPL-2.0 header (see hack/boilerplate)"
      missing=$((missing + 1))
    fi
  fi
done
echo "MPL header check: ${#files[@]} file(s), $missing warning(s), $research_missing error(s)"
[ "$research_missing" -eq 0 ]
