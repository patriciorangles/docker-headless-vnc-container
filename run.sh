#!/bin/bash
#
# Autor: Patricio Rangles
# Fecha: 2023-03-13, última actualización: 2024-12-05
# Descripción: Script para iniciar un contenedor Docker con opciones personalizables.
#

#!/bin/bash

# Mostrar ayuda
mostrar_ayuda() {
    echo "Uso: $0 [opciones]"
    echo
    echo "Opciones:"
    echo "  -t=, --tag=            Tag de la imagen Docker (por defecto: debian-icewm-vnc:latest)"
    echo "  -c=, --contenedor=     Nombre del contenedor (por defecto: debian-icewm-vnc)"
    echo "  -p=, --port=           Puerto para acceso web (por defecto: 6901)"
    echo "  -v=, --VNCPASSW=       Contraseña VNC (por defecto: vncpasswPR)"
    echo "  -x=, --EXTRA_PARAM=    Parámetros extra para Docker (con cuidado)"
    echo "  -d, --delete           Eliminar contenedor existente antes de iniciar"
    echo "  -P, --privileged       Iniciar el contenedor en modo privilegiado"
    echo "  -s, --AUTO_START       Habilitar auto-inicio en reinicio del servidor"
    echo "  -n, --network          Usar modo de red del host"
    echo "  -h, --help             Mostrar esta ayuda y salir"
    echo
    echo "Ejemplo:"
    echo "  $0 --tag=my-image:latest --contenedor=my-container --port=8080 --privileged --AUTO_START"
    exit 0
}

# Validar si no hay parámetros o si se solicita ayuda
if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
    mostrar_ayuda
fi

# Valores por defecto
image_tag="debian-icewm-vnc:latest"
contenedor="debian-icewm-vnc"
port="6901"
VNCPASSW="vncpasswPR"
AUTOSTART=""
privileged=""
network=""
EXTRAPARAM=""
delete="NO"

# Procesar parámetros
for i in "$@"; do
    case $i in
        -t=*|--tag=*)        image_tag="${i#*=}" ;;
        -c=*|--contenedor=*) contenedor="${i#*=}" ;;
        -p=*|--port=*)       port="${i#*=}" ;;
        -v=*|--VNCPASSW=*)   VNCPASSW="${i#*=}" ;;
        -x=*|--EXTRA_PARAM=*) EXTRAPARAM="${i#*=}" ;;
        -d|--delete)         delete="SI" ;;
        -P|--privileged)     privileged="--privileged" ;;
        -s|--AUTO_START)     AUTOSTART="-d --restart unless-stopped" ;;
        -n|--network)        network="--network host" ;;
        *) echo "Parámetro no reconocido: $i" ;;
    esac
done

# Eliminar contenedor existente si se especificó
if [ "$delete" = "SI" ]; then
    echo "Verificando si el contenedor ${contenedor} existe..."
    if docker ps -a --format '{{.Names}}' | grep -q "^${contenedor}$"; then
        echo "Eliminando contenedor existente: ${contenedor}"
        docker stop -t 1 "${contenedor}" 2>/dev/null
        docker rm "${contenedor}" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "Contenedor eliminado exitosamente."
        else
            echo "Error al eliminar el contenedor ${contenedor}."
        fi
    else
        echo "El contenedor ${contenedor} no existe, no es necesario eliminarlo."
    fi
fi

# Mensajes informativos
echo "Imagen: ${image_tag}"
echo "Contenedor: ${contenedor}"
echo "Puerto: ${port}"
echo "Contraseña VNC: ${VNCPASSW}"
echo "Parámetros extra: ${EXTRAPARAM}"
echo "Modo privilegiado: ${privileged:-NO}"
echo "Auto-inicio: ${AUTOSTART:-NO}"
echo "Modo red: ${network:-Bridge}"

# Comando final
PARAMETROS="${AUTOSTART} ${privileged} ${network} --name ${contenedor} -d -p ${port}:6901 -e VNC_PW=${VNCPASSW} ${EXTRAPARAM} ${image_tag}"
echo "Comando a ejecutar:"
echo "docker run ${PARAMETROS}"
docker run ${PARAMETROS}
