#!/bin/bash

# This program issues the docker command and condenses only
# the container ID, Image, Status, and Name of each process
# running after printing the timestamp to /homei/jospa06/logs/$d.txt

# This program displays the top 5 processes running by %CPU to /home/jospa06/logs/$d.txt
# $day is the current day

day=`date +%m-%d-%y`    #variable which holds date
echo  "Timestamp: $(date)" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt

# Showing docker command, stripped of COMMAND, CREATED, AND
# PORTS columns

docker ps -a >> /home/jospa06/logs/$day.txt
sed -i 's/COMMAND//' /home/jospa06/logs/$day.txt
sed -i 's/CREATED//' /home/jospa06/logs/$day.txt
sed -i 's/PORTS//' /home/jospa06/logs/$day.txt
sed -i 's/".*"//g' /home/jospa06/logs/$day.txt
sed -i 's/[0-9]* days ago//g' /home/jospa06/logs/$day.txt
sed -i 's/0.0.0.0:.*\/tcp/					/g' /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt

# Docker containers which are unhealthy

echo "Here are all (if any) unhealthy processes currently:" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
docker ps -a | grep "unhealthy" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt

# Docker containers which have exited

echo "Here are all processes that have exited:" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
docker ps -a | grep "Exited" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt

# Monitoring usage of linux file system using df command

echo "Here are all of the file directories currently using over 50% of their space:" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
df | sed -n -e 's/[5-9][0-9]%/&/p' -e 's/100%/&/p' >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt

# Top command organized by CPU usage

echo "Here are the top 5 processes listed by CPU usage:" >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt

ps aux --sort=-pcpu | head -n 6 >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
echo " " >> /home/jospa06/logs/$day.txt
