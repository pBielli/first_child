#!/bin/bash

# Funzione per aggiornare un dominio FreeDNS
updateFreedns() {
  local token=$1

  # URL per aggiornare il dominio
  UPDATE_URL="https://freedns.afraid.org/dynamic/update.php?$token"

  # Aggiorna FreeDNS
  RESPONSE=$(curl -s "$UPDATE_URL")

  # Log per il controllo
  if [[ "$RESPONSE" == *"has not changed." ]]; then
    echo "$(date) - OK - Nessun cambiamento di IP per FreeDNS."
  elif [ "$RESPONSE" = "OK" ]; then
    echo "$(date) - FreeDNS aggiornato con successo."
  else
    echo "$(date) - Errore nell'aggiornamento di FreeDNS: $RESPONSE"
  fi
}


