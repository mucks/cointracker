#!/bin/sh

npm run build
cp index.html dist
yes | cp -r dist/* /volume
