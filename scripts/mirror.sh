#!/bin/sh
set -e
SOURCE_REPO=$1
DESTINATION_REPO=$2
SOURCE_DIR=$(basename "$SOURCE_REPO")

echo "SOURCE=$SOURCE_REPO"
echo "DESTINATION=$DESTINATION_REPO"

git clone "$SOURCE_REPO" "$SOURCE_DIR"
cd "$SOURCE_DIR"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

git clone "$SOURCE_REPO" "$SOURCE_DIR" 
cd "$SOURCE_DIR"
git remote add destination "$DESTINATION_REPO"
git add .
git commit -m 'auto update'
git push destination master --force

echo "done"
