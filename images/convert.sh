#!/bin/sh




# TODO; convert all photo name according to date


shopt -s nullglob # prevent goes into for-loop even not match

# unify format to jpg
for file in *.jpeg *.JPEG *.png *.PNG; do
    #do mv $file `basename $file .png`.jpg;
    #ext="${file##*.}";
    #fileName="${file%%.*}";
    convert $file ${file%%.*}.jpg
    rm $file
    #echo ${file%%.*}.jpg
done

# resize & rename
now=$(date +"%Y%m%d")

for file in *.jpg *.JPG; do
    convert $file -resize 1200x800 $file.tmp
    rm $file
    mv $file.tmp "$now-$file" # rename resized file
done




#for file in *.jpg; 
#    do convert $file -resize 800x600 rotated-$file; 
#done

# reference: 
# prevent goes into for-loop: https://superuser.com/questions/912096/list-multiple-file-types-in-bash-for-loop
# extension/file name extract: http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
# imageMagick tutorial:
# https://www.howtogeek.com/109369/how-to-quickly-resize-convert-modify-images-from-the-linux-terminal/

