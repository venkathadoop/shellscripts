# Get the username to use while logging into a Remote machine
echo "Enter the Remote UserName"
read remoteusername

echo "Enter the Remote Password"
read -s remotepassword

# Read the ServerNames from Serverlist file
for server in `cat /home/test6/Serverlist.txt`
do
        # Printing the ServerName
        echo "Processing ServerName "$server

        # Write some Shell Script for Temporary Usage and Save in Current location
        cat << 'EOF' > ./TestScript.sh
        	#!/bin/bash
        	echo "My Name is $0"
        	echo "I am Running on `hostname`"
        	echo "status of the service `ls -lrt`"
        	exit 0
EOF
	chmod a+x TestScript.sh

        # SCP - copy the script file from Current Directory to Remote Server 
        sshpass -p$remotepassword scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no TestScript.sh $remoteusername@$server:/tmp/TestScript.sh
        
        # Take Rest for 5 Seconds
        sleep 5

        # SSH to remote Server  and Execute a Command [ Invoke the Script ] 
        sshpass -p$remotepassword ssh   -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $remoteusername@$server "/tmp/TestScript.sh"
done

