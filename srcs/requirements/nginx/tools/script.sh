#!/bin/bash

sed -i 's|\<CERTIFICATE\>|'"$CERTIFICATE"'|g' /etc/nginx/conf.d/nginx.conf
sed -i 's|\<CERTIFICATE_KEY\>|'"$CERTIFICATE_KEY"'|g' /etc/nginx/conf.d/nginx.conf

echo "Starting nginx!"
nginx -g "daemon off;"
