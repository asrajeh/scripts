#!/bin/bash
# a script for kaldi systems to extract phone and word alignments of training data
# written by Abdullah Alrajeh, May 2021
# use: ./exctrat_ali.sh exp/tri3b_ali

KALDI=$HOME/kaldi
ali=$1
if [ -z $ali ]; then
  echo Missing ali directory
  exit 1
fi

rm -f $ali/ali.ctm.*

for f in $ali/ali.*.gz; do
$KALDI/src/bin/ali-to-phones --ctm-output exp/tri3b_ali/final.mdl ark:"gunzip -c $f|" - | \
$KALDI/egs/wsj/s5/utils/int2sym.pl -f 5 $ali/phones.txt >> $ali/ali.ctm.phone
done

cat $ali/ali.ctm.phone | \
awk '{
if(substr($NF,2,2)=="_B"){
flag=1
start=$3}

if(substr($NF,2,2)=="_E"){
flag=0
word=word""substr($NF,1,1)
duration+=$4
printf "%s 1 %.2f %.2f %s\n", $1, start, duration, word
word=""
duration=0}

if(substr($NF,2,2)=="_S")
printf "%s 1 %.2f %.2f %s\n", $1, $3, $4, substr($NF,1,1)

if(flag){
word=word""substr($NF,1,1)
duration+=$4}
}' > $ali/ali.ctm.word
