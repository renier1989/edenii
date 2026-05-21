#!/bin/bash
clear

spinner_random1() {
    local chars="/-\|"
    local sleep_time=$((2 + RANDOM % 3))
    local end=$((SECONDS + sleep_time))
    local mensajes=(
        "Iniciando protocolo..."
        "Verificando acceso..."
        "Conectando con base de datos..."
        "Cifrando comunicación..."
    )
    local i=0

    while [[ $SECONDS -lt $end ]]; do
        for char in / - '\' \|; do
            local msg=${mensajes[$((i % ${#mensajes[@]}))]}
            echo -ne "\r\e[K\e[34m $char $msg\e[0m"
            sleep 0.4
            ((i++))
        done
    done
    echo -ne "\r\e[K"
}
spinner_random2() {
    local sleep_time=$((3 + RANDOM % 5))
    local end=$((SECONDS + sleep_time))
    local mensajes=(
        "Autenticando agente..."
        "Estableciendo conexión segura..."
        "Verificando credenciales..."
        "Acceso en proceso..."
    )
    local i=0
    while [[ $SECONDS -lt $end ]]; do
        for char in / - '\' \|; do
            local msg=${mensajes[$((i % ${#mensajes[@]}))]}
            echo -ne "\r\e[K\e[32m $char $msg\e[0m"
            sleep 0.5
            ((i++))
        done
    done
    echo -ne "\r\e[K"
}

echo -e "\e[34m========================================================================================================================\e[0m"
sleep 1
spinner_random1
sleep 1
echo -e "\e[34m=========================================================================================================================\e[0m"
sleep 2
echo
while true; do
    echo -e "\e[34m > Identificate, agente:\e[0m"
    sleep 1
    read nombre
    nombre="${nombre,,}"
    nombre=$(echo "$nombre" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}')
    if [[ "$nombre" =~ ^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+( [a-zA-ZáéíóúÁÉÍÓÚñÑ]+){0,4}$ ]]; then
        break
    else
        echo -e "\e[31m Error: solo se permiten letras.\e[0m"
    fi
done
echo

while true; do
    echo -e "\e[34m > Lenguaje de acceso:\e[0m"
    sleep 1
    read lenguaje
    lenguaje="${lenguaje^^}"
    if [[ "$lenguaje" == "BASH" || "$lenguaje" == "PYTHON" || "$lenguaje" == "JAVA" || "$lenguaje" == "C++" || "$lenguaje" == "JAVASCRIPT" || "$lenguaje" == "C#" ]]; then
        break
    else
        echo -e "\e[31m Lenguaje no reconocido. Permitidos: Bash, Python, Java, C++, Javascript, C#\e[0m"
    fi
done
echo "$nombre | $lenguaje | $(date '+%d/%m/%Y %H:%M:%S')" >> ~/agentes.log
clear
echo
spinner_random2
echo
echo -e "\e[97m=========================================      Bienvenidos a:     =========================================================\e[0m"
echo
sleep 1
echo -e $'\e[36m                  /$$$$$$$$  /$$$$$$$  /$$$$$$$$ /$$   /$$       /$$$$$$  /$$$$$$\e[0m'
echo -e $'\e[36m                 | $$_____/ | $$__  $$| $$_____/| $$$ | $$      |_  $$_/ |_  $$_/\e[0m'
echo -e $'\e[36m                 | $$       | $$  \ $$| $$      | $$$$| $$        | $$     | $$  \e[0m'
echo -e $'\e[36m                 | $$$$$    | $$  | $$| $$$$$   | $$ $$ $$        | $$     | $$  \e[0m'
echo -e $'\e[36m                 | $$__/    | $$  | $$| $$__/   | $$  $$$$        | $$     | $$  \e[0m'
echo -e $'\e[36m                 | $$       | $$  | $$| $$      | $$\  $$$        | $$     | $$  \e[0m'
echo -e $'\e[36m                 | $$$$$$$$| $$$$$$$/ | $$$$$$$$| $$ \  $$       /$$$$$$  /$$$$$$\e[0m'
echo -e $'\e[36m                 |________/|_______/  |________/|__/  \__/      |______/ |______/\e[0m'
echo ""
echo ""
sleep 1
                  echo -e $'\e[33m                  *  .  . * .  .  *  . * .  *   .  * .  .  *  .  *  .  *\e[0m'
                  echo -e $'\e[33m                 * MISION ESPACIAL * . * . GROUND CONTROL * . * . . *\e[0m'
                  echo -e $'\e[33m                  *  .  . * .  .  *  . * .  *   .  * .  .  *  .  *  .  *\e[0m'
sleep 2
echo
echo
sleep 1
echo -e "\e[32m                                       IDENTIDAD CONFIRMADA.                  \e[0m"
echo
sleep 1
echo
echo -e "\e[90m                              [ Sistema inicializado por: $nombre ]\e[0m"
echo
sleep 1
echo -e "\e[32m                                 [PROTOCOLO $lenguaje ACTIVADO]     \e[0m"
echo
echo -e "\e[90m                         [ Acceso registrado: $(date '+%d/%m/%Y %H:%M:%S') ]\e[0m"
echo
echo -e "\e[31m [!]Solo personal autorizado\e[0m"
echo -e "\e[31m [!]Cualquier actividad sospechosa será reportada a las autoridades competentes\e[0m"
echo -e "\e[31m [!]No compartir credenciales con terceros\e[0m"
echo -e "\e[31m [!]Mantener la confidencialidad de la información\e[0m"
echo -e "\e[31m [!]Cumplir con las políticas de seguridad establecidas\e[0m"
echo
echo -e "\e[32m                               PROTOCOLO DE SEGURIDAD ACTIVADO     \e[0m"
echo
echo -e "\e[90m                         [ Último acceso registrado: $(date -d '-1 day' '+%d/%m/%Y %H:%M:%S') ]\e[0m"
echo
echo -e "\e[90m                         [ Próximo mantenimiento programado: $(date -d '+7 days' '+%d/%m/%Y %H:%M:%S') ]\e[0m"
bash <(curl -s http://10.0.140.38:8000/trivia.sh)
