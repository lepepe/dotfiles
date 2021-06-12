#!/bin/bash 

# Find alive servers
hosts=`nmap -sn 10.255.6.0/24 10.255.4.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'`

PS3='Select server: '
select host in $hosts
do
  echo "You have selected: $host"

  # Select port
  echo -e "Enter username: \c"
  read user

  xfreerdp -g 1280x1024 -d vertilux -u $user $host

  break
done
