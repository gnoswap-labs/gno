#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TRACKER_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
GNOSWAP_REPO="$TRACKER_ROOT/gnoswap"
GNO_REPO="$TRACKER_ROOT/gno"
WORKTREE_ROOT="$TRACKER_ROOT/.worktrees"
GNOSWAP_WORKTREE_ROOT="$WORKTREE_ROOT/gnoswap"
RUN_ROOT_PARENT="$WORKTREE_ROOT/runs"

REF="${1:-main}"

require_repo() {
    local repo_path="$1"
    local name="$2"

    if ! git -C "$repo_path" rev-parse --git-dir >/dev/null 2>&1; then
        echo "Error: $name repository is not initialized at $repo_path" >&2
        echo "Run 'make init' first." >&2
        exit 1
    fi
}

resolve_ref() {
    local ref="$1"

    if git -C "$GNOSWAP_REPO" rev-parse -q --verify "${ref}^{commit}" >/dev/null 2>&1; then
        git -C "$GNOSWAP_REPO" rev-parse "${ref}^{commit}"
        return
    fi

    if git -C "$GNOSWAP_REPO" rev-parse -q --verify "origin/${ref}^{commit}" >/dev/null 2>&1; then
        git -C "$GNOSWAP_REPO" rev-parse "origin/${ref}^{commit}"
        return
    fi

    echo "Error: could not resolve commit or ref '$ref'" >&2
    exit 1
}

ensure_worktree_at_commit() {
    local repo_path="$1"
    local worktree_path="$2"
    local commit="$3"

    if [ -d "$worktree_path" ] && git -C "$worktree_path" rev-parse --git-dir >/dev/null 2>&1; then
        local current_commit
        current_commit=$(git -C "$worktree_path" rev-parse HEAD)
        if [ "$current_commit" = "$commit" ]; then
            return
        fi

        git -C "$repo_path" worktree remove --force "$worktree_path" >/dev/null 2>&1 || true
    elif [ -e "$worktree_path" ]; then
        rm -rf "$worktree_path"
    fi

    git -C "$repo_path" worktree add --detach "$worktree_path" "$commit" >/dev/null
}

require_repo "$GNOSWAP_REPO" "gnoswap"
require_repo "$GNO_REPO" "gno"

mkdir -p "$GNOSWAP_WORKTREE_ROOT" "$RUN_ROOT_PARENT"

git -C "$GNOSWAP_REPO" fetch origin >/dev/null 2>&1
git -C "$GNOSWAP_REPO" worktree prune >/dev/null 2>&1 || true
git -C "$GNO_REPO" worktree prune >/dev/null 2>&1 || true

FULL_COMMIT=$(resolve_ref "$REF")
SHORT_COMMIT=$(git -C "$GNOSWAP_REPO" rev-parse --short=7 "$FULL_COMMIT")
GNOSWAP_WORKTREE="$GNOSWAP_WORKTREE_ROOT/$FULL_COMMIT"

ensure_worktree_at_commit "$GNOSWAP_REPO" "$GNOSWAP_WORKTREE" "$FULL_COMMIT"

RUN_ROOT=$(mktemp -d "$RUN_ROOT_PARENT/${SHORT_COMMIT}.XXXXXX")
GNO_COMMIT=$(git -C "$GNO_REPO" rev-parse HEAD)
GNO_WORKTREE="$RUN_ROOT/gno"

git -C "$GNO_REPO" worktree add --detach "$GNO_WORKTREE" "$GNO_COMMIT" >/dev/null

printf 'TRACKER_ROOT=%q\n' "$TRACKER_ROOT"
printf 'RUN_ROOT=%q\n' "$RUN_ROOT"
printf 'FULL_COMMIT=%q\n' "$FULL_COMMIT"
printf 'SHORT_COMMIT=%q\n' "$SHORT_COMMIT"
printf 'GNOSWAP_WORKTREE=%q\n' "$GNOSWAP_WORKTREE"
printf 'GNO_WORKTREE=%q\n' "$GNO_WORKTREE"
