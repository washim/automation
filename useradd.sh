#!/bin/bash

USERNAME=$1
PASSWORD=$2
PROJECT=$3
USERPATH=/home/$USERNAME
WORKSPACE=$USERPATH/Codiad/workspace
DOCROOT=$WORKSPACE/$PROJECT

useradd $USERNAME -p $PASSWORD
cd $USERPATH
git clone https://github.com/Codiad/Codiad.git
cd $WORKSPACE
git clone https://github.com/washim/techsupport.git $PROJECT
chown -R $USERNAME:$USERNAME $DOCROOT
