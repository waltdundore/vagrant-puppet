#!/bin/bash

if [ "$HOSTNAME" -e 'pup.apidb.org' ]; then
    printf '%s\n' "NO! Do not run this on the guest. It is only to run in the vagrant host (and only then if needed)."
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi 
 
 firewall-cmd  --permanent --zone=libvirt --add-service=nfs
 firewall-cmd  --permanent --zone=libvirt --add-service=mountd
 firewall-cmd  --permanent --zone=libvirt --add-service=rpc-bind
 firewall-cmd  --permanent --zone=libvirt --add-port=2049/tcp
 firewall-cmd  --permanent --zone=libvirt --add-port=2049/udp
 firewall-cmd --reload 
