#!/bin/bash


###-------------------------------------------------------###
  #------------:  Part 1: Remotely Connect  :-------------#
###-------------------------------------------------------###
# 	This could use any central hub as a host

#-----------------------------------------------------------#
#############################################################
#-----------------------------------------------------------#

###-------------------------------------------------------###
  #------------:  Part 2: Gather All Data  :--------------#
###-------------------------------------------------------###
# 	Grabs versions for pkgs & libs, stdout to logfile

# cd /root
cd /home/cpnfo

nfolog="logtest_$(date +%m%d%H%M).log"
# nfolog="cpnfolog_$(date +%y%m%d%H%M).log"
# nfolog="cpnfolog_$(date +%y%m%d).log"

#}------: timestamp :--------------------------------------->
# time/date stamp code here

#}------: disk uage  :-------------------------------------->
###-------------------------------------------------------###
#tmpStr=`df -h | grep home | awk {'print $6,$2,$3,$4,$5'}`
#echo "diskuse:$tmpStr" >> $nfolog
###-------------------------------------------------------###


#}------: hostname :---------------------------------------->
tmpStr=`uname -a | awk {'print $2'}`
echo "hostname:$tmpStr" >> $nfolog

#}------: os :---------------------------------------------->
tmpStr=`cat /etc/redhat-release | awk {'print $4'}`
echo "OS:$tmpStr" >> $nfolog

#}------: kernel :------------------------------------------>
tmpStr=`uname -a | awk {'print $3'}`
echo "kernel:$tmpStr" >> $nfolog

#}------: apache :------------------------------------------>
tmpStr=`httpd -v | grep Apache\/ | awk {'print $3'}`
echo "apache:$tmpStr" >> $nfolog
tmpStr=`httpd -v | grep Cpanel | awk {'print $2'}`
echo "EasyApache:$tmpStr" >> $nfolog

#}------: perl :-------------------------------------------->
tmpStr=`perl -v | grep "v[[:digit:]]" | awk {'print $4'}`
echo "perl:$tmpStr" >> $nfolog

#}------: php :--------------------------------------------->
tmpStr=`php -v | grep cli | awk {'print $2'}`
echo "PHP:$tmpStr" >> $nfolog
tmpStr=`php -v | grep Engine | awk {'print $3'}`
echo "ZendEngine:$tmpStr" >> $nfolog
tmpStr=`php -v | grep eAccelerator | awk {'print $3'}`
echo "eAccelerator:$tmpStr" >> $nfolog
tmpStr=`php -v | grep ionCube | awk {'print $6'}`
echo "ionCube:$tmpStr" >> $nfolog
tmpStr=`php -v | grep Guard | awk {'print $5'}`
echo "ZendGuard:$tmpStr" >> $nfolog
tmpStr=`php -v | grep Suhosin | awk {'print $3'}`
echo "Suhosin:$tmpStr" >> $nfolog

#}------: mysql :------------------------------------------->
tmpStr=`mysql -V | awk {'print $5'}`
echo "mysql:$tmpStr" >> $nfolog

#}------: cpanel :------------------------------------------>
tmpStr=`/usr/local/cpanel/cpanel -V`
echo "cpanel:$tmpStr" >> $nfolog


#-----------------------------------------------------------#
#############################################################
#-----------------------------------------------------------#

###-------------------------------------------------------###
  #------------:  Part 3: Capture Data  :-----------------#
###-------------------------------------------------------###

#}------: transmit :---------------------------------------->
# code to send results log to an email, scp to central 
# server, and/or write results to db
