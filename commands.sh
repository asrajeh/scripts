# extract the first paper in a pdf file as an image
convert -density 100 paper.pdf[0] - | convert -resize 56 - paper.jpg
