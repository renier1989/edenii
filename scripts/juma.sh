
#!/bin/bash

# Definición de la lista de IPs
nodos=("192.168.62.10" "192.168.62.20" "192.162.56" "192.168.62.102")

# Inicialización de listas (arrays)
activos=()
caidos=()
invalidos=()

# 1. Pensar: ¿Y si la lista está vacía?
if [ ${#nodos[@]} -eq 0 ]; then
    echo "Error: La lista de nodos está vacía."
    exit 1
fi

echo "Verificando estado de los nodos..."

# Expresión regular mejorada para formato IP
regex="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"

for ip in "${nodos[@]}"; do
    # -c 1: enviar solo 1 paquete
    # -W 1: esperar máximo 1 segundo la respuesta (timeout)

    if [[ ! "$ip" =~ $regex ]]; then
	echo " [?] Nodo $ip: NO VALIDO"
        invalidos+=("$ip")
    else
        if ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
            echo " [+] Nodo $ip: OK"
	    activos+=("$ip")
	else
	    echo " [-] Nodo $ip: CAÍDO"
	    caidos+=("$ip")
	fi
    fi
done

# --- Resultados finales ---
echo "------------------------------"
echo "Resumen del Cluster:"
echo "Nodos activos: ${#activos[@]}"
echo "Nodos caídos:  ${#caidos[@]}"
echo "Nodos invalidos:  ${#invalidos[@]}"

# 2. Pensar: ¿Y si ninguno responde?
if [ ${#activos[@]} -eq 0 ]; then
    echo "ALERTA: ¡Ningún nodo del cluster responde!"
fi

# Mostrar las listas si contienen elementos
[ ${#activos[@]} -gt 0 ] && echo "Lista activos: ${activos[*]}"
[ ${#caidos[@]} -gt 0 ] && echo "Lista caídos: ${caidos[*]}"
[ ${#invalidos[@]} -gt 0 ] && echo "Lista invalidos: ${invalidos[*]}"
