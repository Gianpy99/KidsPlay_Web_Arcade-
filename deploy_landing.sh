#!/bin/bash
set -e

SRC="./landing"
DEST="/var/www/kidsplay/landing"

rsync -av --delete $SRC/figlio1 $DEST/
rsync -av --delete $SRC/figlio2 $DEST/

echo "Landing pages deployate"
