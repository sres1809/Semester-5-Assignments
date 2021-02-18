#!/bin/bash
#
#
str1="printf"
str2="scanf"
str3="int"
count11=0
count12=0
count13=0
count21=0
count22=0
count23=0
count31=0
count32=0
count33=0
count41=0
count42=0
count43=0
count51=0
count52=0
count53=0
count61=0
count62=0
count63=0
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
#
#
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count11=$((count11+1))
		elif [[ "$str2" == "$word" ]]
		then
			count12=$((count12+1))
		elif [[ "$str3" == "$word" ]]
		then
			count13=$((count13+1))
		fi
	done;
done < $fname1
#
#
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count21=$((count21+1))
		elif [[ "$str2" == "$word" ]]
		then
			count22=$((count22+1))
		elif [[ "$str3" == "$word" ]]
		then
			count23=$((count23+1))
		fi
	done;
done < $fname2
#
#
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count31=$((count31+1))
		elif [[ "$str2" == "$word" ]]
		then
			count32=$((count32+1))
		elif [[ "$str3" == "$word" ]]
		then
			count33=$((count33+1))
		fi
	done;
done < $fname3
#
#
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count41=$((count41+1))
		elif [[ "$str2" == "$word" ]]
		then
			count42=$((count42+1))
		elif [[ "$str3" == "$word" ]]
		then
			count43=$((count43+1))
		fi
	done;
done < $fname4
#
#
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count51=$((count51+1))
		elif [[ "$str2" == "$word" ]]
		then
			count52=$((count52+1))
		elif [[ "$str3" == "$word" ]]
		then
			count53=$((count53+1))
		fi
	done;
done < $fname5
#
#
while read -ra line;
do 
    for word in "${line[@]}";
	do 
	    if [[ "$str1" == "$word" ]]
		then
		    count61=$((count61+1))
		elif [[ "$str2" == "$word" ]]
		then
			count62=$((count62+1))
		elif [[ "$str3" == "$word" ]]
		then
			count63=$((count63+1))
		fi
	done;
done < $fname6
#
#
#
echo "Name of C file   Frequency of occurrence of $str1   Frequency of occurrence of $str2   Frequency of occurrence of $str2"
echo "$fname1                       $count11                                  $count12                               $count13"
echo "$fname2                       $count21                                  $count22                               $count23"
echo "$fname3                       $count31                                  $count32                               $count33"
echo "$fname4                       $count41                                  $count42                               $count43"
echo "$fname5                       $count51                                  $count52                               $count53"
echo "$fname6                       $count61                                  $count62                               $count63"

