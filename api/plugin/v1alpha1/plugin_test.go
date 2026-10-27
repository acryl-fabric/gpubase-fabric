// Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
// SPDX-License-Identifier: MPL-2.0
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

package v1alpha1

import (
	"context"
	"errors"
	"reflect"
	"testing"
)

type fakePlugin struct{ name string }

func (f fakePlugin) Name() string                 { return f.name }
func (f fakePlugin) Init(_ context.Context) error { return nil }
func (f fakePlugin) Close() error                 { return nil }

func TestRegistry(t *testing.T) {
	var r Registry
	if err := r.Register(fakePlugin{"b-plugin"}); err != nil {
		t.Fatal(err)
	}
	if err := r.Register(fakePlugin{"a-plugin"}); err != nil {
		t.Fatal(err)
	}
	if err := r.Register(fakePlugin{"a-plugin"}); !errors.Is(err, ErrAlreadyRegistered) {
		t.Fatalf("duplicate register: got %v, want ErrAlreadyRegistered", err)
	}
	if err := r.Register(fakePlugin{"Bad_Name"}); err == nil {
		t.Fatal("invalid name accepted")
	}
	if _, ok := r.Get("a-plugin"); !ok {
		t.Fatal("a-plugin not found")
	}
	if got, want := r.Names(), []string{"a-plugin", "b-plugin"}; !reflect.DeepEqual(got, want) {
		t.Fatalf("Names() = %v, want %v", got, want)
	}
}
