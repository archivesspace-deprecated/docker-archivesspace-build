#!/bin/bash

cat /dev/null > /archivesspace/config/config.rb

if [[ "$ARCHIVESSPACE_DB_TYPE" == "mysql" ]]; then
  echo "AppConfig[:db_url] = 'jdbc:mysql://$DB_PORT_3306_TCP_ADDR:3306/$ARCHIVESSPACE_DB_NAME?user=$ARCHIVESSPACE_DB_USER&password=$ARCHIVESSPACE_DB_PASS&useUnicode=true&characterEncoding=UTF-8'" \
    >> /archivesspace/config/config.rb
  /archivesspace/scripts/setup-database.sh
fi

for PLUGIN in /archivesspace/plugins/*; do
  [[ -d $PLUGIN ]] && echo "AppConfig[:plugins] << '${PLUGIN##*/}'" >> /archivesspace/config/config.rb
done

exec /archivesspace/archivesspace.sh
