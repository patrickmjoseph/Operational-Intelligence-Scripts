#!/bin/bash

############################################# NOTES ############################

#This process hasn't been automated yet.
#This process checks: 
	# for the 'DemandForwardingBridgeSupport' message
	# for successful and unsuccessful connections to the message hub
	# for data flowing into the DSP by checking the trans.log file for file size of 0 bytes
	# for data having flowed into the DSP in the past by checking size of previous log files for 46 bytes 


############################################# NOTES ############################


#This program checks through log files and prints out any pertinent messages.

# Looking through the message service log file "hubnode.log"
now=$(date)
echo " " >> /home/jospa06/logs/error_log.txt
echo "$now" > /home/jospa06/logs/error_log.txt
cd /var/opt/moi/data3/msgservicehub/opt/CA_Technologies/message_service_hub/logs

echo "Message: DemandForwardingBridgeSupport" >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
cat hubnode.log | grep "DemandForwardingBridgeSupport" >> /home/jospa06/logs/error_log.txt
echo "-------------------------------" >> /home/jospa06/logs/error_log.txt

echo " " >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt

# Checking the connections to the message service from z/OS side

echo "These are the message services which successfully connected to hubs:" >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
cat hubnode.log | grep "has been established." >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo "These are the message services which did not successfully connect to hubs:" >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
cat hubnode.log | grep "shutdown due to a remote error" >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo " " >> /home/jospa06/logs/error_log.txt
echo "-------------------------------" >> /home/jospa06/logs/error_log.txt


# Checking the size of trans.log in the dsp logs to check for data flow through DSP

cd /var/opt/moi/data2/profiler/var/opt/CA/itoa/dsp/dsp_logs

size_of_trans=`wc -c trans.log | grep -o "[0-9]*"`
if [ $size_of_trans == 0 ]
	then 
	echo "Empty trans.log file (NO DATA IS FLOWING TO DSP)" >> /home/jospa06/logs/error_log.txt
	echo " " >> /home/jospa06/logs/error_log.txt
	echo "-------------------------------" >> /home/jospa06/logs/error_log.txt
	echo " " >> /home/jospa06/logs/error_log.txt
	echo " " >> /home/jospa06/logs/error_log.txt
fi

# Checking previous trans.log files to see if data had been
# flowing

if wc -c trans.log.20* | grep -q -e "46" -e "0"; 
then
	echo "No data has flowed to the DSP for a while." >> /home/jospa06/logs/error_log.txt
else
	echo "Here are the logs where data flowed to the DSP:" >> /home/jospa06/logs/error_log.txt
	echo " " >> /home/jospa06/logs/error_log.txt
       	wc -c trans.log.20* | grep -ve "46" -ve "0"	
fi
	echo " " >> /home/jospa06/logs/error_log.txt
	echo "-------------------------------" >> /home/jospa06/logs/error_log.txt
	

