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
#git remote add destination "$DESTINATION_REPO"
#git add .
#git commit -m 'auto update'
#git push destination master --force
git remote set-url --push origin "$DESTINATION_REPO"
git fetch -p origin
# Exclude refs created by GitHub for pull request.
git for-each-ref --format 'delete %(refname)' refs/pull | git update-ref --stdin
if [ "$DRY_RUN" = "true" ]
then
    echo "INFO: Dry Run, no data is pushed"
    git push --mirror --dry-run
else
    git push --mirror
fi

echo "done"
