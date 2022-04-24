#!/bin/sh

set -e

SOURCE_REPO=$1
DESTINATION_REPO=$2
SOURCE_DIR=$(basename "$SOURCE_REPO")
DRY_RUN=$3

GIT_SSH_COMMAND="ssh -v"

echo "SOURCE=$SOURCE_REPO"
echo "DESTINATION=$DESTINATION_REPO"

git clone "$SOURCE_REPO" "$SOURCE_DIR" && cd "$SOURCE_DIR"
git remote add destination "$DESTINATION_REPO"
git push destination master --force
