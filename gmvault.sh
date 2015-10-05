#!/bin/bash
export CMD=gmvault sync -d /db $GMVAULT_EMAIL_ADDR

echo #####
echo # FIRST RUN SETUP
echo You must provide your GMail credentials using OAuth. Attach to this container and run the following command interactively:
echo    $CMD
echo Once you provide an authentication token, the synchronization will start. Control-C to stop that, then edit the file 

/bin/bash

echo Backing up $GMVAULT_EMAIL_ADDR
$CMD
