#!/bin/bash
WIFI_SSID=""
WIFI_PASSWORD=""

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -ws|--wifi-ssid)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        WIFI_SSID=$2
        shift 2
      else
        echo "error: argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -wp|--wifi-password)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        WIFI_PASSWORD=$2
        shift 2
      else
        echo "error: argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

echo "Connecting to wi-fi..."
iwctl --passphrase $WIFI_PASSWORD station wlan0 connect $WIFI_SSID
wait !$