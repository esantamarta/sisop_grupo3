#!/bin/bash

#Recibe el id de un proceso en ejecucion por parametro y lo cierra
echo "Terminando el proceso $1"
kill $1