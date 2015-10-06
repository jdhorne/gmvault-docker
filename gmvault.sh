#!/bin/bash

OAUTH_TOKEN="/data/${GMVAULT_EMAIL_ADDR}.oauth2"


if [ ! "$(id -u abc)" -eq "$PUID" ]; then usermod -o -u "$PUID" abc ; fi
if [ ! "$(id -g abc)" -eq "$PGID" ]; then groupmod -o -g "$PGID" abc ; fi

chown -R abc:abc /data

if [ -f $OAUTH_TOKEN ]; then
	echo OAuth token located: $OAUTH_TOKEN
	echo running gmvault
	su -c "gmvault sync -d /data ${GMVAULT_EMAIL_ADDR}" abc
	exit
fi


echo #####
echo # FIRST RUN SETUP
echo #####
echo
echo OAuth token could not be located \($OAUTH_TOKEN\)
echo You must provide your GMail credentials using OAuth.
echo Attach to this container and run the following command interactively:
echo
echo "   su -c \"gmvault sync -d /data ${GMVAULT_EMAIL_ADDR}\" abc"
echo
echo Once you provide an authentication token, the synchronization will start.
echo Control-C to stop that, then restart this container.
echo
echo Lacking the capability to anything more, pausing now for dramatic effect.

/bin/sh
