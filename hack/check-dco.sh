#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Verify that every commit in <base>..<head> carries a Signed-off-by trailer
# matching the commit author (Developer Certificate of Origin).
# Usage: hack/check-dco.sh <base-ref> [head-ref]
set -euo pipefail
base="${1:?base ref required}"
head="${2:-HEAD}"

bad=0
while read -r sha; do
  author="$(git log -1 --format='%an <%ae>' "$sha")"
  email="$(git log -1 --format='%ae' "$sha")"
  if git log -1 --format='%(trailers:key=Signed-off-by,valueonly)' "$sha" | grep -qiF "<$email>"; then
    continue
  fi
  echo "::error::commit $(git log -1 --format='%h %s' "$sha") is missing 'Signed-off-by: $author'"
  bad=$((bad + 1))
done < <(git rev-list --no-merges "$base..$head")

if [ "$bad" -gt 0 ]; then
  echo
  echo "$bad commit(s) without a matching DCO sign-off."
  echo "Fix with: git rebase --signoff $base && git push --force-with-lease"
  exit 1
fi
echo "DCO: all commits signed off"
