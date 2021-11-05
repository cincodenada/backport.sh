#!/bin/bash
set -ex

function get_latest_tag() {
  git tag | grep v$1 | tail -n1
}

CURBRANCH=$(git rev-parse --abbrev-ref HEAD)
SUFFIX=${CURBRANCH##*-}
if [ "$SUFFIX" -eq "$SUFFIX" ] 2> /dev/null; then
  START=$((SUFFIX-1))
  BRANCH=${CURBRANCH%-*}
else
  START=10
  BRANCH=$CURBRANCH
fi
LAST_TAG=$(get_latest_tag $START)


for v in $(seq $START 1); do
  TAG=$(get_latest_tag $v)
  VERSION_BRANCH=$BRANCH-$v
  git branch $VERSION_BRANCH
  SUBJECT=$(git show -s --format="%s")
  BODY=$(git show -s --format="%b")
  git commit --amend -m "backport: $SUBJECT" -m "$BODY"
  git rebase --onto $TAG master $VERSION_BRANCH
  LAST_TAG=$TAG
done
