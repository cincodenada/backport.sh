# backport.sh

A very silly project to backport a branch to versions denoted by tags in a git repo.

I got carried away backporting my fix for a [Sinon.js
issue](https://github.com/sinonjs/sinon/pull/2410) and wrote this bash script
to more or less automatically backport a branch to the latest release for each
major version in the git tags.

If you want to try it, just check out the branch you want to backport and run
the script, it should handle the rest.
