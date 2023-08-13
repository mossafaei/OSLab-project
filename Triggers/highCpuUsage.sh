#
#   ./highCpuUsage NUMBER_OF_CORES USER_CPU
#

email_script=/root/OSLab/email.sh

cores=$1
user_cpu=$2


if [[ $(echo "$user_cpu > $cores * 100" | bc -l ) == 1 ]] 
then
    echo "$current_date High user cpu with $2" >> /var/log/trigger.log
    $email_script "Alert" "High user cpu with: $2"
    exit
fi

#...