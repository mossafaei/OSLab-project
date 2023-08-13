#
#   ./highDiskUsage DISK_USE_PERCENTAGE
#

email_script=/root/OSLab/email.sh

disk_use_percentage=`echo $1 | sed 's/.$//'`

if [[ $(echo "$disk_use_percentage > 90" | bc -l ) == 1 ]] 
then
    echo "$current_date High disk usage" >> /var/log/trigger.log
    $email_script "Alert" "High disk usage with $1"
    exit
fi