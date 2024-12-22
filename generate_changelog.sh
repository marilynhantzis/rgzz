#!/bin/bash

LAST_TAG=$(git describe --tags --abbrev=0)

COMMITS=$(git log $LAST_TAG..HEAD --pretty=format:"* %s [%h](https://github.com/marilynhantzis/rgzz/commit/%H)")

CURRENT_DATE=$(date +%Y-%m-%d)

VERSION="v$(grep -oP 'version=\K\d+\.\d+\.\d+' app.py)"  #

echo -e "## $VERSION - $CURRENT_DATE\n$COMMITS\n" >> changelog.md
