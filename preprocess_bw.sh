#!/bin/bash
# preprocessing script for KACST phoneme-based TTS written by Abdullah Alrajeh
# Use: echo "Arabic Text" | ./preprocess_bw.sh

cat -   |  /home/asrajeh/tools/buckwalter.pl -d=1 \
        | sed 's/^/ /' \
        | sed 's/yٓ /y /g' \
        | sed 's/rۡ/r/g' \
        | sed 's/Hۡ/H/' \
        | sed 's/a`//g' \
        | sed 's/wۡ/w/g' \
        | sed 's/ٗA/A/g' \
        | sed 's/\// /g;s/\([0-9]\+\)[^ ]\+/\1/g' \
        | sed 's/~\([^aiuo]\)/~a\1/g' \
        | sed 's/\([aiuo]\)~/~\1/g' \
        | sed 's/ w[aiuo~FKN]*A[aiuo~FKN]*l[aiuo~FKN]*/ w Al/g' \
        | sed 's/ w / wa /g' \
        | sed 's/l\([^aiuo~]\)/la\1/g' \
        | sed 's/ A[aiuo~FKN]*l[aiuo~FKN]*\([><bjHxEgfqkmhwy]\)/ Aalo\1/g' \
        | sed 's/ A[aiuo~FKN]*l[aiuo~FKN]*\([tvd*rzs$SDTZnl]\)/ Aal\1/g' \
        | sed 's/ l[oFKN~]/ li/g' \
        | sed 's/ l\([^aui]\)/ li\1/g' \
        | sed 's/Y[aiuo]/Y/g' \
        | sed 's/A[aiuo~FKN]*l[aiuo~FKN]*l[aiuo~FKN`]*h[aiuo~FKN]*/Aall~ah/g' \
        | sed 's/ biAi/ biA/g' \
        | sed 's/Ai/A/g' \
        | sed 's/l\([aiu]\)A[aiuo]/l\1A/g' \
        | sed 's/`[aiuo~FKN]/A/g' \
        | sed 's/ [0-9]\+/ raqm/g' \
        | sed 's/^[ ]//' \
        | sed 's/\([\.:+,!@#%&*()\-]\)[aiuo~FKN]\+/\1/g' \
        | sed 's/ [aiuo~FKN]\+ / /g' \
        | sed 's/[«»﴿﴾]/ /g' \
        | /home/asrajeh/tools/buckwalter.pl -d=2

# sed 's/`[aiuo~FKN]/A/g' : replace dagger alif with alif
