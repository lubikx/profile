#!/bin/bash
[ $# -ne 2 ] && { echo "Usage: $0 project day_count"; echo "Example: $0 cerva 7 (will keep 7 days of cerva PW)"; exit 1; }

PRJ=$1
CNT=$2

[ $CNT -lt 1 ] && { echo "Day count must be >= 1"; exit 2; }

/bin/mkdir /var/www/html/history

cd /var/www/html/tools/

for (( CUR=$CNT ; $CUR-1 ; CUR=$CUR-1 )) do
  PREV=`expr $CUR - 1`


  if [ -d "/var/www/html/history/wizard${PREV}" ]; then
    ./pwsync.sh ${PRJ}_h${PREV} ${PRJ}_h${CUR} history/wizard${PREV} history/wizard${CUR}
  fi

done

./pwsync.sh ${PRJ}_live ${PRJ}_h1 wizard history/wizard1
