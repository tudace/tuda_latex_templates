#!/bin/bash
git checkout .

rm -f tuda-ci.zip
mkdir -p tuda-ci
rm -rf tuda-ci/*

mkdir -p tuda-ci/doc
cd example
latexmk --lualatex
mv DEMO-*.pdf ../tuda-ci/doc
cd ..

cp -r tex tuda-ci/.

mkdir -p tuda-ci/example
cp example/DEMO-*.tex tuda-ci/example/.
cp example/*.lco tuda-ci/example/.
cp example/*.bib tuda-ci/example/.

cp README.md tuda-ci/.

zip -ll -y -r tuda-ci.zip tuda-ci
