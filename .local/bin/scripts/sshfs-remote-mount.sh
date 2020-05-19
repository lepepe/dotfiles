#!/bin/bash

echo -e "### Mount remote folders localy ###"

# Select server
PS3='Please enter your choice: '
options=("DO Droplets" "Local Servers" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "DO Droplets")
            echo "You have selected: $opt"
            doctl compute droplet list --format "ID,Name,PublicIPv4"

            # Enter necesary info
            echo
            echo -e "Enter remote server IP address: \c"
            read ip
            echo -e "Enter user name Ex: (root, deploy): \c"
            read user
            echo -e "Enter the remote path: \c"
            read remot_path
            echo -e "Enter the local path: \c"
            read local_path

            if [ -d "$local_path" ]
            then
                # Mount remote folder
                sshfs $user@$ip:$remote_path $local_path
                sleep 3
                echo "Network filesystem connected to: $local_path"
            else
                # Create folder
                echo "Creating folder... \c"
                mkdir -p $local_path
                sleep 3

                # Mount remote folder
                echo "Path: $local_path created. \c"
                sshfs $user@$ip:$remote_path $local_path
                sleep 3
                echo "Network filesystem connected to: $local_path"
            fi
            break
            ;;
        "Local Servers")
            echo "You have selected: $opt"
            nmap -sn 172.16.1.0/24 10.255.4.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'

            # Enter necesary info
            echo
            echo -e "Enter remote server IP address: \c"
            read ip
            echo -e "Enter user name Ex: (root, deploy): \c"
            read user
            echo -e "Enter the remote path: \c"
            read remot_path
            echo -e "Enter the local path: \c"
            read local_path

            if [ -d "$local_path" ]
            then
                # Mount remote folder
                sshfs $user@$ip:$remote_path $local_path
                sleep 3
                echo "Network filesystem connected to: $local_path"
            else
                # Create folder
                echo "Creating folder... \c"
                mkdir -p $local_path
                sleep 3

                # Mount remote folder
                echo "Path: $local_path created. \c"
                sshfs $user@$ip:$remote_path $local_path
                sleep 3
                echo "Network filesystem connected to: $local_path"
            fi
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option";;
    esac
done
