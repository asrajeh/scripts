#!/bin/bash
# extract diacritized text from Arabic Treebank p1, p2, p3
# Written by Abdullah Alrajeh, Jun 2019

LDC=$HOME/kacst_resources/ldc
cat     $LDC/LDC2005T02/data/treebank/with-vowel/*.tree \
        $LDC/atb_2_3.1/data/penntree/with-vowel/*.tree \
        $LDC/atb_p3_v2/data/penntree/with-vowel/*.tree \
        | sed 's/([^)]*LATIN [^(]\+//g;s/([^)]\+FOREIGN [^(]*)//g' \
        | sed 's/\(([^ ]\+ \)\+\([^)]\+\))\+/\2/g' > text

cat text| sed 's/^/ /;s/$/ /' \
        | sed 's/-PLUS-/+/g;s/\[null\]//g;s/-LRB-/(/g;s/-RRB-/)/g;s/(null)//g' \
        | sed 's/\( \*\)\+ / /g;s/\( \*[^ *]\+\*\)\+ / /g' \
        | sed 's/+//g;s/- -//g' | awk '{$1=$1};1' > text.clean
