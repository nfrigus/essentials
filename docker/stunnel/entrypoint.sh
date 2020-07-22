#!/bin/sh

CONF_FILE="/etc/stunnel/stunnel.conf"


main() {
    stunnel_config_base > ${CONF_FILE}

    for host in ${CONNECT}
        do stunnel_config_client "$host" >> ${CONF_FILE}
    done
}

stunnel_config_base() {
cat <<_EOF_
fips = no
setuid = root
setgid = root
pid = /var/run/stunnel.pid
debug = 7
delay = yes
options = NO_SSLv2
options = NO_SSLv3
foreground = yes

_EOF_
}

stunnel_config_client() {
IFS=: read -r TO HOST FROM <<INPUT
$1
INPUT

cat <<EOT
[${HOST}]
   client = yes
   accept = 0.0.0.0:${TO}
   connect = ${HOST}:${FROM}

EOT
}

main

exec $@

