#!/bin/bash

set -e

python3 update.py

echo "Starting Aria2..."
aria2c --conf-path=/usr/src/app/a2c.conf

echo "Waiting for Aria2 RPC..."

for i in {1..30}; do
    if python3 -c "import socket; s=socket.socket(); s.settimeout(1); s.connect(('127.0.0.1',6800)); s.close()" 2>/dev/null; then
        echo "Aria2 RPC is ready!"
        break
    fi
    sleep 1
done

python3 -m bot
