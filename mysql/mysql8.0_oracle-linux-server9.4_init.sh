#!/bin/bash

#[Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed
# in a future release. Please use SET GLOBAL host_cache_size=0 instead.
# Fix:

if [ -f /etc/my.cnf ]; then
    printf "\n/etc/my.cnf exists\n"
    has_skip=$(cat /etc/my.cnf | grep skip-host-cache)
    if [ "${has_skip}" ]; then
        printf "\n/etc/my.cnf has skip-host-cache so replacing with host_cache_size=0\n"
        sed -i 's/skip-host-cache/host_cache_size=0/g' /etc/my.cnf
    else
        printf "\n/etc/my.cnf does not have skip-host-cache\n"
        has_host=$(cat /etc/my.cnf | grep host_cache_size)
        if [ "${has_host}" ]; then
            printf "\n/etc/my.cnf has host_cache_size=0 so doing nothing\n"
        else
            printf "\n/etc/my.cnf does not have host_cache_size=0 so adding it\n"
            echo "host_cache_size=0" >> /etc/my.cnf
        fi
    fi
else
    printf "\nno /etc/my.cnf file found\n"
fi

