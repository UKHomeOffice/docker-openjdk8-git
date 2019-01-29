#!usr/bin/env bash

# Turn on debugging
# set -x

# Exit on error
set -e

SSH_KEY=${1}

usage() {
    echo "A utility to set up a git user capable of pushing back to the git repository given the ssh key passed in."
    echo "Dependencies: Java, git and openssh are installed."
    echo "This has been tested with the image produced by UkHomeOffice/docker-openjdk8-git."
    echo "Usage: set-up-github-user.sh <github ssh key>"
}

if [ $# -ne 1 ]; then
    echo "Incorrect number of arguments"
    usage
    exit 2
fi

mkdir ~/.ssh/ && echo "$SSH_KEY" > ~/.ssh/id_rsa && chmod 0600 ~/.ssh/id_rsa
ssh-keyscan github.com >> ~/.ssh/known_hosts && chmod 600 ~/.ssh/known_hosts
printf  "Host github.com\n   Hostname github.com\n   IdentityFile ~/.ssh/id_rsa\n" > ~/.ssh/config
chmod 0600 ~/.ssh/config
printf "[url \"ssh://git@github.com/\"]\n insteadOf = https://github.com/\n" > ~/.gitconfig
printf "[github]\n[user]\n user = git\n" >> ~/.gitconfig
git config --global user.email "drone@noreply.drone.acp"
git config --global user.name "Drone ACP"
