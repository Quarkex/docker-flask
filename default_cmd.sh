#!/bin/bash

if [[ -e /app/default_cmd.sh ]]; then
    rm /app/default_cmd.sh
fi

if [[ -e /app ]]; then
    if [[ ! -e /mnt/app ]]; then
        mv -n /app/* /mnt/.
    fi
    rm -fr /app
fi

# check if files are different
diff -N /var/cache/pip_cache /mnt/requirements.txt &>/dev/null
#if they are...
if [[ $? == 1 ]]; then
    cp /mnt/requirements.txt /var/cache/pip_cache
    pip install -r /mnt/requirements.txt
fi

if [[ -f /mnt/app.py ]]; then

    /usr/bin/env python3 /mnt/app.py
else
    exec bash
fi
