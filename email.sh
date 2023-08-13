#We can send email with this script!
#
#   ./email.sh SUBJECT BODY
#


subject=$1
body=$2
email="mostafasafaeipour1@chmail.ir"

echo "Sending email with subject: $subject and with body: $body to: $email ..." >> /var/log/trigger.log

su - no-reply -c "echo $body | mail -s $subject $email"
