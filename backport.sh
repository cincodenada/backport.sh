#!/bin/bash
set -ex
CURBRANCH=$(git rev-parse --abbrev-ref HEAD)
SUFFIX=${CURBRANCH##*-}
if ["$SUFFIX" -eq "$SUFFIX"] 2> /dev/null; then
  START=$SUFFIX
  BRANCH=${CURBRANCH%-*}
else
  START=10
  BRANCH=$CURBRANCH
fi


for v in $(seq $START 1); do
  TAG=$(git tag | grep v$v | tail -n1)
  VERSION_BRANCH=$BRANCH-$v
  git branch $VERSION_BRANCH
  git rebase --onto $TAG master $VERSION_BRANCH
  SUBJECT=$(git show -s --format="%s")
  BODY=$(git show -s --format="%b")
  git commit --amend -m "backport: $SUBJECT" -m "$BODY"
done
