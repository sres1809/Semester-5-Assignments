#!/bin/bash
#
#
echo "Enter filename: "
read fname
echo "Enter word to replace: "
read str1
echo "Enter new word: "
read str2
sed -i "s/$str1/$str2/g" $fname
