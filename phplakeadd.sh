#!/bin/bash

# Static vars
ENV="dev"
CLOUD=".phplake.com"

# Arguments from console
USERNAME=$1
PROJECT=$2
URL=$3

# Dynamic vars from arguments
DOCROOT=/var/www/html/$ENV-$PROJECT-$USERNAME$CLOUD
DOCIDE=/var/www/html/ide-$USERNAME$CLOUD

if ! id -u $USERNAME > /dev/null 2>&1; then
    useradd -m $USERNAME
    git clone https://github.com/washim/Codiad.git $DOCIDE
    chown -Rf $USERNAME:$USERNAME $DOCIDE
    chmod 755 -R $DOCIDE
fi

git clone $URL $DOCROOT
chown -Rf $USERNAME:$USERNAME $DOCROOT
chmod 755 -R $DOCROOT

ln -s $DOCROOT $DOCIDE/workspace/
