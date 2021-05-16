#!/bin/bash

./clear.sh

python3 manager.py start

echo "Press CTRL+C to exit"
while true
do
  sleep 60
done