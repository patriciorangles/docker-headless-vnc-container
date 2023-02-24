#!/bin/bash
### every exit != 0 fails the script
set -e

HOME=$1
# start anydesk until config files are generated
echo -e "\n\n------------------ ANYDESK STARTUP -----------------"
# run anydesk
anydesk &
# wait for anydesk initialization
counter=0
until [ $counter -gt 5 ]
do
  echo Counter: $counter
  ((counter++))
done



echo -e "\n\n------------------ WAIT 8 -----------------"
sleep 10
pkill anydesk
echo -e "\n\n------------------ WAIT 2 -----------------"
sleep 2
echo <<EOF_FF
ad.security.permission_profiles._full_access.pwd=0333b36c9d1185f18a5f3bd75307d873d98124bdfd6930d39e657dd8db6baafe
ad.security.permission_profiles._full_access.salt=6c3a53092dc86cfe7bc10a710b9ff315
EOF_FF
> $HOME/.anydesk/system.conf
cat $HOME/.anydesk/system.conf
# Get anydesk ID from file
echo -e "\n------------------ ANYDESK ID ----------------------------"
ANY_ID=$(cat $HOME/.anydesk/system.conf | grep ad.anynet.id)
echo -e $ANY_ID
# run anydesk
anydesk &
