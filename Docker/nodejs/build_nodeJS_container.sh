#!/bin/bash

# Definizione delle variabili
CONTAINER_NAME="nodejs-container"
IMAGE_NAME="nodejs-srv"
DOCKERFILE_DIR="."  # Cambia questo percorso se il Dockerfile si trova in una directory diversa
PORT_SSH="31022"
PORT_FTP="31021"
PORT_RANGE="31100-31200:3100-3200"

# Stop e rimozione del container esistente
echo "Stopping and removing the existing Node.js container..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Costruzione dell'immagine Docker da Dockerfile
echo "Building the Docker image from Dockerfile..."
docker build -t $IMAGE_NAME $DOCKERFILE_DIR

# Avvio del nuovo container con le porte specificate
echo "Starting the Node.js container with the specified configuration..."
docker run --name $CONTAINER_NAME -d \
  -p $PORT_SSH:22 \
  -p $PORT_FTP:21 \
  -p $PORT_RANGE \
  $IMAGE_NAME

echo "Container $CONTAINER_NAME built and started successfully."
