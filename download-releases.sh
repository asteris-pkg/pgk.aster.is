#!/usr/bin/env bash
set -e

NAME=$1
REPO=$(grep github content/aci/${NAME}.md | awk '{ print $2 }')

curl https://api.github.com/repos/${REPO}/releases
