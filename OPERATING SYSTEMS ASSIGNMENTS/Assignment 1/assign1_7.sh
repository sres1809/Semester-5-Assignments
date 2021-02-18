#!/bin/bash
#
#
echo "BCSE!!"
while [ true ];
do
    echo "Acceptable commands: "
    echo "1. newfolder [folder-name]"
    echo "2. editfile ([file-name] optional)"
    echo "3. info [file-name]"
    echo "4. exitnewshell"
	echo "Enter command -> "
	read command
    IFS=' ' read -ra words <<< $command
    main_command="N/A"
    count=0
    for i in "${words[@]}"; do
        ((count=count+1))
    done

    for i in "${words[@]}"; do
        if [ "$main_command" == "N/A" ];then
            main_command="$i"
            if [ "$main_command" == "exitnewshell" ]; 
			then
                exit

            elif [ "$main_command" == "editfile" -a "$count" == "1" ]; 
			then
			    echo "New file created!!"
                vi newfile

            elif [ "$main_command" == "newfolder" -a "$count" == "1" ];
			then
                echo "Specify folder name in argument!!!"

            elif [ "$main_command" == "info" -a "$count" == "1" ]; 
			then
                echo "Specify filename in argument!!!"

            elif [ "$main_command" != "exitnewshell" -a "$main_command" != "newfolder" -a "$main_command" != "info" -a "$main_command" != "editfile" ];
			then
                echo "Invalid Command!!!"
                break
            fi
        else
            if [ "$main_command" == "newfolder" ]; 
			then
                mkdir $i
                echo "Folder $i created!!!"

            elif [ "$main_command" == "editfile" ]; 
			then
                vi -p $i

            elif [ "$main_command" == "info" ]; 
			then
			    echo "Information about file $i-----"
                echo "Full Path-> $(pwd)/$i"
                echo "Size (in bytes)-> `stat -c%s $i`"
                echo "Last modification date and time -> `date -r $i "+%m-%d-%Y %H:%M:%S"`"
                echo "Name of creator-> `stat -c '%U' $i`"
				#echo $(stat $i)
            fi
        fi
    done
    echo " "
done