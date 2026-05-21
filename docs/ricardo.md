```bash
#!/bash/bin

# 1. Lista de los 15 comandos más usados en Ubuntu
lista_comandos=(
    "ls|Listar archivos y carpetas"
    "cd|Cambiar de directorio"
    "sudo|Ejecutar como superusuario"
    "apt|Gestionar paquetes de software"
    "pwd|Mostrar ruta del directorio actual"
    "mkdir|Crear un nuevo directorio"
    "rm|Eliminar archivos o directorios"
    "cp|Copiar archivos o directorios"
    "mv|Mover o renombrar archivos"
    "cat|Mostrar contenido de un archivo"
    "grep|Buscar texto dentro de archivos"
    "chmod|Cambiar permisos de archivos"
    "chown|Cambiar dueño de un archivo"
    "top|Ver procesos del sistema en tiempo real"
    "man|Ver el manual de un comando"
)

echo ""

# 2. Selección aleatoria de 10 índices únicos
shuffled_indexes=($(shuf -i 0-14 -n 10))

puntaje=0
num_pregunta=1  # Inicializamos el contador de preguntas

sleep 5
clear

echo "===================================================="
echo "   EXAMEN DE COMANDOS UBUNTU - ¡DEMUESTRA TU NIVEL! "
echo "===================================================="

for idx in "${shuffled_indexes[@]}"; do
    # Extraer comando (pregunta) y respuesta correcta
    linea="${lista_comandos[$idx]}"
    comando=$(echo "$linea" | cut -d'|' -f1)
    correcta=$(echo "$linea" | cut -d'|' -f2)

    # 3. Generar dos distractores (respuestas falsas) aleatorios
    falsa1_idx=$idx
    while [ "$falsa1_idx" -eq "$idx" ]; do
        falsa1_idx=$((RANDOM % 15))
    done
    falsa1=$(echo "${lista_comandos[$falsa1_idx]}" | cut -d'|' -f2)

    falsa2_idx=$idx
    while [ "$falsa2_idx" -eq "$idx" ] || [ "$falsa2_idx" -eq "$falsa1_idx" ]; do
        falsa2_idx=$((RANDOM % 15))
    done
    falsa2=$(echo "${lista_comandos[$falsa2_idx]}" | cut -d'|' -f2)

    # 4. Mezclar las opciones (Correcta, Falsa1, Falsa2)
    opciones=("$correcta" "$falsa1" "$falsa2")
    # shuf -e devuelve los índices 0, 1, 2 en orden aleatorio
    shuffled_ops=($(shuf -e 0 1 2))

    # Numeración de la pregunta
    echo -e "\nPregunta $num_pregunta de 10:"
    echo "---------------------------"
    echo "¿Qué hace el comando: '$comando'?"
    
    # Mostrar opciones rotuladas como a, b, c
    letras=(a b c)
    for i in {0..2}; do
        oi=${shuffled_ops[$i]}
        echo "${letras[$i]}) ${opciones[$oi]}"
        # Identificar cuál letra quedó asignada a la respuesta correcta (indice 0)
        if [ "$oi" -eq 0 ]; then respuesta_correcta="${letras[$i]}"; fi
    done

    # 5. Entrada del usuario
    read -p "Tu respuesta (a/b/c): " user_input
    # Convertir a minúscula
    user_input="${user_input,,}"
    if [ "$user_input" == "$respuesta_correcta" ]; then
        echo "✅ ¡Correcto!"
        ((puntaje++))
    else
        echo "❌ Incorrecto. La respuesta era: $respuesta_correcta) $correcta"
    fi

    ((num_pregunta++)) # Incrementar el número de la pregunta para la siguiente vuelta
done

# 6. Resultado Final
echo -e "\n===================================================="
echo "   CUESTIONARIO FINALIZADO"
echo "   Tu puntaje total es: $puntaje de 10"
echo "===================================================="

VERDE='\033[1;32m'
NARANJA='\033[1;33m'
ROJO='\033[1;31m'
SIN_COLOR='\033[0m' # Es vital para que el color no "se derrame" al resto del texto

# Mensaje motivador según puntaje
if [ $puntaje -ge 8 ]; then
    echo -e "¡Excelente! Eres un ${VERDE}MAESTRO${SIN_COLOR}"
#    echo "¡Excelente! Eres un MAESTRO."
elif [ $puntaje -ge 5 ]; then
    echo -e "Buen trabajo, sigue practicando, eres un ${NARANJA}JEDI${SIN_COLOR}"
else
    echo -e "Necesitas estudiar más, eres un ${ROJO}PADAWAN${SIN_COLOR}"
fi

echo ""
```

![alt text](../img/diagrama-ricardo.png)