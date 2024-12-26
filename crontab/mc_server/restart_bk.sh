
#!/bin/bash

# Funzione per riavviare un container e loggare l'output con timestamp
restart_and_log() {
    local container_name="$1"
    local log_file="$2"

    if [[ -z "$container_name" || -z "$log_file" ]]; then
        echo "Uso: restart_and_log <nome_container> <file_di_log>" >> "$log_file"
        return 1
    fi

    # Esegui il comando docker e aggiungi timestamp all'output
    docker restart "$container_name" 2>&1 | while read -r line; do
        echo "$(date '+%Y-%m-%d %H:%M:%S') [$container_name] $line" >> "$log_file"
    done
}

# Parametri dello script
LOG_FILE="/home/pat/first_child/crontab/mc_server/log.txt"
CONTAINER_NAME="minecraft-server"

echo "$(date '+%Y-%m-%d %H:%M:%S') SWAP IMMAGINI" >> "$LOG_FILE"
docker exec "$CONTAINER_NAME" bash /app/PAT/scripts/icoNmotd_swapper/swapper.sh >> "$LOG_FILE"

echo "$(date '+%Y-%m-%d %H:%M:%S') RIAVVIO CONTAINER $CONTAINER_NAME" >> "$LOG_FILE"

# Chiamata alla funzione
restart_and_log "$CONTAINER_NAME" "$LOG_FILE"
echo "(date '+%Y-%m-%d %H:%M:%S') FINE\n" >> "$LOG_FILE"
