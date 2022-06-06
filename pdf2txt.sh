#!/bin/bash
# Convert PDF file to text using Tesseract OCR
# Written by Abdullah Alrajeh, June 2022
# Email: asrajeh@kacst.edu.sa

FILE='USA_Agr_Arbic 2008.pdf'
L=ara # OCR language (ara|eng)
N=$(pdfinfo "$FILE" | grep Pages | sed 's/[^0-9]*//') # number of pages in a file

for ((i=0;i<$N;i++)); do
  convert -density 300 "$FILE"[$i] "$FILE".$i.jpg; # extract a pdf page as an image
  tesseract "$FILE".$i.jpg "$FILE".$i -l $L; # convert the image to text
done
