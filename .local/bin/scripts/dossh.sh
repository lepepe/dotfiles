droplets=`doctl compute droplet list --format "Name" --no-header`

PS3='Select Droplet: '
select droplet in $droplets
do
  echo "You have selected region: $droplet"
  echo -e "Enter SSH user for connection: \c"
  read user

  doctl compute ssh $user@$droplet
  break
done
