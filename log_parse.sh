#!/bin/bash
conntrack -E -p tcp --dport 3389 | sed 's/^.*dst=//' >> ~/blacklist_buffer &
echo $! > ~/ban_hammer_rdp.pid
while true
 do
  if [ -f ~/blacklist_buffer ]
   then
    awk '{print $1}' ~/blacklist_buffer | uniq >> ~/blacklist
    rm ~/blacklist_buffer
  fi
  sort ~/blacklist | uniq >> blacklist2
  mv ~/blacklist2 ~/blacklist
  sleep 60
 done
