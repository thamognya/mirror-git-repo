#!/bin/sh
set -e
SOURCE_REPO=$1
DESTINATION_REPO=$2
SOURCE_DIR=$(basename "$SOURCE_REPO")
DESTINATION_DIR=$(basename "$DESTINATION_REPO")

echo "SOURCE=$SOURCE_REPO"
echo "DESTINATION=$DESTINATION_REPO"

git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git clone "$DESTINATION_REPO" "$DESTINATION_DIR"
cd "$DESTINATION_DIR"
rm -rf *

if git show-ref -q --heads "$BRANCH_FOR_DESTINATION_REPO"; then
    git switch "$BRANCH_FOR_DESTINATION_REPO"
else
    git checkout -b "$BRANCH_FOR_DESTINATION_REPO"
fi

git clone "$SOURCE_REPO" "$SOURCE_DIR"
mv "$SOURCE_DIR"/* .
rm -rf "$SOURCE_DIR"
git add .
git commit -m "auto update"
git push origin $BRANCH_FOR_DESTINATION_REPO --force

echo "done"
