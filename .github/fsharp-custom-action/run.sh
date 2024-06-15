#!/bin/bash

# Use this script to control the F# program.
#
# Requirements:
#
# - bash
# - git
# - dotnet
# - yq

set -euo pipefail

echo "[+] Running script..."

ls -la

# fatal: detected dubious ownership in repository at '/github/workspace'
git config --global --add safe.directory /github/workspace
GIT_TAGS=$(git tag --sort -creatordate)

echo "[+] GIT_TAGS: ${GIT_TAGS}"

# dotnet run --project . "${GIT_TAGS}"
/proj/Main "${GIT_TAGS}"

yq -i '. * load("src/workflow.new.yml")' "${REPO_PATH}.github/workflows/${WORKFLOW_FILE_NAME}"

echo "[+] Script done!"