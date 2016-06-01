#!/bin/bash

# Static vars
ENV="dev"
EXT=".conf"
ERRORLOG="_error_log"
ACCESSLOG="_access_log"

# Arguments from console
USERNAME=$1
PROJECT=$2

# Dynamic vars from arguments
USERPATH=/home/$USERNAME
WORKSPACE=$USERPATH/public_html
DOCFOLDER=$ENV-$PROJECT-$USERNAME
DOCROOT=$WORKSPACE/$DOCFOLDER
DOCROOTFILE=/etc/httpd/conf.d/$DOCFOLDER$EXT

if ! id -u $USERNAME > /dev/null 2>&1; then
    useradd -m $USERNAME
    mkdir $USERPATH/logs
    touch $USERPATH/logs/$DOCFOLDER$ERRORLOG
    touch $USERPATH/logs/$DOCFOLDER$ACCESSLOG
    git clone https://github.com/washim/techsupport.git $DOCROOT
else
    git clone https://github.com/washim/techsupport.git $DOCROOT
    touch $USERPATH/logs/$DOCFOLDER$ERRORLOG
    touch $USERPATH/logs/$DOCFOLDER$ACCESSLOG
fi

if [ ! -f $DOCROOTFILE ]; then
cat > $DOCROOTFILE << EOF
<VirtualHost 23.250.18.145:80>
    ServerName $DOCFOLDER.phplake.com
    ServerAdmin info@phplake.com
    DocumentRoot "/home/$USERNAME/public_html/$DOCFOLDER"
    DirectoryIndex index.php index.html
    suPHP_AddHandler x-httpd-php
    AddHandler x-httpd-php .php .php3 .php4 .php5
    ErrorLog /home/$USERNAME/logs/$DOCFOLDER$ERRORLOG
    CustomLog /home/$USERNAME/logs/$DOCFOLDER$ACCESSLOG combined
    <Directory "/home/$USERNAME/public_html/$DOCFOLDER">
       Options +Indexes FollowSymlinks
       AllowOverride All
       Order allow,deny
       Allow from all
    </Directory>
</VirtualHost>
EOF
fi
chown -Rf $USERNAME:$USERNAME $USERPATH
find /home/$USERNAME -type d -exec chmod 755 {} \;
find /home/$USERNAME -type f -exec chmod 755 {} \;
service httpd reload
