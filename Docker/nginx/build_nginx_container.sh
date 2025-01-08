#!/bin/bash

# Definizione delle variabili
CONTAINER_NAME="nginx"
IMAGE_NAME="nginx-srv"
DOCKERFILE_DIR="."  # Cambia questo percorso se il Dockerfile si trova in una directory diversa
PORT_SSH="32022"
PORT_FTP="32021"
PORT_HTTP="80"
PORT_HTTPS="443"

# Stop e rimozione del container esistente
echo "Stopping and removing the existing Nginx container..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Costruzione dell'immagine Docker da Dockerfile
echo "Building the Docker image from Dockerfile..."
docker build -t $IMAGE_NAME $DOCKERFILE_DIR

# Avvio del nuovo container con le porte specificate
echo "Starting the Nginx container with the specified configuration..."
docker run --name $CONTAINER_NAME -d \
  -p $PORT_SSH:22 \
  -p $PORT_FTP:21 \
  -p $PORT_HTTP:80 \
  -p $PORT_HTTPS:443 \
  $IMAGE_NAME

echo "Container $CONTAINER_NAME built and started successfully."