#!/bin/bash

# Definizione delle variabili
CONTAINER_NAME="portainer"
IMAGE_NAME="portainer/portainer-ce:2.21.5"
VOLUME_NAME="portainer_data"
PORTAINER_UI_PORT="8000"
PORTAINER_SECURE_PORT="9443"

# Stop e rimozione del container esistente
echo "Stopping and removing the existing Portainer container..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Rimozione del volume esistente
echo "Removing the existing Portainer data volume..."
docker volume rm $VOLUME_NAME

# Ricreazione del volume
echo "Creating a new Portainer data volume..."
docker volume create $VOLUME_NAME

# Avvio del nuovo container con le configurazioni specificate
echo "Starting the Portainer container with the specified configuration..."
docker run -d \
  -p $PORTAINER_UI_PORT:$PORTAINER_UI_PORT \
  -p $PORTAINER_SECURE_PORT:$PORTAINER_SECURE_PORT \
  --name $CONTAINER_NAME \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $VOLUME_NAME:/data \
  $IMAGE_NAME

echo "Container $CONTAINER_NAME and volume $VOLUME_NAME successfully recreated."
