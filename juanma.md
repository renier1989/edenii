## Nivel 2

Script que hace un mini-recon: muestra tu IP, hostname, espacio
en disco, RAM libre, último login. Con barras de progreso fake.


```bash

#!/bin/bash

# Colores
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Restaurar cursor al salir (Ctrl+C)
trap "tput cnorm; exit" INT

spinner_random() {
    local chars="/-\|"
    local sleep_time=$((1 + RANDOM % 3)) 
    local end=$((SECONDS + sleep_time))
    tput civis
    while [ $SECONDS -lt $end ]; do
        for i in {0..3}; do
            echo -ne "\r[${chars:$i:1}] ${CYAN}Analizando...${NC}"
            sleep 0.1
        done
    done
    echo -ne "\r\033[K"
    tput cnorm
}

clear
echo -e "${GREEN}Iniciando mini-recon para:${NC} $USER"
spinner_random

#Verificar usuario root si o no

if [[ $EUID -eq 0 ]]; then
        echo -e "${GREEN}Eres usuario root"
else 
        echo -e "${GREEN}No eres usuario root"
fi

#echo -e "${GREEN}No eres usuario root"
spinner_random
# --- Información de Sistema ---
echo -e "${YELLOW}>>> SISTEMA${NC}"
echo "Hostname:    $(hostname)"

# IP: Busca IPs IPv4 activas excluyendo 127.0.0.1
echo "Interfaces:  $(ip -br addr show | grep UP | awk '{print $1 " (" $3 ")"}')"

spinner_random

# --- Información de Memoria ---
echo -e "\n${YELLOW}>>> MEMORIA${NC}"
free -h | awk '/Mem:/ { print "Total:      " $2 "\nEn uso:     " $3 "\nDisponible: " $4 }'

spinner_random
# --- Información de Disco ---
echo -e "\n${YELLOW}>>> DISCO (Raíz)${NC}"
df -h / | awk 'NR==2 { print "Tamaño:     " $2 "\nDisponible: " $4 "\nUso:        " $5 }'

spinner_random

# --- Último Login ---
echo -e "\n${YELLOW}>>> SEGURIDAD${NC}"
last -n 1 | head -n 1 | awk '{print "Último acceso: " $1 " el " $4 " " $5 " " $6}'

echo -e "\n${GREEN}Reconocimiento finalizado.${NC}"

```