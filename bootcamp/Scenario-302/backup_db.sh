#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: hello
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2018-01-06>
## Updated: Time-stamp: <2018-01-06 20:07:36>
##-------------------------------------------------------------------
set -ex

if [ -f /etc/credential/password.txt ]; then
    db_password=$(cat /etc/credential/password.txt)
else
    db_password=${1?"DB password"}
fi

date_timestamp=$(date +'%Y%m%d_%H%M%S')
db_username="bn_wordpress"
db_host="my-wordpress-mariadb"
db_name="bitnami_wordpress"
db_port="3306"

backup_folder="/backup"
backup_sql_file="db_backup_${date_timestamp}.sql"

echo "mysqldump $db_name"
/usr/bin/mysqldump \
    "-u${db_username}" "-p${db_password}" \
    -P${db_port} -h"${db_host}" "${db_name}" \
    --result-file="${backup_folder}/${backup_sql_file}"
## File: hello ends
