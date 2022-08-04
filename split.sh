#!/bin/bash
# A script to split a long sentence into smaller phrases
# Written by Abdullah Alrajeh, Sep 2020
# Use: cat file | ./split.sh

MAX=100

while read line
do
seq=`echo "$line" | sed 's/*//g'`
seqLen=`echo "$seq" | awk '{print NF}'`

i=0; j=0
for word in $seq; do
  i=$((i+1)); j=$((j+1))
  phrase="$phrase"' '"$word"
  # Print the phrase if its length j equals MAX or reaches end of text or
  # ends with punctuation marks [،.:؛؟]
  if [ $j -eq $MAX ] || [ $i -eq $seqLen ] || [[ "$word" = *[،.:؛؟] ]]; then
    # if the phrase length is less than MAX/2 and did not
    # reach end of text continues and addes more words
    if [ $j -lt $((MAX/2)) ] && [ $i -ne $seqLen ]; then
      continue
    fi
    echo "$phrase" | sed 's/^[ \t]*//'
    phrase=''; j=0
  fi
done

done < "${1:-/dev/stdin}"
