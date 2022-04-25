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
git clone "$SOURCE_REPO" "$SOURCE_DIR"
mv "$SOURCE_DIR"/* .
rm -rf "$SOURCE_DIR"
git add .
git commit -m 'auto update'
git push origin "$BRANCH" --force

echo "done"
