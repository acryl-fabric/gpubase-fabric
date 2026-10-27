#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Scaffold a component that satisfies docs/governance/COMPONENT_CONTRACT.md.
#
# Usage:
#   hack/new-component.sh --path <layer>/<name> --org <기관> --team <github-team> \
#       --year <연차> --deliverable <산출물명> --status <상태> --summary <한 줄 설명> \
#       [--type basic|go-service|python-service]
#
#   basic           README.md, placeholder Makefile, tests/   (any language)
#   go-service      basic + Go entrypoint, Dockerfile, Helm chart (deployable)
#   python-service  basic + Python package (pyproject, pytest), Dockerfile, Helm chart (deployable)
#
# Other languages start from "basic" and implement the Makefile targets themselves.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

type=basic path='' org='' team='' year='' deliverable='' status='' summary=''
usage() { sed -n '/^# Scaffold/,/^set -euo/p' "$0" | sed '$d' | sed 's/^# \{0,1\}//'; }
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --path) path="$2" ;; --org) org="$2" ;; --team) team="$2" ;;
    --year) year="$2" ;; --deliverable) deliverable="$2" ;;
    --status) status="$2" ;; --summary) summary="$2" ;; --type) type="$2" ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
  shift 2
done
for v in path org team year deliverable status summary; do
  [ -n "${!v}" ] || { echo "--$v is required" >&2; exit 2; }
done

name="$(basename "$path")"
pyname="${name//-/_}"
layer="$(dirname "$path")"
[[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || { echo "name must be lowercase-hyphen: $name" >&2; exit 2; }
dest="$REPO_ROOT/$path"
[ -e "$dest/README.md" ] && { echo "$path already exists" >&2; exit 1; }
root="$(realpath --relative-to="$dest" "$REPO_ROOT" 2>/dev/null || python3 -c "import os,sys;print(os.path.relpath(sys.argv[1],sys.argv[2]))" "$REPO_ROOT" "$dest")"

esc() { printf '%s' "$1" | sed -e 's/[\\/&|]/\\&/g'; }
render() {
  sed -e "s|__PYNAME__|$(esc "$pyname")|g" -e "s|__NAME__|$(esc "$name")|g" -e "s|__PATH__|$(esc "$path")|g" \
      -e "s|__ROOT__|$(esc "$root")|g" -e "s|__LAYER__|$(esc "$layer")|g" \
      -e "s|__ORG__|$(esc "$org")|g" -e "s|__TEAM__|$(esc "$team")|g" \
      -e "s|__YEAR__|$(esc "$year")|g" -e "s|__DELIVERABLE__|$(esc "$deliverable")|g" \
      -e "s|__STATUS__|$(esc "$status")|g" -e "s|__SUMMARY__|$(esc "$summary")|g"
}
copy_tree() {
  local src="$1" f rel out
  while IFS= read -r -d '' f; do
    rel="${f#$src/}"
    rel="${rel//__PYNAME__/$pyname}"
    out="$dest/${rel//__NAME__/$name}"
    mkdir -p "$(dirname "$out")"
    render < "$f" > "$out"
  done < <(find "$src" -type f -print0)
}

copy_tree_to() {  # copy_tree into a subdirectory of dest
  local saved="$dest"; dest="$dest/$2"; copy_tree "$1"; dest="$saved"
}

tmpl="$REPO_ROOT/hack/templates/component"
copy_tree "$tmpl/common"
case "$type" in
  basic) ;;
  go-service|python-service) copy_tree "$tmpl/$type"; copy_tree_to "$tmpl/chart" chart ;;
  *) echo "unknown --type: $type" >&2; exit 2 ;;
esac
echo "created $path ($type)"
echo "next: add the directory to .github/CODEOWNERS and run 'make verify'"
