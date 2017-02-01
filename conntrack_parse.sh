#!/bin/bash
read_dom () {
 local IFS=\>
 read -d \< ENTITY CONTENT
 local ret=$?
 TAG_NAME=${ENTITY%% *}
 ATTRIBUTES=${ENTITY#* }
 return $ret
}
if [ $# -eq 0 ]
 then echo "Supply IP & Port. EX: ./conntrack 1.2.3.4 80"
else
 conntrack -d $1 -o xml,timestamp -E -p tcp --dport $2 |
 while IFS= read -r line
 do
  while read_dom;
  do
   if [[ $ENTITY = "hour" ]]; then
    HOUR=$CONTENT
   fi
   if [[ $ENTITY = "min" ]]; then
    MIN=$CONTENT
   fi
   if [[ $ENTITY = "sec" ]]; then
    SEC=$CONTENT
   fi
   if [[ $ENTITY = "day" ]]; then
    DAY=$CONTENT
   fi
   if [[ $ENTITY = "month" ]]; then
    MONTH=$CONTENT
   fi
   if [[ $ENTITY = "year" ]]; then
    YEAR=$CONTENT
   fi
   if [[ $ENTITY = "dst" ]] && [[ $CONTENT != $1 ]]; then
    LOGGED_IP=$CONTENT
    #output to be run through sort -u -k1,1
    echo $LOGGED_IP, $HOUR:$MIN:$SEC, $DAY/$MONTH/$YEAR >> blacklist_buffer
   fi
  done
 done
fi

