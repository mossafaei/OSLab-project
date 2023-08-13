#
#   ./highSystemLoad NUMBER_OF_CORES 1MIN_AVERAGE 5MIN_AVERAGE 15MIN_AVERAGE
#

email_script=/root/OSLab/email.sh

cores=$1
load_1min=$2
load_5min=$3
load_15min=$4

current_date=`date +"[%Y/%m/%d %H:%M:%S]:"`


if [[ $(echo "$load_1min > $cores" | bc -l ) == 1 ]] 
then
    echo "$current_date High system load in 1 min average" >> /var/log/trigger.log
    $email_script "Alert" "High system load in 1 min average"
    exit
fi

if [[ $(echo "$load_5min > $cores" | bc -l ) == 1 ]] 
then
    echo "$current_date High system load in 5 min average" >> /var/log/trigger.log
    $email_script "Alert" "High system load in 5 min average"
    exit
fi

if [[ $(echo "$load_15min > $cores" | bc -l ) == 1 ]] 
then
    echo "$current_date High system load in 15 min average" >> /var/log/trigger.log
    $email_script "Alert" "High system load in 10 min average"
    exit
fi