#!/bin/bash

# Funzione per riavviare un container con messaggi migliorati
restart_container() {
    local container_name="$1"

    if [[ -z "$container_name" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Nome del container non fornito."
        return 1
    fi

    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Tentativo di riavvio del container: $container_name"

    # Riavvia il container e gestisci l'output
    if docker restart "$container_name" 2>&1; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Container $container_name riavviato con successo."
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Riavvio del container $container_name fallito."
    fi
}

# Nome del container
CONTAINER_NAME="minecraft-server-v2"

# Log iniziale
echo "\n$(date '+%Y-%m-%d %H:%M:%S') [INFO] Inizio esecuzione script."

# Esegui lo script swapper all'interno del container
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Esecuzione dello script swapper nel container: $CONTAINER_NAME"
if docker exec "$CONTAINER_NAME" bash /mng/scripts/icoNmotd_swapper/swapper.sh 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Script swapper eseguito correttamente."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Esecuzione dello script swapper fallita."
fi
# Esegui lo script per il backup della cartella app
#if docker exec "$CONTAINER_NAME" bash /mng/scripts/bkAppFolder/bkAppFolder.sh 2>&1; then
#    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Script backup eseguito correttamente."
#else
#    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Esecuzione dello script backup fallita."
#fi


# Riavvia il container
restart_container "$CONTAINER_NAME"

# Log finale
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Fine esecuzione script.\n"
