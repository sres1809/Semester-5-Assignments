#!/bin/bash
#
#
fname='file1_2.txt'
ls > $fname
count=0
while read line;
do
    if [[ -d $line ]] ;
	then
	    cd "${line}"
		count1=0
        ls > $fname
	    while read line1;
	    do
	       count1=$((count1+1))
		done < $fname
		count1=$((count1-1))
		echo "Number of files in subdirectory ${PWD##*/}: $count1"
		count=$((count+count1))
	   cd ..
    else
	    count=$((count+1))
	fi
done < $fname
count=$((count-1))
echo "Total number of files in current directory: $count"
echo "Files which have been created/accessed/modified on 6th Dec 2020 are :"
find . -type f -newerat 2020-12-06 ! -newerat 2020-12-07 -printf "%f\n"
echo "Files which have been created/accessed/modified on 7th Dec 2020 are :"
find . -type f -newerat 2020-12-07 ! -newerat 2020-12-08 -printf "%f\n"
