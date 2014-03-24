#!/bin/bash

echo "Updating Ya-rating on gh-pages…"

grunt build

grunt replace:version
git add build/*
git add index.html
git commit -m "Update Ya Rating"
git push
