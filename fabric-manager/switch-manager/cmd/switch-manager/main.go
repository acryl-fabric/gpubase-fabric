// Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
// SPDX-License-Identifier: MPL-2.0
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// Command switch-manager is a placeholder entrypoint generated from
// hack/templates/component. It serves /healthz and /metrics only.
package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

const component = "switch-manager"

// version is set at build time via -ldflags "-X main.version=...".
var version = "dev"

func main() {
	addr := flag.String("listen", ":8080", "HTTP listen address")
	flag.Parse()

	log.Printf("%s %s listening on %s", component, version, *addr)
	if err := http.ListenAndServe(*addr, newMux()); err != nil {
		log.Fatal(err)
	}
}

func newMux() *http.ServeMux {
	mux := http.NewServeMux()
	mux.HandleFunc("/healthz", func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("ok"))
	})
	// Metric names must use the gpubase_fabric_ prefix (docs/governance/NAMING.md).
	mux.HandleFunc("/metrics", func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Content-Type", "text/plain; version=0.0.4")
		fmt.Fprintln(w, "# HELP gpubase_fabric_build_info Build information of the component.")
		fmt.Fprintln(w, "# TYPE gpubase_fabric_build_info gauge")
		fmt.Fprintf(w, "gpubase_fabric_build_info{component=%q,version=%q} 1\n", component, version)
	})
	return mux
}
