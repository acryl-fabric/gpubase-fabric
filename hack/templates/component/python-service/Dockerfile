# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Build context is the repository root (see Makefile "image" target).
FROM python:3.12-slim
ARG VERSION=dev
LABEL org.opencontainers.image.title="gpubase-fabric/__NAME__" \
      org.opencontainers.image.source="https://github.com/acryl-fabric/gpubase-fabric" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.vendor="ACRYL Inc." \
      org.opencontainers.image.version="${VERSION}"
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 GPUBASE_FABRIC_VERSION=${VERSION}
WORKDIR /app
COPY __PATH__/pyproject.toml ./
COPY __PATH__/src/ src/
RUN pip install --no-cache-dir . && useradd --uid 65532 --no-create-home nonroot
USER 65532:65532
EXPOSE 8080
ENTRYPOINT ["python", "-m", "__PYNAME__"]
