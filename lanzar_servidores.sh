#!/bin/bash

# Navegar al directorio raíz del proyecto
cd /mnt/d/home-2/Documentos/master/cloud_computer/APIS

# Array para almacenar los PIDs de los procesos
pids=()

# Función para ejecutar un comando en segundo plano
run_background() {
    echo "Iniciando $1..."
    $2 &
    pids+=($!)
    sleep 2
}

# Función para detener todos los servidores
stop_servers() {
    echo "Deteniendo servidores..."
    for pid in "${pids[@]}"; do
        kill $pid 2>/dev/null
    done
    exit 0
}

# Capturar señal SIGINT (Ctrl+C)
trap stop_servers SIGINT

# Lanzar servidor REST
cd api_rest
run_background "servidor REST" "python app.py"

# Lanzar servidor gRPC
cd ../api_gRPC
run_background "servidor gRPC" "python server.py"

# Lanzar consumidor de Kafka
cd ../api_kafka
run_background "consumidor de Kafka" "python consumer.py"

echo "Todos los servidores han sido lanzados."
echo "Presiona Ctrl+C para detener todos los servidores."

# Esperar indefinidamente
wait
