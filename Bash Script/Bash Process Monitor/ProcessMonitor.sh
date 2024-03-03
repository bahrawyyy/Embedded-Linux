#!/usr/bin/bash -i


# function: listRunningProcesses
# List N running processes with essential information (PID, name, CPU/Memory usage).
        # Arguments: N processes to display their info



function listRunningProcesses()
{
    declare NUM_OF_PROCESSES=$1
    # Show the desired headers from ps which are {USER PID %MEM %CPU COMMAND}
    ps -eo pid,%mem,%cpu,command | head -n 1
    echo "   --------------------------------------------"
    # Show the most recent N processes
    ps -eo pid,%mem,%cpu,command --sort=-time | tail -n "${NUM_OF_PROCESSES}"
}


# function: Show_Process_InDetail
        # Provide detailed information about a specific process, including its PID, parent process ID, user, CPU and memory usage, etc.
        #   Arguments: Process ID 

function Show_Process_InDetail()
{
    declare PROCESS_ID="$1"

    if (( $(ps --pid=${PROCESS_ID} -ly | wc -l) == 1 )); then
        echo "There is no process with this ID"
    else
        ps --pid="${PROCESS_ID}" -ly        
    fi
    
}


# function: displayProcessStats
        # Display overall system process statistics, such as the total number of processes, memory usage, and CPU load.

function displayProcessStats()
{
    echo "---------------- Process Statistics --------------------------"
    # 3. Process Statistics:
    declare LOADAVG
    LOADAVG=$(cat /proc/loadavg)
    substring=$(echo -e "${LOADAVG:0:15}")

    echo "Load Avg: $substring"

    declare TOTAL_PROCESSES
    TOTAL_PROCESSES=$(ps -e | wc -l)
    echo "Total Number of processes: ${TOTAL_PROCESSES}"

    declare MEMORY_USAGE
    MEMORY_USAGE=$(free -m)
    echo "Memory Usage:"
    echo "$MEMORY_USAGE"
}


# function: searchAndFilter
        # Allow users to search for processes based on criteria such as name, user, or resource usage.

function searchAndFilter()
{
    declare OPTION
    select OPT in "Search per process name" "Search per user" "Get the most 3 consuming CPU processes" "Get the most 3 consuming memory processes" "Quit search & Filter"; do
        if [[ "${OPT}" == "Search per process name" ]]; then
            read -r PROCESS_NAME
            ps -C "${PROCESS_NAME}" -ly
            sleep 2
        elif [[ "${OPT}" == "Search per user" ]]; then
            read -r USERNAME
            ps --user="${USERNAME}" -ly
            sleep 2
        elif [[ "${OPT}" == "Get the most 3 consuming CPU processes" ]]; then
            ps -eo %cpu,command --sort=+%cpu | tail -n 3
            sleep 2
        elif [[ "${OPT}" == "Get the most 3 consuming memory processes" ]]; then
            ps -eo %mem,command --sort=+%mem | tail -n 3
            sleep 2
        elif [[ "${OPT}" == "Quit search & Filter" ]]; then
            break
        fi
    done
}


# Configuration Options:
        # Allow users to configure the script through a configuration file. For example, users might specify the update interval, alert thresholds, etc.

if [ -f "./process_monitor.conf" ]; then
    source ./process_monitor.conf
else
    # Update interval in seconds
    UPDATE_INTERVAL=1
    # CPU usage threshold for alerts (percentage)
    CPU_ALERT_THRESHOLD=10.0
    # Memory usage threshold for alerts (percentage)
    MEMORY_ALERT_THRESHOLD=10.0
fi




# function: ManageResourcesALerts
        # Set up alerts for processes exceeding predefined resource usage thresholds.

function ManageResourcesALerts()
{
    MAXIMUM_CPU_FULL=$(ps -eo %cpu,command --sort=+%cpu | tail -n 1)
    MAXIMUM_CPU_CMD=${MAXIMUM_CPU_FULL##* }
    MAXIMUM_CPU_NUM=${MAXIMUM_CPU_FULL%%/*}
    if (( $(echo "$MAXIMUM_CPU_NUM > $CPU_ALERT_THRESHOLD" | bc -l) )); then
        notify-send "CPU Usage Alert" "$MAXIMUM_CPU_CMD uses $MAXIMUM_CPU_NUM of CPU"
    fi

    MAXIMUM_MEM_FULL=$(ps -eo %mem,command --sort=+%mem | tail -n 1)
    MAXIMUM_MEM_CMD=${MAXIMUM_MEM_FULL##* }
    MAXIMUM_MEM_NUM=${MAXIMUM_MEM_FULL%%/*}
    if (( $(echo "$MAXIMUM_MEM_NUM > $MEMORY_ALERT_THRESHOLD" | bc -l) )); then
        notify-send "Memory Usage Alert" "$MAXIMUM_MEM_CMD uses $MAXIMUM_MEM_NUM of Memory" 
    fi
}


# function: showGuide
        # Display all vaild options for the user 


function showGuide()
{
    echo "--------------------------------------------------"
    printf "%s\n" "1- Real time monitoring" "2- Show Process in details" "3- Kill a process" "4- Process statistics" "5- Search & Filter" "6- Show Guide" "7- Exit"
    echo "--------------------------------------------------"

}


# 4. Real-time Monitoring:
# Implement real-time monitoring, updating the display at regular intervals to show the latest process information.
select OPTION in "Real time monitoring" "Show Process in details" "Kill a process" "Process statistics" "Search & Filter" "Show Guide" "Exit"; do
    ManageResourcesALerts
    if [[ "${OPTION}" == "Real time monitoring" ]]; then
        while true; do
            echo "--------- To exit real time monitoring, press e"
            listRunningProcesses 10
            sleep "$UPDATE_INTERVAL"
            if read -rsn1 -t 0.1 input_char; then # reads a single character from the user input with a timeout of 0.1 seconds. 
                if [[ "$input_char" == "e" ]]; then
                    break
                fi
            fi
            clear
        done 
    elif [[ "${OPTION}" == "Show Process in details" ]]; then
        echo "Enter process ID please"
        read -r PROC_ID
        Show_Process_InDetail "${PROC_ID}"
        sleep 2
    elif [[ "${OPTION}" == "Kill a process" ]]; then
        # Allow users to terminate a specific process by entering its PID.
        echo "Enter process ID to kill"
        declare PID_KILL
        read -r PID_KILL
        kill -9 "${PID_KILL}" 2> /dev/null
        # Include logging features to record process-related activities, especially when a process is terminated.
        if (( $? > 0 )); then
            echo "Unsuccessful Kill: No Process with ID: $PID_KILL" >> logFileMonitor.txt
        else
            echo "Process with ID: $PID_KILL has been killed" >> logFileMonitor.txt 
        fi   
        sleep 2  
    elif [[ "${OPTION}" == "Process statistics" ]]; then
        displayProcessStats
        sleep 2
    elif [[ "${OPTION}" == "Search & Filter" ]]; then
        searchAndFilter
    elif [[ "${OPTION}" == "Show Guide" ]]; then
        showGuide
    elif [[ "${OPTION}" == "Exit" ]]; then
        break
    else
        echo "Invalid Option, to show Guide press 6"
    fi
    
done




















