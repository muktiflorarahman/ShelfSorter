#!/bin/bash

## ============================================
## Namn: Mukti Flora Rahman
## E-post: mura1600@student.miun.se
## Kurs: DT038G
## ============================================

## function handles command line arguments
## ===============================================
function readArgs() { 
    #if num of arg is 0 then the usage information will be shown
    if [[ ${#} == 0 ]]; then
        usage
        exit 1
    fi
    #if num of arg is 3 then the usage information will be shown
     if [[ ${#} == 3 ]]; then
        usage
        exit 1
    fi
    
    #if arg is 1 then we want to check if the arg is valid or not
    # checks if data file exists or not
    # if data file does not exist
    if [[ ${#} == 1 ]]; then
        if [[ "$_REQUIRED_ARG" == "-p" || "$_REQUIRED_ARG" == "--print" ]]; then
            printSortiment
            exit 0
        elif [[ "$_REQUIRED_ARG" == "-h" || "$_REQUIRED_ARG" == "--help" ]]; then
            usage
            exit 0
        elif [[ "$_REQUIRED_ARG" == "-s" || "$_REQUIRED_ARG" == "--sort" ]]; then
            usage
            exit 1
        else 
            usage
            exit 1
        fi
    fi

    #if arg is 2 
    if [[ ${#} == 2 ]]; then
        if [[ "$_REQUIRED_ARG" == "-s" || "$_REQUIRED_ARG" == "--sort" ]]; then
            case "$_SORT_ARG" in
                "i") sortColumn 1; exit 0
                ;;
                "n") sortColumn 2; exit 0
                ;;
                "v") sortColumn 3; exit 0
                ;;
                "l") sortColumn 4; exit 0
                ;;
                "b") sortColumn 5; exit 0
                ;;
                "h") sortColumn 6; exit 0
                ;;
                *) usage; exit 1
                ;;
            esac            
        else 
            usage
        fi
    fi
}

## ===============================================
## ===============================================

function usage() {
    echo
    echo "$_USAGE"
}

## ===============================================

## function for terminating the program
## ===============================================
function goodbye() {
    #${@} - arg that is sent to the function
    echo ${@}
    echo 
    exit 0
}
## ===============================================
## ===============================================


## ===============================================
##function that prints sortiment.txt
## ===============================================
function printSortiment() {
   cat < "${_INPUT}"

}
## ===============================================
##function that sorts columns
## ===============================================
function sortColumn() {
    _FILE="$(cat < $_INPUT)"
    
    #checks if it's column 2
    #it then sorts on alphabets
    #otherwise it sorts numerical

    if [[ ${1} == 2 ]]; then
        echo "$_FILE" | head -1
        echo "$_FILE" | tail -n +2 | sort -t$'\t' -k"$1"
    else
        echo "$_FILE" | head -1
        echo "$_FILE" | tail -n +2 | sort -t$'\t' -k"$1" -n
    fi

}
## ===============================================


## main program starts here
## ===============================================
clear

## creating variables 
_REQUIRED_ARG=${1}
_SORT_ARG=${2}
_NO_FILE="file ${file1} does not exist"
_USAGE="Usage: shelfsorter [-p |-s {i|n|v|l|b|h}]
Used primarily for sorting furniture data which is read through stdin.
    -p      print data contents and exit
    -s      sort by additional argument: id (i),
            name (n), weight (v), length (l),
            width (b), height (h), print data contents and exit
    --help  display this help and exit"

_HELP="--help"
_INVALID_ARG="Invalid argument"

#input redirect
_INPUT="/dev/stdin"
#
tabs -15
readArgs ${1} ${2} ${3}
exit 0
## ===============================================
