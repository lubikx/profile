#!/bin/bash

[ $# -ne 4 ] && { echo "Usage: $0 basedb_postfix copydb_postfix basepw_dir copypw_dir"; echo "Example: $0 cerva_live cerva_lubik wizard devel/lubik"; exit 1; }


BASEDB=$1
COPYDB=$2
BASEPW=$3
COPYPW=$4

[ $COPYDB == "live" ] && { echo "Sorry, target DB cannot be live!"; exit 2; }
[ $COPYPW == "wizard" ] && { echo "Sorry, target PW cannot be wizard!"; exit 3; }

date1=$(date +"%s")

chmod u+x ./rsync

echo Provadim synchronizaci databazi ${BASEDB} do ${COPYDB} - 1. beh

if [ -d "/var/lib/mysql/${BASEDB}" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}/,${COPYDB}}
fi

if [ -d "/var/lib/mysql/${BASEDB}_temp" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}_temp/,${COPYDB}_temp}
fi

if [ -d "/var/lib/mysql/${BASEDB}_import" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}_import/,${COPYDB}_import}
fi

if [ -d "/var/lib/mysql/${BASEDB}_import_raw" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}_import_raw/,${COPYDB}_import_raw}
fi

echo Provadim FLUSH TABLES
/usr/bin/mysql -uroot -plopata -e "flush tables"

echo Provadim synchronizaci databazi ${BASEDB} do ${COPYDB} - 2. beh

if [ -d "/var/lib/mysql/${BASEDB}" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}/,${COPYDB}}
fi

if [ -d "/var/lib/mysql/${BASEDB}_temp" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}_temp/,${COPYDB}_temp}
fi
  
if [ -d "/var/lib/mysql/${BASEDB}_import" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}_import/,${COPYDB}_import}
fi
  
if [ -d "/var/lib/mysql/${BASEDB}_import_raw" ]; then
  /usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/lib/mysql/{${BASEDB}_import_raw/,${COPYDB}_import_raw}
fi


echo Provadim synchronizaci zdrojaku ${BASEPW} do ${COPYPW}
/usr/bin/ionice -c3 ./rsync -ahW --delete --no-compress --info=progress2 /var/www/html/{${BASEPW}/,${COPYPW}}

# prenastavit pwm na nove instanci
echo Provadim upravu PWM /var/www/html/${COPYPW}/specific/settings/default/default.pwm
sed -i "s/${BASEDB}/${COPYDB}/g" /var/www/html/${COPYPW}/specific/settings/default/default.pwm
sed -i "s/${BASEDB}_temp/${COPYDB}_temp/g" /var/www/html/${COPYPW}/specific/settings/default/default.pwm
sed -i "s/${BASEDB}_import/${COPYDB}_import/g" /var/www/html/${COPYPW}/specific/settings/default/default.pwm
sed -i "s/${BASEDB}_import_raw/${COPYDB}_import_raw/g" /var/www/html/${COPYPW}/specific/settings/default/default.pwm
sed -i "s/live\: true/live\: false/g" /var/www/html/${COPYPW}/specific/settings/default/default.pwm
sed -i "s/mwdb_export_host: mwdb/mwdb_export_host: mwdb-test/g" /var/www/html/${COPYPW}/specific/settings/default/default.pwm


echo "------------------------------------------------------"

date2=$(date +"%s")
diff=$(($date2-$date1))
echo "Sync trval: $(($diff / 60)) minut a $(($diff % 60)) sekund. Muzes makat :)"
