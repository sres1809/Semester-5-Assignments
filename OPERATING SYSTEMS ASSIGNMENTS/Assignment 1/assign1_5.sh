#!/bin/bash
#
#
echo "Enter name of file: "
read fname
echo "Enter string to be searched: "
read str
line_no=1
flag=0
total=0
echo "Line number       Frequency of occurence"
while read -ra line;
do 
    count=0
    for word in "${line[@]}";
	do 
	    if [[ "$str" == "$word" ]]
		then
		    count=$((count+1))			
		fi
	done;
	if [ $count -gt 0 ]
	then
	    echo "  $line_no                     $count"
		flag=1
		total=$((total+count))
	fi
	line_no=$((line_no+1))
done < $fname
if [ $flag -eq 0 ]
then
    echo "    -                     -"
	echo "No occurence of $str in $fname!!!"
else
    echo "Total number of occurences of $str in $fname is $total"
fi
