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
    docker stop -t 1 debian-icewm-vnc
    docker rm debian-icewm-vnc
fi

echo "Se levanta el conetendor ${contenedor} desde la imagen  ${image_tag} en el puerto ${port}"
#docker run --name debian-icewm-vnc -d -p 25901:5901 -p 25900:6901 debian-icewm-vnc
docker run --name ${contenedor} -d -p ${port}:6901 ${image_tag}
