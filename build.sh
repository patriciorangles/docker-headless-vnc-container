#!/bin/bash
#
# Autor: Patricio Rangles
#
# 2023-03-13: Script que construye la imagen del archivo Dockerfile.debian-icewm-vnc
#
# Parametros de entrada:
#
#	-t=,--tag= : Tag a usar para esta imagen, por defecto: debian-icewm-vnc:latest

for i in "$@"
do
case $i in

    -t=*|--tag=*)
    image_tag="${i#*=}"
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
    echo "Se usuara el tag indicado por linea de comandos:" 
    echo ${image_tag}
fi

docker build -t ${image_tag} -f ./Dockerfile.debian-icewm-vnc .

