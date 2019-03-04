#!/bin/bash
recordFile=/tmp/switch-monitor-record
value=$(<$recordFile)
echo "value:$value"
if [ "$value" == 5 ]; then
    echo "15">$recordFile
else
    echo "5">$recordFile
fi
/usr/local/bin/ddcctl -d 1 -i $value
