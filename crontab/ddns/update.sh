#!/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Includi lo script di FreeDNS
source "$SCRIPT_DIR/update-duckdns.sh"
source "$SCRIPT_DIR/update-freedns.sh"
source "$SCRIPT_DIR/configs.sh"

# Aggiorna i domini configurati
updateDuckDDNS "$DUCKDNS_DOMAIN_MAIN" "$DUCKDNS_TOKEN"
updateDuckDDNS "$DUCKDNS_DOMAIN_VPN" "$DUCKDNS_TOKEN"

# Aggiorna i domini configurati
updateFreedns "$FREEDNS_TOKEN_PATBEE"
updateFreedns "$FREEDNS_TOKEN_MC_PATBEE"
updateFreedns "$FREEDNS_TOKEN_NODE_PATBEE"
updateFreedns "$FREEDNS_TOKEN_BK"
