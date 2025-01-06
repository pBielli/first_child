#!/bin/bash

# Nome del container
CONTAINER_NAME="minecraft-server-v2"
BACKUP_DIR="/home/pat/first_child/backups/minecraft/1.21.1/"
DATE=$(date '+%Y%m%d%H%M%S')
ARCHIVE_NAME="app_$DATE.tar.gz"

# Log iniziale
echo "\n$(date '+%Y-%m-%d %H:%M:%S') [INFO] Inizio esecuzione script backup."

# Stop del container
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Fermando il container $CONTAINER_NAME..."
docker stop "$CONTAINER_NAME"

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Container fermato correttamente."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Impossibile fermare il container $CONTAINER_NAME."
    exit 1
fi

# Copia della cartella app dal container all'host
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Copia della cartella /app dal container $CONTAINER_NAME..."
docker cp "$CONTAINER_NAME:/app" "$BACKUP_DIR/app"

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Cartella /app copiata correttamente."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Impossibile copiare la cartella /app."
    exit 1
fi

# Creazione dell'archivio tar.gz
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Creazione del backup tar.gz..."
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$BACKUP_DIR" app

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Archivio $ARCHIVE_NAME creato correttamente."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Impossibile creare l'archivio tar.gz."
    exit 1
fi

# Riavvio del container
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Riavvio del container $CONTAINER_NAME..."
docker start "$CONTAINER_NAME"

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESSO] Container riavviato correttamente."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERRORE] Impossibile riavviare il container $CONTAINER_NAME."
    exit 1
fi

# Log finale
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Fine esecuzione script.\n"
