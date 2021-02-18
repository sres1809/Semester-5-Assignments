#!/bin/bash
#
#
echo "Enter filename : "
read fname
echo "The number of disk blocks occupied by file is = $(stat -c%b ${fname} )"