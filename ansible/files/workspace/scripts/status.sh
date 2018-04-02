#!/bin/bash

set -e
cd "$(dirname "$0")"/..

for i in */.git
do
  repo=$(dirname $i)
  printf '> \e[1;32m%-6s\e[0m ' $repo
  (cd $repo; git status -b -s)
done
