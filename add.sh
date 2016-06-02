#!/bin/bash

# Static vars
ENV="dev"
CLOUD=".phplake.com"

# Arguments from console
USERNAME=$1
PROJECT=$2

# Dynamic vars from arguments
DOCROOT=/var/www/html/$ENV-$PROJECT-$USERNAME$CLOUD

if ! id -u $USERNAME > /dev/null 2>&1; then
    useradd -m $USERNAME
fi

git clone https://github.com/washim/Codiad.git $DOCROOT
chown -Rf $USERNAME:$USERNAME $DOCROOT
chmod 755 -R $DOCROOT
