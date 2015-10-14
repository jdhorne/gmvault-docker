#!/bin/bash

OAUTH_TOKEN="/data/${GMVAULT_EMAIL_ADDR}.oauth2"
FIRST_RUN_FLAG=/app/.first_run

if [ "$GMVAULT_TZ" = "" ] ; then GMVAULT_TZ="America/New_York" ; fi
setup-timezone -z $GMVAULT_TZ > /dev/null
echo `date`  timezone: $GMVAULT_TZ


if [ ! "$(id -u abc)" -eq "$PUID" ]; then usermod -o -u "$PUID" abc ; fi
if [ ! "$(id -g abc)" -eq "$PGID" ]; then groupmod -o -g "$PGID" abc ; fi

chown -R abc:abc /data

if [ -f $OAUTH_TOKEN ]; then
	echo OAuth token located: $OAUTH_TOKEN

	if [ "$GMVAULT_SKIP_STARTUP_SYNC" = "" ]; then
		if [ -f $FIRST_RUN_FLAG ]; then
			echo first run\; forcing full sync
			/etc/periodic/weekly/weekly-backup
			rm $FIRST_RUN_FLAG
		elif [ -d /data/db ]; then
			echo existing database directory found\; running quick sync
			/etc/periodic/daily/daily-backup
		else
			echo no existing database found\; running full sync
			/etc/periodic/weekly/weekly-backup
		fi
	else
		echo skipping sync on startup
	fi

	# let cron take over from here
	exec crond -f -d 7
fi


touch $FIRST_RUN_FLAG

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
