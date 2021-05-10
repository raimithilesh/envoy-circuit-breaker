#!/bin/sh
pids=()
sigint()
{
  echo
  echo "Terminating $2 connections with pids:"
  for pid in ${pids[*]}
  do
    if ps -p $pid > /dev/null
    then
      echo $pid
      kill $pid 2>/dev/null
      wait $pid 2>/dev/null
    fi
  done
}

trap 'sigint' INT

for (( c=1; c<=$2; c++ ))
do
   curl -i -H "Content-Type: json" -H "Content-Length: 8000" -X POST -d '{}' http://localhost:8085/service/$1 &
   pids+=($!)
done
echo "Started $2 connections with pids: ${pids[@]}"
wait ${pids[@]}

