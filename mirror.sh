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
echo "cloned"
cd "$DESTINATION_DIR"
echo "entered directory"
rm -rf *
echo "removed all files"
git clone "$SOURCE_REPO" "$SOURCE_DIR"
echo "cloned"
mv "$SOURCE_DIR"/* .
echo "moved files"
rm -rf "$SOURCE_DIR"
echo "removed source directory"
git add .
echo "added files"
git commit -m "auto update"
echo "committed"
git push origin "$BRANCH" --force
echo "pushed"
echo "done"
