#!/bin/bash
cd tex
fileversion="2.10"
filedate=$(date '+%Y/%m/%d')
echo $filedate
for filename in *.sty *.cls *.def *.cfg *.clo
do
    echo $filename
    (sed  "s/<FILENAME>/$filename/; s/<FILEDATE>/$(date '+%Y\/%m\/%d')/; s/<FILEVERSION>/$fileversion/" ../LICENSE_info && cat $filename ) >> tmp_license.txt
    mv tmp_license.txt $filename
done
cd  ..

cd example
for filename in *.tex *.bib *.lco
do
    echo $filename
    (sed "s/<FILENAME>/$filename/; s/<FILEDATE>/$(date '+%Y\/%m\/%d')/; s/<FILEVERSION>/$fileversion/" ../LICENSE_info-demo && cat $filename ) >> tmp_license.txt
    mv tmp_license.txt $filename
done
cd ..

