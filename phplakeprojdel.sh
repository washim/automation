#!/bin/bash

USERNAME=$1
PROJECT=$2
ENV="dev"
CLOUD=".phplake.com"
rm /var/www/html/ide-$USERNAME$CLOUD/workspace/$ENV-$PROJECT-$USERNAME$CLOUD
rm -rf /var/www/html/$ENV-$PROJECT-$USERNAME$CLOUD
