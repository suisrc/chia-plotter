#!/bin/bash


# The param
ARG=`sed -n 1p _ctm.txt`
if [ ${ARG}x = ''x ]; then
    read ARG < _arg.txt
fi
# The farmer public key
FPK=`sed -n 2p _ctm.txt`
if [ ${FPK}x = ''x ]; then
    read FPK < _fpk.txt
fi
# The pool public key
PPK=`sed -n 3p _ctm.txt`
if [ ${PPK}x = ''x ]; then
    read PPK < _ppk.txt
fi

echo "chia plots create ${ARG} -t /tmp01 -2 /tmp02 -d /dst -f ${FPK} -p ${PPK}"

while [ ! -f /root/run/stop ]
do
  rm /tmp01/*.tmp /tmp02/*.tmp
  chia plots create ${ARG} -t /tmp01 -2 /tmp02 -d /dst -f ${FPK} -p ${PPK}
  sleep 30s
done
echo Stopfile found, exiting