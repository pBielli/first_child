#!/bin/bash

# Funzione per ottenere il nome della macchina (se non passato come argomento)
get_machine_name() {
  if [ -z "$1" ]; then
    read -p "Inserisci il nome della macchina: " machine_name
    echo "$machine_name"
  else
    echo "$1"
  fi
}

# Nomi di default delle porte
SERVER_PORT_INTERNAL=25565
SMB_PORT_INTERNAL=445
HTTP_PORT_INTERNAL=80
HTTPS_PORT_INTERNAL=443
#porte esterne
SERVER_PORT_EXTERNAL=30065
SMB_PORT_EXTERNAL=30445
HTTP_PORT_EXTERNAL=30080
HTTPS_PORT_EXTERNAL=30443

# Ottieni il nome della macchina
MACHINE_NAME=$(get_machine_name "$1")


# Costruisci le stringhe di mappatura delle porte
PORTS_MAPPING="-p $SERVER_PORT_INTERNAL:$SERVER_PORT_EXTERNAL -p $SMB_PORT_INTERNAL:$SMB_PORT_EXTERNAL -p $HTTP_PORT_INTERNAL:$HTTP_PORT_EXTERNAL -p $HTTPS_PORT_INTERNAL:$HTTPS_PORT_EXTERNAL"


echo "Stopping e rimuovendo il container esistente..."
docker stop minecraft-server 2> /dev/null
docker rm minecraft-server 2> /dev/null

echo "Creazione dell'immagine Docker..."
docker build -t paper-server .

echo "Avvio del container Docker..."
docker run --network host -d $PORTS_MAPPING -v ~/paper-data:/app --name minecraft-server paper-server

echo "Container in esecuzione (dopo l'avvio):"
docker ps

echo "Visualizzazione dei log (segui i log):"
docker logs -f minecraft-server &

sleep 2

echo "Avvio del container:"
docker start minecraft-server

echo "Container in esecuzione (dopo l'avvio):"
docker ps

echo "Il container '$MACHINE_NAME' è stato avviato. I log sono in visualizzazione."
