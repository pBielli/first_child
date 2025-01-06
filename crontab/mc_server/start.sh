#!/bin/bash

# Funzione per avviare un container con messaggi migliorati
start_container() {
    local container_name="$1"

    if [[ -z "$container_name" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Nome del container non fornito."
        return 1
    fi

    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Tentativo di avvio del container: $container_name"

    # Riavvia il container e gestisci l'output
    if docker start "$container_name" 2>&1; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Container $container_name avviato con successo."
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Avvio del container $container_name fallito."
    fi
}

# Nome del container
CONTAINER_NAME="minecraft-server-v2"

# Avvia il container
start_container "$CONTAINER_NAME"

# Log finale
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Fine esecuzione script.\n"
