#!/bin/bash
#
add(){
echo "The sum of $1 and $2 = $(($1 + $2))"
return
}
#
subtract(){
echo "The difference between $1 and $2 = $(($1 - $2))"
return
}
#
mul(){
echo "The product of $1 and $2 = $(($1 * $2))"
return
}
#
div(){
echo "The quotient when $1 is divided by $2 = $(($1 / $2))"
echo "The remainder when $1 is divided by $2 = $(($1 % $2))"
return
}
#
concatenate(){
local str="$1$2"
echo "The resulting string after concatenating $1 and $2 = $str"
return
}
#
common(){
str1="$1"
str2="$2"
if [ ${#str1} -lt ${#str2} ]
then
    str1="$2"
    str2="$1"
fi
for ((i=${#str2}; i>0; i--)); do
    for ((j=0; j<=${#str2}-i; j++)); do
            if [[ $str1 =~ ${str2:j:i} ]]
            then
                echo "The common substring from $1 and $2 = ${str2:j:i}"
                return
            fi
    done
done
echo "There is no common substring in $1 and $2!"
}
#
choice=Y
#
while [ $choice == Y ]
do
    echo "Enter the value of variable 1: "
    read userv1
    echo "Enter the value of variable 2: "
    read userv2
	echo "Variable 1: $userv1"
	echo "Variable 2: $userv2"
	
	if [[ "$userv1" =~ ^[0-9]+$ && "$userv2" =~ ^[0-9]+$ ]]; 
	then
	    add "$userv1" "$userv2"
		subtract "$userv1" "$userv2"
		mul "$userv1" "$userv2"
		div "$userv1" "$userv2"
		echo "Concatenation is not possible with integers!"
		echo "Common substring extraction is not possible with integers!"
	elif [[ "$userv1" =~ ^[0-9]+$ || "$userv2" =~ ^[0-9]+$ ]]; 
	then
        echo "None of given operations are possible with variables of different types!"
	else
        echo "Addition not possible with strings!"
        echo "Subtraction not possible with strings!"
        echo "Multiplication not possible with strings!"
		echo "Division not possible with strings!"
        concatenate "$userv1" "$userv2"
        common "$userv1" "$userv2"
	fi
	echo "Do you wish to run loop again? (Y/N):"
	read choice	
done

