#!/bin/bash
# a script training Belinkov’s tool
# https://github.com/boknilev/diacritization

cd $HOME/diacritization
mkdir -p data
cd data
cat $HOME/train.txt | perl $HOME/buckwalter.pl -d=1 > text_diac
# train files 90%
cat text_diac | awk '{if(NR%20>1) {print $0; print ""}}'  > train_diac
cat train_diac | sed 's/[iauo~FNK`]\+//g' > train
# test files 5%
cat text_diac | awk '{if(NR%20==1) {print $0; print ""}}' > test_diac
cat test_diac | sed 's/[iauo~FNK`]\+//g' > test
# dev files 5%
cat text_diac | awk '{if(NR%20==0) {print $0; print ""}}' > dev_diac
cat dev_diac | sed 's/[iauo~FNK`]\+//g' > dev

python ../prepare_currennt_data.py \
  -twf train -twdf train_diac -tncf train.nc \
  -swf test -swdf test_diac -sncf test.nc \
  -dwf dev -dwdf dev_diac -dncf dev.nc -lvf letter_vectors.txt -l2cf label_indices.txt

cd ..
mkdir -p tmp
mkdir -p autosave
./run-con.sh
