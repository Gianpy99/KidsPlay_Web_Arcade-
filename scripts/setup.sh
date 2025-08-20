#!/bin/bash
set -e

BASE="/var/www/kidsplay"
mkdir -p $BASE/{landing/figlio1,landing/figlio2,games,config,common}
chown -R www-data:www-data $BASE
chmod -R 755 $BASE

echo "Struttura base creata in $BASE"
