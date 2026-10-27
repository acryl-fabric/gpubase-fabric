# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Build context is the repository root (see Makefile "image" target).
FROM golang:1.22 AS build
ARG VERSION=dev
WORKDIR /src
COPY go.mod ./
COPY api/ api/
COPY fabric-manager/dashboard/ fabric-manager/dashboard/
RUN CGO_ENABLED=0 go build -trimpath -ldflags "-s -w -X main.version=${VERSION}" \
    -o /out/dashboard ./fabric-manager/dashboard/cmd/dashboard

FROM gcr.io/distroless/static-debian12:nonroot
ARG VERSION=dev
LABEL org.opencontainers.image.title="gpubase-fabric/dashboard" \
      org.opencontainers.image.source="https://github.com/acryl-fabric/gpubase-fabric" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.vendor="ACRYL Inc." \
      org.opencontainers.image.version="${VERSION}"
COPY --from=build /out/dashboard /dashboard
USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/dashboard"]
