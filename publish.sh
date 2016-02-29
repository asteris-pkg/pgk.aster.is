#!/usr/bin/env bash
set -e

if [[ "$(git status --porcelain)" != "" ]]; then
    echo publish should only be run on a clean working directory
    exit 1
fi

TEMP=$(mktemp -d -t pkg.asteri.is.XXXX)
hugo -d $TEMP
MESSAGE="$(git show --abbrev-commit --oneline --no-patch) (update from master content)"

# move to gh-pages to place content
git checkout gh-pages

# remove all the content to let the rendered replace it
git ls-files | xargs rm -rf
find * -empty -type d -delete

mv ${TEMP}/* .
rm -rf $TEMP

git add -A .
git commit -m "$MESSAGE" || exit 2

# restore to master
git checkout master
