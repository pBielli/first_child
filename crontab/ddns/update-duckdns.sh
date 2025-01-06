#!/bin/bash

# Funzione per aggiornare un dominio DuckDNS
updateDuckDDNS() {
  local domain=$1
  local token=$2

  # URL per aggiornare il dominio
  UPDATE_URL="https://www.duckdns.org/update?domains=$domain&token=$token&ip="

  # Aggiorna DuckDNS
  RESPONSE=$(curl -s "$UPDATE_URL")
  # Log per il controllo
  if [ "$RESPONSE" = "OK" ]; then
    echo "$(date) - OK - DuckDNS ($domain) aggiornato con successo."
  else
    echo "$(date) - Errore nell'aggiornamento di DuckDNS ($domain): $RESPONSE"
  fi
}
