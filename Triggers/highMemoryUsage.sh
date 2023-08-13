#
#   ./highMemoryUsage TOTAL_MEMORY AVAILABLE_MEMORY
#

email_script=/root/OSLab/email.sh

total_memory=$1
available_memory=$2

if [[ $(echo "$available_memory < $total_memory * 0.1" | bc -l ) == 1 ]] 
then
    echo "$current_date High memory usage" >> /var/log/trigger.log
    $email_script "Alert" "High memory usage with Total memory $total_memory and Available memory $available_memory"
    exit
fi