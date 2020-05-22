prog() {
  local w=80 p=$1;  shift
  # Create a string of spaces
  printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /.};
  # Print dots 
  printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*"; 
}

hosts=`nmap -sn 172.16.1.0/24 10.255.4.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'`

# Progress bar loop
for x in {1..100} ; do
  prog "$x" finding alive machines...
  sleep .1
done ; echo

PS3='Select Droplet: '
select host in $hosts
do
  echo "You have selected: $host"

  # Select user
  echo -e "Enter SSH user for connection: \c"
  read user

  # Select port
  echo -e "Enter SSH port: \c"
  read port

  if [[ ! -z "$port" ]]
  then
    ssh $user@$host -p $port
  else
    ssh $user@$host
  fi

  break
done
