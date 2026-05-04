#!/bin/sh

set -eu

branch=$(git symbolic-ref --quiet --short HEAD || true)
if [ "$branch" != "main" ]; then
  echo "Error: npm run deploy must be run from the main branch." >&2
  exit 1
fi

repo_root=$(git rev-parse --show-toplevel)
head_sha=$(git rev-parse --short HEAD)
temp_root=$(mktemp -d "${TMPDIR:-/tmp}/geojson-deploy.XXXXXX")
deploy_dir="$temp_root/worktree"

cleanup() {
  if [ -d "${deploy_dir:-}" ]; then
    git -C "$repo_root" worktree remove --force "$deploy_dir" >/dev/null 2>&1 || true
  fi
  if [ -d "${temp_root:-}" ]; then
    rm -rf "$temp_root"
  fi
}

trap cleanup EXIT INT TERM HUP

if ! git diff --quiet --ignore-submodules HEAD --; then
  echo "Error: main has unstaged tracked changes. Commit or stash them before deploy." >&2
  exit 1
fi

if ! git diff --cached --quiet --ignore-submodules --; then
  echo "Error: main has staged but uncommitted changes. Commit them before deploy." >&2
  exit 1
fi

if [ ! -d node_modules ]; then
  npm install
fi

npm run build

git worktree add --detach "$deploy_dir" HEAD >/dev/null

mkdir -p "$deploy_dir/dist"
cp -R "$repo_root/dist/." "$deploy_dir/dist/"

git -C "$deploy_dir" add -f dist
git -C "$deploy_dir" commit --no-verify -m "deploy: $head_sha" >/dev/null
git -C "$deploy_dir" push --force origin HEAD:gh-pages

echo "Deployed $head_sha to origin/gh-pages"
