#!/bin/bash

dlt_file="$1"


# Variables related to count each log level
declare -i countInfos
declare -i countErrors
declare -i countDebugs
declare -i countWarns

# Arrays of Errors and Warns
declare -a Errors_Array
declare -a Warns_Array

# Events Variables
declare -a Events_Array
declare -a Event_Occurrences
declare Event_Occ



# This function is used to count log Levels
function dlt_countLogLevels() {
    if [[ "$1" == "INFO" ]]; then
        countInfos=$(("$countInfos" + 1))
    elif [[ "$1" == "WARN" ]]; then
        countWarns=$(("$countWarns" + 1))
    elif [[ "$1" == "DEBUG" ]]; then
            countDebugs=$(("$countDebugs" + 1))
    elif [[ "$1" == "ERROR" ]]; then
        countErrors=$(("$countErrors" + 1))
    fi
}

# This function parse Logs and print them to the user
function dlt_parseLog() {
    Warns_Array=()
    Errors_Array=()
    countInfos=0
    countDebugs=0
    countWarns=0
    countErrors=0
    while IFS= read -r line; do
        # Extract timestamp (anything enclosed bracketes [])
        timestamp=$(echo "$line" | grep -o '\[.*\]')

        # Extract the log level (the third column)
        log_level=$(echo "$line" | awk '{print $3}')
        dlt_countLogLevels "$log_level"


        # Add errors and warns to their arrays for summarization purpose
        if [[ "$log_level" == "WARN" ]]; then
            Warns_Array+=("$line")
        elif [[ "$log_level" == "ERROR" ]]; then
            Errors_Array+=("$line")
        fi

    
        # Extract the message (anything from the fourth field till the end "first use a delimiter white space between fields instead of TAB"), also remove leading and trailing apaces using sed
        message=$(echo "$line" | cut -d ' ' -f 4- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        # Track events
        for event in "${Events_Array[@]}"; do
            if [[ "$event" == "$message" ]]; then
                Event_Occ=$(echo "- $event occurred at $timestamp with Log Level: $log_level") 
                Event_Occurrences+=("$Event_Occ")
            fi
        done
    
        echo "Timestamp: $timestamp | Log Level: $log_level | Message: $message" 
    done < "$dlt_file"
}


# Print the tracked events
function dlt_TrackEvents() {
    echo "----------------- Events Tracking ---------------"
    for event in "${Event_Occurrences[@]}"; do
        echo "$event"
    done
}


# Filter Logs by specific log level determined by user
function dlt_filterLogLevel() {
    if [[ "$1" == "INFO" || "$1" == "WARN" || "$1" == "ERROR" || "$1" == "DEBUG" ]]; then
        grep "$1" "$dlt_file"
    else
        echo "No entries for $1"
    fi
    
}


# Summarize errors and Warnings
function dlt_Summarize() {
    echo "------------ Errors Summary ------------"
    echo "Total Errors: $countErrors"
    for error in "${Errors_Array[@]}"; do
        echo "- $error"
    done
    echo "------------ Warnings Summary ------------"
    echo "Total Warnings: $countWarns"
    for warn in "${Warns_Array[@]}"; do
        echo "- $warn"
    done
}

# The main select of the script
function dlt_optionSelection() {
    echo "Please, Select an option"
    select OPT in "Filter by log levels" "Errors and warnings summary" "Event tracking" "Generate report" "Quit"; do
        if [[ "${OPT}" == "Filter by log levels" ]]; then
            select LEVEL in "INFO" "WARN" "ERROR" "DEBUG" "Back to the previous Menu"; do
                if [[ "${LEVEL}" == "Back to the previous Menu" ]]; then
                    break
                else
                    dlt_filterLogLevel "$LEVEL"
                fi    
            done
        elif [[ "${OPT}" == "Errors and warnings summary" ]]; then
            dlt_Summarize
        elif [[ "${OPT}" == "Event tracking" ]]; then
            dlt_TrackEvents
        elif [[ "${OPT}" == "Generate report" ]]; then
            echo "Generating a report"
            { echo "------- Log Parsing ------------"; dlt_parseLog; echo ""; dlt_Summarize; echo ""; dlt_TrackEvents; } >> "$Report_Path"/dlt_report.txt
            echo "Done generating the report at $(date -u)"
        elif [[ "${OPT}" == "Quit" ]]; then
            break
        fi
    done
    echo "Done Quitting"
}

# The main function
function main() {
    if [ -f "./dlt_configurations.conf" ]; then
        source ./dlt_configurations.conf
    else
        echo "Please create a file and sepcify your wanted events in (Events_Array)"
        echo "Example: Events_Array=("System Startup Sequence Initiated" "System health check OK")"
    fi
    dlt_parseLog
    dlt_optionSelection
}



main
 
