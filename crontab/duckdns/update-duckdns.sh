#!/bin/bash

# Configurazione DuckDNS
DOMAIN="patbee"
VPN_DOMAIN="vpn-patbee"
TOKEN="3894523a-d53d-433d-b661-83ac156319fa"

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
    echo "$(date) - DuckDNS ($domain) aggiornato con successo."
  else
    echo "$(date) - Errore nell'aggiornamento di DuckDNS ($domain): $RESPONSE"
  fi
}

# Aggiorna i domini configurati
updateDuckDDNS "$DOMAIN" "$TOKEN"
updateDuckDDNS "$VPN_DOMAIN" "$TOKEN"
