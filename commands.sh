# extract the first paper in a pdf file as an image
convert -density 100 paper.pdf[0] - | convert -resize 56 - paper.jpg

# conver Arabic encoding in file.txt under WINDOWS to Unicode
iconv -f WINDOWS-1256 -t UTF-8 file.txt
iconv -f CP1256 -t UTF-8 file.txt

# split audio on silence
sox in.wav out.wav silence 1 0.1 0.1% 1 0.1 0.1% : newfile : restart

# convert raw format to wav file
sox -r 16000 -e signed -b 16 -c 1 file.raw file.wav
for f in *.raw; do sox -r 16000 -e signed -b 16 -c 1 $f ${f%.raw}.wav; done

# trim a second from the start and end of wav file
sox input.wav output.wav trim 1 trim 0 -1

# print lines between two patterns
awk '/pattern1/ {p=1}; p; /pattern2/ {p=0}' file

# Using multiple delimiters in awk
echo 'In my opinion, it is good. Let us try it' | awk -F'[.,]' '{for(i=1;i<=NF;i++) print $i}'

# numeric-sort of a file according to a specific field
sort -n -t'_' -k6 file

# How to convert \uXXXX unicode to UTF-8
# sudo apt-get install uni2ascii
echo '\u0623\u0645' | ascii2uni -a U -q

# Replace one char with two chars لآ
cat file | sed "s/$(printf $b '\ufef5')/$(printf $b '\u0644\u0622')/g"
# Replace one char with two chars لأ
cat file | sed "s/$(printf $b '\ufef7')/$(printf $b '\u0644\u0623')/g"
# Replace one char with two chars لإ
cat file | sed "s/$(printf $b '\ufef9')/$(printf $b '\u0644\u0625')/g"
# Replace one char with two chars لا
cat file | sed "s/$(printf $b '\ufefb')/$(printf $b '\u0644\u0627')/g"

# Remove zero width char from a file
sed -i "s/$(printf $b '\ufeff')//g" file

# extract uniqe chars from a file
while read -n 1 char; do echo "$char"; done < file | sort -u

# remove lines do not contain Arabic chars from a file
sed -i '/^[^ء-ي]*$/d' file

# print all lines that have space in the second charachter
awk '{if(substr($0,2,1)==" ") print $0}' file

# extract emails from PST archive (MS Outlook Personal Folders)
# sudo apt install pst-utils
readpst -D -S -8 archive.pst
# just text witout attachments
readpst -D -S -8 -a noattach archive.pst

#### Test nvidia-smi with the latest official CUDA image
docker run --gpus all nvidia/cuda:10.0-base nvidia-smi

# run Kaldi gpu-based image
sudo docker run --gpus 1 -it --rm -v ~/local_dir:/opt/dir kaldiasr/kaldi:gpu-latest bash

# save running container as image
docker commit c3f279d17e0a  svendowideit/testimage:version3

# How to send a wav file to my ASR demo from command line
ASR="https://asrajeh.ddns.net:8890/client/dynamic/recognize"
echo -e $(curl -k -T file.wav $ASR)
out=`curl -k -T file.wav $ASR`
echo -e $out
echo $out | cut -d'"' -f8 | ascii2uni -a U -q

# save it in .bashrc or .profile
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar vxjf $1      ;;
            *.tar.gz)   tar vxzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar vxf $1       ;;
            *.tbz2)     tar vxjf $1      ;;
            *.tgz)      tar vxzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# one-liner that converts Arabic to Buckwalter
