BRANCH=$1
for v in `seq 1 10`; do
  TAG=$(git tag | grep v$v | tail -n1)
  VERSION_BRANCH=$BRANCH-$v
  git checkout $BRANCH
  git branch $VERSION_BRANCH
  git rebase --onto $TAG master $VERSION_BRANCH
done
