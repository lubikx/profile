#!/bin/bash
./pwsync.sh jablotron_live jablotron_test wizard test
sed -i "s/Jablotron/Jablotron TEST/g" /var/www/html/test/specific/settings/default/default.pwm

# napojeni na testovaci mwdb, pozadavek #34855 od dana springla
sed -i "s/mwdb_host: mwdb/mwdb_host: mwdb-test/g" /var/www/html/test/specific/settings/default/default.pwm
