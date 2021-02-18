#!/bin/bash
#
#
#
countf(){
str1="printf"
str2="scanf"
str3="int"
count1=0
count2=0
count3=0
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count1=$((count1+1))
		elif [[ "$str2" == "$word" ]]
		then
			count2=$((count2+1))
		elif [[ "$str3" == "$word" ]]
		then
			count3=$((count3+1))
		fi
	done;
done < $1
echo "$1                       $count1                                  $count2                              $count3
}
#
#
echo "Enter name of C file 1: "
read fname1
echo "Enter name of C file 2: "
read fname2
echo "Enter name of C file 3: "
read fname3
echo "Enter name of C file 4: "
read fname4 
echo "Enter name of C file 5: "
read fname5
echo "Enter name of C file 6: "
read fname6
echo "Name of C file   Frequency of occurrence of printf   Frequency of occurrence of scanf   Frequency of occurrence of int"
countf $fname1
countf $fname2
countf $fname3
countf $fname4
countf $fname5
countf $fname6
