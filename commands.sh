# extract the first paper in a pdf file as an image
convert -density 100 paper.pdf[0] - | convert -resize 56 - paper.jpg

# split audio on silence
sox in.wav out.wav silence 1 0.1 0.1% 1 0.1 0.1% : newfile : restart

# print lines between two patterns
awk '/pattern1/ {p=1}; p; /pattern2/ {p=0}' file

# one-liner that converts Arabic to Buckwalter
echo 'السلام عليكم' | perl -CSD -Mutf8 -npe "BEGIN {use IO::Handle; STDOUT->autoflush(1);} tr/\N{U+0621}\N{U+0622}\N{U+0623}\N{U+0624}\N{U+0625}\N{U+0626}\N{U+0627}\N{U+0628}\N{U+0629}\N{U+062A}\N{U+062B}\N{U+062C}\N{U+062D}\N{U+062E}\N{U+062F}\N{U+0630}\N{U+0631}\N{U+0632}\N{U+0633}\N{U+0634}\N{U+0635}\N{U+0636}\N{U+0637}\N{U+0638}\N{U+0639}\N{U+063A}\N{U+0640}\N{U+0641}\N{U+0642}\N{U+0643}\N{U+0644}\N{U+0645}\N{U+0646}\N{U+0647}\N{U+0648}\N{U+0649}\N{U+064A}\N{U+064B}\N{U+064C}\N{U+064D}\N{U+064E}\N{U+064F}\N{U+0650}\N{U+0651}\N{U+0652}\N{U+0670}\N{U+0671}/'|>&<}AbptvjHxd*rzs\$SDTZEg_fqklmnhwYyFNKaui~o\`{/;"

# one-liner that converts Buckwalter to Arabic
echo 'AlslAm Elykm' | perl -CSD -Mutf8 -npe "BEGIN {use IO::Handle; STDOUT->autoflush(1);} tr/'|>&<}AbptvjHxd*rzs\$SDTZEg_fqklmnhwYyFNKaui~o\`{/\N{U+0621}\N{U+0622}\N{U+0623}\N{U+0624}\N{U+0625}\N{U+0626}\N{U+0627}\N{U+0628}\N{U+0629}\N{U+062A}\N{U+062B}\N{U+062C}\N{U+062D}\N{U+062E}\N{U+062F}\N{U+0630}\N{U+0631}\N{U+0632}\N{U+0633}\N{U+0634}\N{U+0635}\N{U+0636}\N{U+0637}\N{U+0638}\N{U+0639}\N{U+063A}\N{U+0640}\N{U+0641}\N{U+0642}\N{U+0643}\N{U+0644}\N{U+0645}\N{U+0646}\N{U+0647}\N{U+0648}\N{U+0649}\N{U+064A}\N{U+064B}\N{U+064C}\N{U+064D}\N{U+064E}\N{U+064F}\N{U+0650}\N{U+0651}\N{U+0652}\N{U+0670}\N{U+0671}/;"
