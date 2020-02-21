#!/bin/bash
declare url=$1
declare -i duration=5
declare -i OKs=0
declare output
for i in {1..36}
do
  result=$(curl -i $url 2>/dev/null | grep HTTP/1.1)
  declare status
  if [[ -z $result ]]; then 
    status="N/A"
  else
    status=${result:9:3}
  fi 
  if [ "$status" == "200" ];
  then
    let OKs++
  fi
  sleep $duration
done
output='Unhealthy'
if [ "$OKs" -gt 24 ]
then
  output="Healthy"
fi
echo "$output"
