#!/usr/bin/env bash

# Turn on debugging
# set -x

# Exit on error
set -e

usage() {
    echo "A utility to update a git project's version using the gradle release plugin"
    echo "Dependencies: Java and git on the host, gradlew in the project."
    echo "This has been tested with the image produced by UkHomeOffice/docker-openjdk8-git."
    echo "Usage: update-project-version.sh"
}

if [ $# -ne 0 ]; then
    echo "Incorrect number of arguments"
    usage
    exit 2
fi

./gradlew release -i -s -Prelease.useAutomaticVersion=true -x runBuildTasks
NEW_VERSION=$(git describe --abbrev=0)
sed "/appVersion/c\\appVersion: '${NEW_VERSION}'" Chart.yaml > tempChart.yaml && mv tempChart.yaml Chart.yaml
git add . && git commit -m "Set chart version to ${NEW_VERSION} [CI SKIP]" && git push
