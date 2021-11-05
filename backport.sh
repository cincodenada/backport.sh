#!/bin/bash
set -ex
CURBRANCH=$(git rev-parse --abbrev-ref HEAD)
SUFFIX=${CURBRANCH##*-}
if ["$SUFFIX" -eq "$SUFFIX"] 2> /dev/null; then
  START=$SUFFIX
else
  START=10
fi

for v in $(seq $START 1); do
  TAG=$(git tag | grep v$v | tail -n1)
  VERSION_BRANCH=$BRANCH-$v
  git branch $VERSION_BRANCH
  git rebase --onto $TAG master $VERSION_BRANCH
done
