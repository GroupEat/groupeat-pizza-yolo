#!/usr/bin/env bash

echo "Cd into project root"
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
projectRoot=$( pwd )

echo "Pulling changes from groupeat-pizza-yolo"
git pull

echo "Pulling changes from groupeat-api"
cd ../groupeat-api; git pull;

echo "Pulling changes from groupeat-frontend"
cd ../groupeat-frontend; git pull;

echo "Pulling changes from groupeat-showcase"
cd ../groupeat-showcase; git pull;

echo "Cd into project root"
cd $projectRoot

echo "Rebuilding"
./rebuild.sh
