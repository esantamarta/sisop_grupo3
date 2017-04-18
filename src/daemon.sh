#!/bin/bash

#Desarrollo del daemon

WAIT=3

echo "Iniciando Daemon"

LOOPS=1

while true
do
	echo "Loop nro: $LOOPS"
	LOOPS=$(($LOOPS+1))
	sleep $WAIT
done

echo "chau"
