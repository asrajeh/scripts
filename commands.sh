# extract the first paper in a pdf file as an image
convert -density 100 paper.pdf[0] - | convert -resize 56 - paper.jpg

# split audio on silence
sox in.wav out.wav silence 1 0.1 0.1% 1 0.1 0.1% : newfile : restart

# print lines between two patterns
awk '/pattern1/ {p=1}; p; /pattern2/ {p=0}' file
