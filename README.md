# Overview
Very small image based on Alpine Linux that uses cron to run gmvault on a daily basis.

Quick syncs are performed every night, full syncs are performed weekly. Additionally, a sync is performed on container startup (unless the `GMVAULT_SKIP_STARTUP_SYNC` environment variable is set).

# First Run Setup
First, note the required `GMVAULT_EMAIL_ADDR` environment variable.

Then, on the first run of the container, authentication credentials will not be present so the container will simply idle.
You should attach to the running container and specify your credentials using the following command:

    su -c \"gmvault sync -d /data ${GMVAULT_EMAIL_ADDR}\" abc

This will give you a URL that you can copy and paste into a web browser. Once you sign in, GMail will provide you with
"keys" that you can enter in the container window for authentication.

Once this is done, the first synchronization will start. Control-C to stop that, then restart the container.

# Environment Variables
The container is configurable through the following environment variables:

* `GMVAULT_EMAIL_ADDR` : ( **required** ) email address to back up
* `GMVAULT_UID` : (optional) numeric uid in the host that should own created files
* `GMVAULT_GID` : (optional) numeric gid in the host that should own created files
* `GMVAULT_SKIP_STARTUP_SYNC` : (optional) if specified (with any value), gmvault will not run on image startup--it will only run via cron
* `GMVAULT_TZ` : (optional) timezone; defaults to America/New_York

