#!/usr/bin/env bash
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Apply the main branch protection ruleset and Actions fork-PR policy.
# Idempotent: updates the ruleset if it already exists.
# Requirements: gh logged in as an org owner; the repository must be public
# (or the org on a plan that supports rulesets for private repositories).
#
# Usage: hack/apply-ruleset.sh [owner/repo]
set -euo pipefail
REPO="${1:-acryl-fabric/gpubase-fabric}"
NAME="main-protection"
GITHUB_ACTIONS_APP_ID=15368   # status checks must come from GitHub Actions

ruleset=$(cat <<JSON
{
  "name": "$NAME",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["~DEFAULT_BRANCH"], "exclude": [] } },
  "bypass_actors": [],
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": true,
        "require_last_push_approval": false,
        "required_review_thread_resolution": false,
        "allowed_merge_methods": ["merge", "rebase"]
      } },
    { "type": "required_status_checks",
      "parameters": {
        "strict_required_status_checks_policy": false,
        "required_status_checks": [
          { "context": "ci",       "integration_id": $GITHUB_ACTIONS_APP_ID },
          { "context": "dco",      "integration_id": $GITHUB_ACTIONS_APP_ID },
          { "context": "gitleaks", "integration_id": $GITHUB_ACTIONS_APP_ID }
        ]
      } }
  ]
}
JSON
)
# claude-review is intentionally NOT a required check (advisory; API outages must not block merges).

id=$(gh api "repos/$REPO/rulesets" --jq ".[] | select(.name == \"$NAME\") | .id")
if [ -n "$id" ]; then
  echo "$ruleset" | gh api -X PUT "repos/$REPO/rulesets/$id" --input - --jq '"updated ruleset " + (.id|tostring)'
else
  echo "$ruleset" | gh api -X POST "repos/$REPO/rulesets" --input - --jq '"created ruleset " + (.id|tostring)'
fi

# Public repositories: require approval before running workflows from fork PRs.
if [ "$(gh api "repos/$REPO" --jq .private)" = "false" ]; then
  gh api -X PUT "repos/$REPO/actions/permissions/fork-pr-contributor-approval" \
    -f approval_policy=all_external_contributors --silent
  echo "fork PR workflows: approval required for all external contributors"
  # SECURITY.md points reporters to private vulnerability reporting.
  gh api -X PUT "repos/$REPO/private-vulnerability-reporting" --silent
  echo "private vulnerability reporting: enabled"
fi
