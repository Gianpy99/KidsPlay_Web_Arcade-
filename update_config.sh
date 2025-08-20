#!/bin/bash
set -e

SRC="./config"
DEST="/var/www/kidsplay/config"

rsync -av $SRC/*.json $DEST/

echo "Config aggiornati"
