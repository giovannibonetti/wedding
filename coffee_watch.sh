#!/usr/bin/env bash
find js -name *.js | xargs rm
echo "Warning: all old JS files at have been deleted!"
coffee -c --watch js
