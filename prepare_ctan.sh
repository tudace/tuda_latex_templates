#!/bin/bash

rm -f tudatex.zip
mkdir -p tudatex
rm -rf tudatex/*

mkdir -p tudatex/doc
cd example
latexmk --lualatex
mv DEMO-*.pdf ../tudatex/doc
cd ..

cp -r tex tudatex/.

mkdir -p tudatex/example
cp example/*.tex tudatex/example/.
cp example/*.lco tudatex/example/.
cp example/*.bib tudatex/example/.

cp README.md tudatex/.

zip -ll -y -r tudatex.zip tudatex
