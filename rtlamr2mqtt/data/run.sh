#!/usr/bin/env bashio
set -e

CONFIG="/etc/rtlamr2mqtt.yaml"

bashio::log.info "Creating rtlamr2mqtt configuration..."

# Create main config
MQTTHOST=$(bashio::config 'mqtt_host')
MQTTUSER=$(bashio::config 'mqtt_user')
MQTTPASSWORD=$(bashio::config 'mqtt_password')
METERID=$(bashio::config 'meter_id')

{
    echo "general:"
    echo "  sleep_for: 0"
    echo "mqtt:"
    echo "  host: ${MQTTHOST}"
    echo "  user: ${MQTTUSER}"
    echo "  password: ${MQTTPASSWORD}"
    echo "  ha_autodiscovery: true"
    echo "  ha_autodiscovery_topic: homeassistant"
    echo "custom_parameters:"
    echo "  rtltcp: \"-s 2048000\""
    echo "  rtlamr: \"\""
    echo "meters:"
    echo "  - id: ${METERID}"
    echo "    protocol: idm"
    echo "    name: main_power"
    echo "    format: \"######.##\""
    echo "    unit_of_measurement: kWh"
    echo "    icon: mdi:transmission-tower"
} > "${CONFIG}"

bashio::log.info "Starting rtlamr2mqtt server..."
exec /usr/bin/rtlamr2mqtt.py \
    -4 -f -d --no-pid \
    < /dev/null