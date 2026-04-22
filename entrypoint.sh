#!/bin/sh
set -e

GITHUB_REPO=$1
DOCKER_REPO=$2

echo " Cloning: https://github.com/$GITHUB_REPO.git"
TEMP_DIR=$(mktemp -d)
git clone --depth 1 "https://github.com/$GITHUB_REPO.git" $TEMP_DIR
cd $TEMP_DIR

IMAGE=$(echo $DOCKER_REPO | tr '[:upper:]' '[:lower:]')
echo " Building: $IMAGE"
docker build -t $IMAGE .

echo " Pushing: $IMAGE"
docker push $IMAGE

cd -
rm -rf $TEMP_DIR
echo " Done!"
