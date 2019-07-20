#!/bin/bash
cd tex
for filename in *.sty *.cls *.def *.cfg
do
    echo $filename
    (sed "s/<FILENAME>/$filename/" ../LICENSE_info && cat $filename ) >> tmp_license.txt
    mv tmp_license.txt $filename
done
cd  ..

cd example
for filename in *.tex *.bib *.lco
do
    echo $filename
    (sed "s/<FILENAME>/$filename/" ../LICENSE_info-demo && cat $filename ) >> tmp_license.txt
    mv tmp_license.txt $filename
done
cd ..

