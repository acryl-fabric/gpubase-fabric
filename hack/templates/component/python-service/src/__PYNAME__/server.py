# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

"""Placeholder HTTP server generated from hack/templates/component (/healthz, /metrics)."""

from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

from . import COMPONENT, VERSION


def metrics_text() -> str:
    # Metric names must use the gpubase_fabric_ prefix (docs/governance/NAMING.md).
    return (
        "# HELP gpubase_fabric_build_info Build information of the component.\n"
        "# TYPE gpubase_fabric_build_info gauge\n"
        f'gpubase_fabric_build_info{{component="{COMPONENT}",version="{VERSION}"}} 1\n'
    )


class Handler(BaseHTTPRequestHandler):
    def do_GET(self) -> None:  # noqa: N802 (http.server API)
        if self.path == "/healthz":
            body, ctype = "ok", "text/plain"
        elif self.path == "/metrics":
            body, ctype = metrics_text(), "text/plain; version=0.0.4"
        else:
            self.send_error(404)
            return
        data = body.encode()
        self.send_response(200)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


def serve(port: int = 8080) -> None:
    ThreadingHTTPServer(("", port), Handler).serve_forever()
