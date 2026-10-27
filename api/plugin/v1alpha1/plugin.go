// Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
// SPDX-License-Identifier: MPL-2.0
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// Package v1alpha1 defines the plugin Service Provider Interface (SPI) of
// JONATHAN GPUBASE Fabric.
//
// The SPI is the only extension point of the open-source Core. Third-party
// modules and commercial extensions implement Plugin and register it; Core
// never imports their code. Concrete extension-point interfaces (for example
// topology sources or policy backends) are added here as they are defined.
//
// This is an alpha API: it may change without notice.
package v1alpha1

import (
	"context"
	"errors"
	"fmt"
	"regexp"
	"sort"
	"sync"
)

// Plugin is implemented by every extension module.
type Plugin interface {
	// Name returns a unique, lowercase-hyphen identifier such as "example-topology".
	Name() string
	// Init is called once before the plugin is used.
	Init(ctx context.Context) error
	// Close releases resources held by the plugin.
	Close() error
}

// ErrAlreadyRegistered is returned when a plugin name is registered twice.
var ErrAlreadyRegistered = errors.New("plugin already registered")

var namePattern = regexp.MustCompile(`^[a-z0-9]+(-[a-z0-9]+)*$`)

// Registry holds plugins by name. The zero value is ready to use.
type Registry struct {
	mu      sync.RWMutex
	plugins map[string]Plugin
}

// Register adds p to the registry.
func (r *Registry) Register(p Plugin) error {
	name := p.Name()
	if !namePattern.MatchString(name) {
		return fmt.Errorf("invalid plugin name %q: must be lowercase-hyphen", name)
	}
	r.mu.Lock()
	defer r.mu.Unlock()
	if r.plugins == nil {
		r.plugins = make(map[string]Plugin)
	}
	if _, ok := r.plugins[name]; ok {
		return fmt.Errorf("%w: %s", ErrAlreadyRegistered, name)
	}
	r.plugins[name] = p
	return nil
}

// Get returns the plugin registered under name.
func (r *Registry) Get(name string) (Plugin, bool) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	p, ok := r.plugins[name]
	return p, ok
}

// Names returns registered plugin names in sorted order.
func (r *Registry) Names() []string {
	r.mu.RLock()
	defer r.mu.RUnlock()
	names := make([]string, 0, len(r.plugins))
	for n := range r.plugins {
		names = append(names, n)
	}
	sort.Strings(names)
	return names
}
