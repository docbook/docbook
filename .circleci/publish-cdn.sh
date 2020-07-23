#!/bin/bash

if [[ -v CIRCLE_TAG ]]; then
    echo "Deploying CDN updates for $CIRCLE_TAG"
else
    echo "CDN updates are not published for untagged builds"
    exit
fi

if [ ! -d "build/stage/docbook-${CIRCLE_TAG}" ]; then
    echo "Build version and tag (${CIRCLE_TAG}) do not appear to match."
    ls -1 build/stage
    exit 1
fi

if [ `set | grep GIT_EMAIL | wc -l` = 0 -o `set | grep GIT_USER | wc -l` = 0 ]; then
    echo "No identity configured with GIT_USER/GIT_EMAIL"
    exit 1
fi

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USER

# Remember the SHA of the current build.
SHA=$(git rev-parse --verify HEAD)

# Checkout and update cdn.docbook.org; note we need to explicitly
# specify the deployment key because it's a different repo.
IDRSA="/home/circleci/.ssh/id_rsa_b0bdc42f3808364c081793c898531e98"

cd ../
mkdir cdn
cd cdn
git clone --depth 1 -c core.sshCommand="/usr/bin/ssh -i $IDRSA" git@github.com:docbook/cdn.git .

# This assumes the same tag will never be republished (it never should be!).
rsync -ar ../repo/build/stage/ schema/

# generate indexes
perl bin/make-indexes.pl schema

git add .
git commit -m "Deploy DocBook ${CIRCLE_TAG} for ${CIRCLE_PROJECT_USERNAME}: ${SHA}"
git push -q origin HEAD
