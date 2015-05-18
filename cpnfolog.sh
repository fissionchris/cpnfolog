#!/bin/bash


###-------------------------------------------------------###
  #------------:  Part 1: Remotely Connect  :-------------#
###-------------------------------------------------------###
#       This could use any central hub as a host

#-----------------------------------------------------------#
#############################################################
#-----------------------------------------------------------#

###-------------------------------------------------------###
  #------------:  Part 2: Gather All Data  :--------------#
###-------------------------------------------------------###
#       Grabs versions for pkgs & libs, stdout to logfile

#}------------> Change to Scanner Folder
# cd /root
cd /home/cpnfo

#}------------> Set & Initialize Logfile
nfolog="logtest.`hostname | cut -d '.' -f1`"
# nfolog="logtest_$(date +%m%d%H%M).log"
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
#tmpStr=`uname -a | awk {'print $2'}`
hostStr=`hostname | cut -d '.' -f1`
echo "hostname:$hostStr" > $nfolog

#}------: os :---------------------------------------------->
osStr=`cat /etc/redhat-release | awk {'print $4'}`
echo "OS:$osStr" >> $nfolog

#}------: BASH :---------------------------------------------->
bashStr=`bash --version | head -n 1 | awk '{ print $4}'`
echo "BASH:$bashStr" >> $nfolog

#}------: kernel :------------------------------------------>
kernStr=`uname -a | awk {'print $3'}`
echo "kernel:$kernStr" >> $nfolog

#}------: apache :------------------------------------------>
#tmpStr=`httpd -v | grep Apache\/ | awk {'print $3'} | cut -d '/' -f-`
apaStr=`httpd -v | grep Apache\/ | awk {'print $3'} | rev | cut -d '/' -f1 | rev`
echo "apache:$apaStr" >> $nfolog
eApaStr=`httpd -v | grep Cpanel | awk {'print $2'}`
echo "EasyApache:$eApaStr" >> $nfolog

#}------: perl :-------------------------------------------->
perlStr=`perl -v | grep "v[[:digit:]]" | awk {'print $4'} | sed 's/^.//'`
echo "perl:$perlStr" >> $nfolog

#}------: php :--------------------------------------------->
phpStr=`php -v | grep cli | awk {'print $2'}`
echo "PHP:$phpStr" >> $nfolog
zendEngStr=`php -v | grep Engine | awk {'print $3'} | sed 's/^.//' | sed 's/.$//'`
echo "ZendEngine:$zendEngStr" >> $nfolog
eAccStr=`php -v | grep eAccelerator | awk {'print $3'} | sed 's/^.//' | sed 's/.$//'`
echo "eAccelerator:$eAccStr" >> $nfolog
ionStr=`php -v | grep ionCube | awk {'print $6'} | sed 's/^.//' | sed 's/.$//'`
echo "ionCube:$ionStr" >> $nfolog
guardStr=`php -v | grep Guard | awk {'print $5'} | sed 's/^.//' | sed 's/.$//'`
echo "ZendGuard:$guardStr" >> $nfolog
suStr=`php -v | grep Suhosin | awk {'print $3'} | sed 's/^.//' | sed 's/.$//'`
echo "Suhosin:$suStr" >> $nfolog

#}------: mysql :------------------------------------------->
mysqlStr=`mysql -V | awk {'print $5'} | sed '$s/.$//'`
echo "mysql:$mysqlStr" >> $nfolog

#}------: cpanel :------------------------------------------>
#tmpStr=`/usr/local/cpanel/cpanel -V | sed 's/"\ \(build\ "//'`
cpStr=`/usr/local/cpanel/cpanel -V | sed 's/\ (build\ /\./' | sed 's/.$//'`
echo "cpanel:$cpStr" >> $nfolog


#-----------------------------------------------------------#
#############################################################
#-----------------------------------------------------------#

###-------------------------------------------------------###
  #------------:  Part 3: Capture Data  :-----------------#
###-------------------------------------------------------###

#}------: transmit :---------------------------------------->
# code to send results log to an email, scp to central
# server, and/or write results to db

# Run first time to create entry in database
#echo "INSERT INTO cpnfo (cpnfo_hostname, cpnfo_OS, cpnfo_kernel, cpnfo_apache, cpnfo_EasyApache, cpnfo_perl, cpnfo_PHP, cpnfo_ZendEngine, cpnfo_eAccelerator, cpnfo_ionCube, cpnfo_ZendGuard, cpnfo_Suhosin, cpnfo_mysql, cpnfo_cpanel) values ('$hostStr', '$osStr', '$kernStr', '$apaStr', '$eApaStr', '$perlStr', '$phpStr', '$zendEngStr', '$eAccStr', '$ionStr', '$guardStr', '$suStr', '$mysqlStr', '$cpStr');" | mysql -h localhost -u x -p'x' server_menu

# Run every other time
echo "UPDATE cpnfo SET cpnfo_hostname = '$hostStr', cpnfo_OS = '$osStr', cpnfo_kernel = '$kernStr', cpnfo_apache = '$apaStr', cpnfo_EasyApache = '$eApaStr', cpnfo_perl = '$perlStr', cpnfo_PHP = '$phpStr', cpnfo_ZendEngine = '$zendEngStr', cpnfo_eAccelerator = '$eAccStr', cpnfo_ionCube = '$ionStr', cpnfo_ZendGuard = '$guardStr', cpnfo_Suhosin = '$suStr', cpnfo_mysql = '$mysqlStr', cpnfo_cpanel = '$cpStr' WHERE cpnfo_hostname = '$hostStr';" | mysql localhost -u x -p'x' server_menu
