#!/bin/bash

USERNAME=$1
PROJECT=$2
ENV="dev"
rm -rf /var/www/html/$ENV-$PROJECT-$USERNAME
