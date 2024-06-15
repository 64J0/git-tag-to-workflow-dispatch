#!/bin/bash

# Use this script to control the F# program.
#
# Requirements:
#
# - bash
# - dotnet
# - yq

set -euo pipefail

echo "[+] Running script..."

cd "${REPO_PATH}"

ls -la

git tag --sort -creatordate
GIT_TAGS=$(git tag --sort -creatordate)

echo "[+] GIT_TAGS: ${GIT_TAGS}"

# dotnet run --project . "${GIT_TAGS}"
/proj/Main "${GIT_TAGS}"

yq -y -i '. * load("src/workflow.new.yml")' "${REPO_PATH}.github/workflows/${WORKFLOW_FILE_NAME}"

echo "[+] Script done!"