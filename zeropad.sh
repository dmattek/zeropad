#!/bin/bash

#####################################################################
# Script  name      : zeropad.sh
#
# Author            : Maciej Dobrzynski
#
# Date created      : 20170224
#
# Purpose           : Process input filename and pad numbers after a string
#
# Example usage
#  assume we have files: ch1_t1.tif, ch1_t2.tif, etc.
#  and we want to rename files such that the numbers after "_t" are padded with 4 digits:
#
#  for ii in ch1_t*; do mv $ii `./zeropad_t.sh -p _t -n 4 $ii`; done
#
# If the selected pattern appears more than once,
# the substitution will occur only for the last instance.
# 
# WARNING: uses GNU getopt
# Standard OSX installation of getopt doesn't support long params
# Install through macports
# sudo port install getopt
#
# Tested on:
# OSX 10.11.6 (Darwin Kernel Version 15.6.0)
# Ubuntu 16.04.2 LTS
# 
#####################################################################

usage="This script pads numbers in a given filename after a chosen string.

Usage:
$(basename "$0") [-h] [-p char] [-n int] filename

where:
	-h | --help		Show this Help text.
	-p | --pref		String after the number to pad (default _t).
	-n | --npad 	Number of padding digits (default 3).
	-t | --test		Test mode. Explicitly prints extracted and padded numbers. Don't use for "
	

# string prefix before number
SPREF=_t

# number of digits for padding
NPAD=3

# string used for padding
SPAD=0

# Flag for test mode
TST=0

# read arguments
TEMP=`getopt -o thp:n: --long test,help,pref:,npad: -n 'zeropad.sh' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
# Tutorial at:
# http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt

while true ; do
    case "$1" in
        -t|--test) TST=1 ; shift ;;
        -h|--help) echo "$usage"; exit ;;
        -p|--pref)
            case "$2" in
                "") shift 2 ;;
                *) SPREF=$2 ; shift 2 ;;
            esac ;;
        -n|--npad)
            case "$2" in
                "") shift 2 ;;
                *) NPAD=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

# regular expression to identify numbers
re=.*$SPREF\([0-9]\+\).*$;

# extract number after string prefix
num=`[[ $1 =~ $re ]] && echo ${BASH_REMATCH[1]}`

# create padded  number
paddednum=`printf "%*.*d" 0 $NPAD $num`

if [ $TST -eq 1 ]; then
	printf "Number %s will be converted to %s\n" $num $paddednum
	printf "Resulting filename: "
fi
# output filename with padded number
echo ${1/$SPREF$num/$SPREF$paddednum}
