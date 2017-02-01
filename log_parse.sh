#!/bin/bash
conntrack -d $LISTENER_IP -E -p tcp --dport 3389 | sed 's/^.*dst=//' >> ~/blacklist_buffer &
echo $! > ~/log_3389.pid
while true
 do
  if [[ -f ~/blacklist_buffer ]]
   then
    awk '{print $1}' ~/blacklist_buffer | uniq >> ~/blacklist
    rm ~/blacklist_buffer
  fi
  sort -u ~/blacklist
  sleep 60
 done
