#!/bin/bash

genpasswd() {
    count=0
    while [ $count -lt 3 ]
    do
        pw_valid=$(tr -cd A-Za-z0-9 < /dev/urandom | fold -w24 | head -n1)
        count=$(grep -o "[0-9]" <<< $pw_valid | wc -l)
    done
    echo $pw_valid
}

CFG_SQLSERVER="MySQL"
CFG_MYSQL_ROOT_PWD=`genpasswd`
CFG_PMA_PWD=`genpasswd`
CFG_WEBSERVER="apache"
CFG_XCACHE="no"
CFG_PHPMYADMIN="yes"
CFG_MTA="dovecot"
CFG_AVUPDATE="yes"
CFG_QUOTA="n"
CFG_ISPC="standard"
CFG_JKIT="n"
CFG_DKIM="y"
SSL_COUNTRY="FR"
SSL_STATE="Paris"
SSL_LOCALITY="Paris"
SSL_ORGANIZATION=$CFG_HOSTNAME_FQDN
SSL_ORGUNIT="ISPConfig"

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $CFG_PMA_PWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $CFG_MYSQL_ROOT_PWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $CFG_PMA_PWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
