#!/bin/bash

echo "Updating Rating on gh-pages…"

grunt build

git add build/*
git add index.html
git commit -m "One more try"
git push
