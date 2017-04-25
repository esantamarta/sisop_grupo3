# sisop_grupo3
TP Grupo 3 - Sistemas Operativos - FIUBA

######### CONTENIDO #########

Para descomprimir el instalador utilizar el siguiente comando:
tar -zxvf filename.tgz

El mismo creará la carpeta Grupo03 que contendrá los siguientes archivos:
Setup
Init
Logger
Demon
Stop_Daemon
/dirconf 
/Datos (directorio con tablas y maestros)


######### REQUISITOS #########
-El usuario debe tener permiso de escritura sobre el directorio.


######### INSTALACION #########

Para instalar el sistema ubiquese en el directorio Grupo03 y ejecute: 
./Setup
Luego seguir los pasos indicados en la pantalla que lo guiarán en la instalación del sistema

Si el proceso de instalación finaliza correctamente se crearán los siguientes directorios (los nombres pueden ser modificados durante el proceso de instalación).
bin (incluye los ejecutables)
aceptados
log
maestro
novedades
procesados
rechazados
reportes
/dirconf/Setup.conf
/dirconf/Setup.log


######### EJECUCIÓN #########
Antes de ejecutar el sistema deberá inicializarlo mediante el proceso Inicializador, para eso deberá ejecutar, desde el directorio bin, el siguiente comando:
. ./Init ../dirconf/Setup.conf

Una vez inicializada la aplicación podrá lanzar el proceso Demonep con el comando:
./Deamon &

En caso de querer detener el proceso Demonep deberá ejecutar:
./Stop_Daemon Deamon
