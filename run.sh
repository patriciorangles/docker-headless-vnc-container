#!/bin/bash
#
# Autor: Patricio Rangles
#
# 2023-03-13: Script que inicia un contenedor con un nombre dado a partir de la imagen indicada
#             Tomar en cuenta que para iniciar el contenedor el scrip borra el contenedor existente
#
# Parametros de entrada:
#
#	-t=,--tag= : Tag a usar para la imagen, por defecto: debian-icewm-vnc:latest
#	-c=,--contenedor= : nombre a usar para este contenedor, por defecto: debian-icewm-vnc
#   -p=,--port=: Indica el nombre del puerto que se usara para el acceso web
#   -d,--delete : indica si se debe o no eliminar el contenedor existente
#   -P,--privileged : Indica que el contenedor se iniciara en modo privilegiado
#   -v=,--VNCPASSW=: Indica el password con el que se podra acceder via VNC
#   -s,--AUTO_START: Indica que autoiniciara en caso de que el servidor sea reiniciado
#   -x=,--EXTRA_PARAM=: Parametros extras que se usaran ara el lanzamiento del contenedor
#                       USAR CON CUIDADO, se lo envia directo al comando de docker!!
#
#   NOTA: la imagen tiene la carpeta /headless/host_volumen que puede ser usada para montar cualquier 
#         carpeta del host dentro del contenedor, por ejemplo:
#         el home del usuario -v $HOME:/headless/host_volumen
#         la carpeta raiz del sistema -v /:/headless/host_volumen
#
#

for i in "$@"
do
case $i in

    -t=*|--tag=*)
    image_tag="${i#*=}"
    shift # past argument=value
    ;;

    -c=*|--contenedor=*)
    contenedor="${i#*=}"
    shift # past argument=value
    ;;

    -p=*|--port=*)
    port="${i#*=}"
    shift # past argument=value
    ;;

    -d|--delete)
    delete="SI"
    shift # past argument=value
    ;;

    -P|--privileged)
    privileged="--privileged"
    shift # past argument=value
    ;;

    -v=*|--VNCPASSW=*)
    VNCPASSW="${i#*=}"
    shift # past argument=value
    ;;

    -s|--AUTO_START)
    AUTOSTART="-d --restart unless-stopped"
    shift # past argument=value
    ;;

    -x=*|--EXTRA_PARAM=*)
    EXTRAPARAM="${i#*=}"
    shift # past argument=value
    ;;

    *)
            # unknown option
    ;;
esac
done

# Analisis del tag
if [ -z ${image_tag+x} ]; then 
    echo "Se usara el tag por defecto: debian-icewm-vnc:latest"
    image_tag="debian-icewm-vnc:latest"
else 
    echo "Se usara el tag indicado por linea de comandos:" 
    echo ${image_tag}
fi

# Analisis del contenedor
if [ -z ${contenedor+x} ]; then 
    echo "Se usara el nombre de contenedor por defecto: debian-icewm-vnc"
    contenedor="debian-icewm-vnc"
else 
    echo "Se usara el nombre de contenedor indicado por linea de comandos:" 
    echo ${contenedor}
fi

# Analisis del puerto
if [ -z ${port+x} ]; then 
    echo "Se usara el puerto por defecto: 6901"
    port="6901"
else 
    echo "Se usara el puerto indicado por linea de comandos:" 
    echo ${port}
fi

# Analisis de la eliminacion previa
if [ -z ${delete+x} ]; then
	echo "En caso de existir el contenedor se lo preserva!"
else
    echo "Se elimina el contenedor antes de lanzarlo: ${contenedor}"
    docker stop -t 1 ${contenedor}
    docker rm ${contenedor}
fi

# Analisis del modo privileged
if [ -z ${privileged+x} ]; then
	echo "El contendor correra en modo SIN PRIVILEGIOS!"
    privileged=""
else
    echo "El contenedor correra en modo PRIVILEGED"
    privileged="--privileged"
fi

# Analisis del password
if [ -z ${VNCPASSW+x} ]; then 
    echo "Se usara el password por defecto: vncpasswPR"
    VNCPASSW="vncpasswPR"
else 
    echo "Se usara el password indicado por linea de comandos:" 
    echo ${VNCPASSW}
fi

# Analisis del los parametros extras
if [ -z ${EXTRAPARAM+x} ]; then 
    echo "Sin parametros extras"
    EXTRAPARAM=""
else 
    echo "Se usaran los siguientes parametros extras para iniciar docker:" 
    echo ${EXTRAPARAM}
fi

# Analisis del los parametros extras
if [ -z ${AUTOSTART+x} ]; then 
    echo "Sin autoinicio para este contenedor"
    AUTOSTART=""
else 
    echo "Se usara la opcion de auto inicio para este contenedor:" 
    echo ${AUTOSTART}
fi

echo "Se levanta el contendor ${contenedor} desde la imagen  ${image_tag} en el puerto ${port}"
PARAMETROS="${AUTOSTART} ${privileged} --name ${contenedor} -d -p ${port}:6901 -e VNC_PW=${VNCPASSW} ${EXTRAPARAM} ${image_tag}"
echo "Comando a ejecutar:"
echo "docker run ${PARAMETROS}"
docker run ${PARAMETROS}