echo 'السلام عليكم' | perl -CSD -Mutf8 -npe "BEGIN {use IO::Handle; STDOUT->autoflush(1);} tr/\N{U+0621}\N{U+0622}\N{U+0623}\N{U+0624}\N{U+0625}\N{U+0626}\N{U+0627}\N{U+0628}\N{U+0629}\N{U+062A}\N{U+062B}\N{U+062C}\N{U+062D}\N{U+062E}\N{U+062F}\N{U+0630}\N{U+0631}\N{U+0632}\N{U+0633}\N{U+0634}\N{U+0635}\N{U+0636}\N{U+0637}\N{U+0638}\N{U+0639}\N{U+063A}\N{U+0640}\N{U+0641}\N{U+0642}\N{U+0643}\N{U+0644}\N{U+0645}\N{U+0646}\N{U+0647}\N{U+0648}\N{U+0649}\N{U+064A}\N{U+064B}\N{U+064C}\N{U+064D}\N{U+064E}\N{U+064F}\N{U+0650}\N{U+0651}\N{U+0652}\N{U+0670}\N{U+0671}/'|>&<}AbptvjHxd*rzs\$SDTZEg_fqklmnhwYyFNKaui~o\`{/;"

# one-liner that converts Buckwalter to Arabic
echo 'AlslAm Elykm' | perl -CSD -Mutf8 -npe "BEGIN {use IO::Handle; STDOUT->autoflush(1);} tr/'|>&<}AbptvjHxd*rzs\$SDTZEg_fqklmnhwYyFNKaui~o\`{/\N{U+0621}\N{U+0622}\N{U+0623}\N{U+0624}\N{U+0625}\N{U+0626}\N{U+0627}\N{U+0628}\N{U+0629}\N{U+062A}\N{U+062B}\N{U+062C}\N{U+062D}\N{U+062E}\N{U+062F}\N{U+0630}\N{U+0631}\N{U+0632}\N{U+0633}\N{U+0634}\N{U+0635}\N{U+0636}\N{U+0637}\N{U+0638}\N{U+0639}\N{U+063A}\N{U+0640}\N{U+0641}\N{U+0642}\N{U+0643}\N{U+0644}\N{U+0645}\N{U+0646}\N{U+0647}\N{U+0648}\N{U+0649}\N{U+064A}\N{U+064B}\N{U+064C}\N{U+064D}\N{U+064E}\N{U+064F}\N{U+0650}\N{U+0651}\N{U+0652}\N{U+0670}\N{U+0671}/;"

echo 'AlslAm Elykm' | perl -CSD -Mutf8 -npe "BEGIN {use IO::Handle; STDOUT->autoflush(1);} \
tr/'/\N{U+0621}/; \
tr/|/\N{U+0622}/; \
tr/>/\N{U+0623}/; \
tr/&/\N{U+0624}/; \
tr/</\N{U+0625}/; \
tr/}/\N{U+0626}/; \
tr/A/\N{U+0627}/; \
tr/b/\N{U+0628}/; \
tr/p/\N{U+0629}/; \
tr/t/\N{U+062A}/; \
tr/v/\N{U+062B}/; \
tr/j/\N{U+062C}/; \
tr/H/\N{U+062D}/; \
tr/x/\N{U+062E}/; \
tr/d/\N{U+062F}/; \
tr/*/\N{U+0630}/; \
tr/r/\N{U+0631}/; \
tr/z/\N{U+0632}/; \
tr/s/\N{U+0633}/; \
tr/$/\N{U+0634}/; \
tr/S/\N{U+0635}/; \
tr/D/\N{U+0636}/; \
tr/T/\N{U+0637}/; \
tr/Z/\N{U+0638}/; \
tr/E/\N{U+0639}/; \
tr/g/\N{U+063A}/; \
tr/_/\N{U+0640}/; \
tr/f/\N{U+0641}/; \
tr/q/\N{U+0642}/; \
tr/k/\N{U+0643}/; \
tr/l/\N{U+0644}/; \
tr/m/\N{U+0645}/; \
tr/n/\N{U+0646}/; \
tr/h/\N{U+0647}/; \
tr/w/\N{U+0648}/; \
tr/Y/\N{U+0649}/; \
tr/y/\N{U+064A}/; \
tr/F/\N{U+064B}/; \
tr/N/\N{U+064C}/; \
tr/K/\N{U+064D}/; \
tr/a/\N{U+064E}/; \
tr/u/\N{U+064F}/; \
tr/i/\N{U+0650}/; \
tr/~/\N{U+0651}/; \
tr/o/\N{U+0652}/; \
tr/\`/\N{U+0670}/; \
tr/{/\N{U+0671}/; "
