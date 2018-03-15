#!/bin/bash
# A script to download from everyayah.com
# written by Abdullah Alrajeh
# ./everyayah.sh <ayah> <surah>
# For example: ./everyayah.sh 001 001

mkdir -p quran
cd quran

wget http://everyayah.com/data/status.php
cat status.php|sed "s/^[ \t]*//"|grep 'href="/data/[A-Za-z_0-9-]*/" target="_blank">GO' | cut -d'/' -f3 > readers

# recited by all readers

R=$(cat readers)

for r in $R
do
  mkdir -p $r
  cd $r
  wget http://www.everyayah.com/data/$r/$1$2.mp3
  cd ..
done
