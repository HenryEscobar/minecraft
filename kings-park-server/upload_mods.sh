#!/bin/sh
config=secure/ftp_server_info.json
FTP_SCRIPT=.tmp_ftp_commands


if [ ! -f $config ] ; then 
   echo "ERROR: ftp config does not exist. please create this file $config"
   echo "Do not use template file to avoid accidently leaking your secure info"
   exit 1
fi

username=$(cat $config | jq --raw-output '.username' )
ftp_server=$(cat $config | jq --raw-output '.ftp_server' )
password=$(cat $config | jq --raw-output '.password' )

FILE='file.txt'

echo "set ftp:ssl-force true"
echo "set ssl:verify-certificate no"
echo "connect $ftp_server"
echo "USER $username" > $FTP_SCRIPT
echo "PASS $password" >> $FTP_SCRIPT
echo "binary" >> $FTP_SCRIPT

echo "ls" >> $FTP_SCRIPT
echo "quit" >> $FTP_SCRIPT
echo $FTP_SCRIPT
cat $FTP_SCRIPT
echo "lftp < $FTP_SCRIPT"
exit 3

echo "cd plugins" >> $FTP_SCRIPT


for i in mod_downloads/*.jar; do
   echo "put $i" >> $FTP_SCRIPT
done

echo "quit" >> $FTP_SCRIPT


lftp < $FTP_SCRIPT
rm $FTP_SCRIPT
exit 0

