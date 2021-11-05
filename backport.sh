set -ex
BRANCH=$1
git checkout $BRANCH
for v in `seq 10 1`; do
  TAG=$(git tag | grep v$v | tail -n1)
  VERSION_BRANCH=$BRANCH-$v
  git branch $VERSION_BRANCH
  git rebase --onto $TAG master $VERSION_BRANCH
  PREV_BRANCH=$VERSION_BRANCH
done
