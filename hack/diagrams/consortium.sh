#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Render docs/images/consortium.png (2x, transparent corners) from consortium.html.
# Requires google-chrome or chromium. Run from the repository root.
set -euo pipefail
chrome="$(command -v google-chrome || command -v chromium || command -v chromium-browser)"
"$chrome" --headless=new --disable-gpu --no-sandbox --hide-scrollbars \
  --force-device-scale-factor=2 --default-background-color=00000000 \
  --window-size=1180,272 --screenshot="$PWD/docs/images/consortium.png" \
  "file://$PWD/hack/diagrams/consortium.html" 2>/dev/null
echo "wrote docs/images/consortium.png"
