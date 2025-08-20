#!/bin/bash
set -e

SRC="./arcade"
DEST="/var/www/kidsplay"

rsync -av --delete $SRC/games $DEST/
rsync -av $SRC/games.json $DEST/
rsync -av $SRC/common/* $DEST/common/

echo "Arcade e catalogo deployati"
