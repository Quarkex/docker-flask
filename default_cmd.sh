#!/bin/bash

if [[ -e /app/default_cmd.sh ]]; then
    rm /app/default_cmd.sh
fi

if [[ -e /app ]]; then
    if [[ ! -e /mnt/app ]]; then
        mv /app/* /mnt/.
        rmdir /app
    else
        rm -fr /app
    fi
fi

if [[ -f /mnt/app.py ]]; then

    if [[ -f /mnt/requirements.txt ]]; then
        if [[ -f /var/cache/pip_cache ]]; then
            # check if files are different
            diff /var/cache/pip_cache /mnt/requirements.txt 2&>/dev/null
            # if they are...
            if [[ $? == 1 ]]; then
                cp /mnt/requirements.txt /var/cache/pip_cache
                pip install -r /mnt/requirements.txt
            fi
        else
            cp /mnt/requirements.txt /var/cache/pip_cache
            pip install -r /mnt/requirements.txt
        fi
    fi

    /usr/bin/env python /mnt/app.py
else
    exec bash
fi
