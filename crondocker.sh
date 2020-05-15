#!/usr/bin/env bash

# Check if crontab is mounted and exit if not
if [[ ! -f /crontab ]]
then
    echo "Please mount your crontab to /crontab in the container"
    exit
fi

# Ensure the log file exists
touch /crondocker.log

# Remove empty lines from crontab
sed '/^$/d' /crontab > /crontab.noempty

# Append log directive to each command in crontab
awk '{print $0, ">> /crondocker.log 2>&1"}' /crontab.noempty > /crontab.formatted

# Registering the new crontab
crontab /crontab.formatted

# Starting the cron
/usr/sbin/service cron start

# Hook into logs
tail -f /crondocker.log