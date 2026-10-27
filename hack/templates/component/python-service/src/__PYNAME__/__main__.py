# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

import argparse

from .server import serve

parser = argparse.ArgumentParser(prog="__NAME__")
parser.add_argument("--listen", default=":8080", help="listen address, e.g. :8080")
args = parser.parse_args()
serve(int(args.listen.rsplit(":", 1)[-1]))
