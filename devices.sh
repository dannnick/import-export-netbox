#!/bin/bash

#Variablen Laden
source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh

#Device Roles
url_option=dcim/device-roles
url=$url_source/api/$url_option/?limit=0
device_roles=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $device_roles | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_name=$(echo $device_roles | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_slug=$(echo $device_roles | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_color=$(echo $device_roles | jq ".results | .[$i] | .color" | sed -re 's+["]++g')
    data_vm_role=$(echo $device_roles | jq ".results | .[$i] | .vm_role" | sed -re 's+["]++g')
    data_description=$(echo $device_roles | jq ".results | .[$i] | .description" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_color" != "null" ]; then
        payload+="\"color\": \"$data_color\","
    fi
    if [ "$data_vm_role" != "null" ]; then
        payload+="\"vm_role\": $data_vm_role,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Platforms
url_option=dcim/platforms
url=$url_source/api/$url_option/?limit=0
platforms=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $platforms | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_name=$(echo $platforms | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_slug=$(echo $platforms | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_manufacturer=$(echo $platforms | jq ".results | .[$i] | .manufacturer" | sed -re 's+["]++g')
    data_description=$(echo $platforms | jq ".results | .[$i] | .description" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_manufacturer" != "null" ]; then
        payload+="\"manufacturer\": \"$data_manufacturer\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Manufacturers
url_option=dcim/manufacturers
url=$url_source/api/$url_option/?limit=0
manufacturers=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $manufacturers | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_name=$(echo $manufacturers | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_slug=$(echo $manufacturers | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_description=$(echo $manufacturers | jq ".results | .[$i] | .description" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Device Types
url_option=dcim/device-types
url=$url_source/api/$url_option/?limit=0
device_types=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $device_types | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_model=$(echo $device_types | jq ".results | .[$i] | .model" | sed -re 's+["]++g')
    data_slug=$(echo $device_types | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_manufacturer_name=$(echo $device_types | jq ".results | .[$i] | .manufacturer | .name" | sed -re 's+["]++g')
    data_manufacturer_slug=$(echo $device_types | jq ".results | .[$i] | .manufacturer | .slug" | sed -re 's+["]++g')
    data_description=$(echo $device_types | jq ".results | .[$i] | .description" | sed -re 's+["]++g')
    data_uheight=$(echo $device_types | jq ".results | .[$i] | .u_height" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_model" != "null" ]; then
        payload+="\"model\": \"$data_model\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_manufacturer_name" != "null" ] && [ "$data_manufacturer_slug" != "null" ]; then
        payload+="\"manufacturer\": {\"name\": \"$data_manufacturer_name\", \"slug\": \"$data_manufacturer_slug\"},"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_uheight" != "null" ]; then
        payload+="\"u_height\": $data_uheight,"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Devices
url_option=dcim/devices
url=$url_source/api/$url_option/?limit=0
devices=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $devices | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_name=$(echo $devices | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_devicerole_name=$(echo $devices | jq ".results | .[$i] | .device_role | .name" | sed -re 's+["]++g')
    data_devicerole_slug=$(echo $devices | jq ".results | .[$i] | .device_role | .slug" | sed -re 's+["]++g')
    data_manufacturer_name=$(echo $devices | jq ".results | .[$i] | .device_type | .manufacturer | .name" | sed -re 's+["]++g')
    data_manufacturer_slug=$(echo $devices | jq ".results | .[$i] | .device_type | .manufacturer | .slug" | sed -re 's+["]++g')
    data_devicetype_model=$(echo $devices | jq ".results | .[$i] | .device_type | .model" | sed -re 's+["]++g')
    data_devicetype_slug=$(echo $devices | jq ".results | .[$i] | .device_type | .slug" | sed -re 's+["]++g')
    data_serial=$(echo $devices | jq ".results | .[$i] | .serial" | sed -re 's+["]++g')
    data_assettag=$(echo $devices | jq ".results | .[$i] | .asset_tag" | sed -re 's+["]++g')
    data_status=$(echo $devices | jq ".results | .[$i] | .status | .value" | sed -re 's+["]++g')
    data_site_name=$(echo $devices | jq ".results | .[$i] | .site | .name" | sed -re 's+["]++g')
    data_site_slug=$(echo $devices | jq ".results | .[$i] | .site | .slug" | sed -re 's+["]++g')
    data_location_name=$(echo $devices | jq ".results | .[$i] | .location | .name" | sed -re 's+["]++g')
    data_location_slug=$(echo $devices | jq ".results | .[$i] | .location | .slug" | sed -re 's+["]++g')
    data_rack_name=$(echo $devices | jq ".results | .[$i] | .rack | .name" | sed -re 's+["]++g')
    data_position=$(echo $devices | jq ".results | .[$i] | .position" | sed -re 's+["]++g')
    data_face=$(echo $devices | jq ".results | .[$i] | .face | .value" | sed -re 's+["]++g')

    payload="{"
    payload+="\"name\": \"$data_name\","
    payload+="\"device_role\": {\"name\": \"$data_devicerole_name\", \"slug\": \"$data_devicerole_slug\"},"
    payload+="\"device_type\": {\"manufacturer\": {\"name\": \"$data_manufacturer_name\", \"slug\": \"$data_manufacturer_slug\"}, \"model\": \"$data_devicetype_model\", \"slug\": \"$data_devicetype_slug\"},"
    payload+="\"status\": \"$data_status\","
    payload+="\"site\": {\"name\": \"$data_site_name\", \"slug\": \"$data_site_slug\"},"

  # Überprüfung und Hinzufügen von location
    if [ "$data_location_name" != "null" ] && [ "$data_location_slug" != "null" ]; then
        payload+="\"location\": {\"name\": \"$data_location_name\", \"slug\": \"$data_location_slug\"},"
    fi
    if [ "$data_rack_name" != "null" ]; then
        payload+="\"rack\": \"$data_rack_name\","
    fi
    if [ "$data_position" != "null" ]; then
        payload+="\"position\": $data_position,"
    fi
    if [ "$data_face" != "null" ]; then
        payload+="\"face\": \"$data_face\","
    fi
    if [ "$data_serial" != "null" ]; then
        payload+="\"serial\": \"$data_serial\","
    fi
    if [ "$data_assettag" != "null" ]; then
        payload+="\"asset_tag\": \"$data_assettag\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"
    
    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Interfaces
url_option=dcim/interfaces
url=$url_source/api/$url_option/?limit=0
interfaces=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $interfaces | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_devicename=$(echo $interfaces | jq ".results | .[$i] | .device | .name" | sed -re 's+["]++g')
    data_name=$(echo $interfaces | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_lag_name=$(echo $interfaces | jq ".results | .[$i] | .lag | .name" | sed -re 's+["]++g')
    data_lag_device_name=$(echo $interfaces | jq ".results | .[$i] | .lag | .device | .name" | sed -re 's+["]++g')
    data_type=$(echo $interfaces | jq ".results | .[$i] | .type | .value" | sed -re 's+["]++g')
    data_speed=$(echo $interfaces | jq ".results | .[$i] | .speed" | sed -re 's+["]++g')
    data_duplex=$(echo $interfaces | jq ".results | .[$i] | .duplex | .value" | sed -re 's+["]++g')
    data_enabled=$(echo $interfaces | jq ".results | .[$i] | .enabled" | sed -re 's+["]++g')
    data_markconnected=$(echo $interfaces | jq ".results | .[$i] | .mark_connected" | sed -re 's+["]++g')
    data_macaddress=$(echo $interfaces | jq ".results | .[$i] | .mac_address" | sed -re 's+["]++g')
    data_mgmt_only=$(echo $interfaces | jq ".results | .[$i] | .mgmt_only" | sed -re 's+["]++g')
    data_description=$(echo $device_types | jq ".results | .[$i] | .description" | sed -re 's+["]++g')
    data_mode=$(echo $device_types | jq ".results | .[$i] | .mode | .value" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen von location
    if [ "$data_devicename" != "null" ]; then
        payload+="\"device\": {\"name\": \"$data_devicename\"},"
    fi
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_lag_name" != "null" ] && [ "$data_lag_device_name" != "null" ]; then
        payload+="\"lag\": {\"name\": \"$data_lag_name\", \"device\": {\"name\": \"$data_lag_device_name\"}},"
    fi
    if [ "$data_type" != "null" ]; then
        payload+="\"type\": \"$data_type\","
    fi
    if [ "$data_speed" != "null" ]; then
        payload+="\"speed\": $data_speed,"
    fi
    if [ "$data_duplex" != "null" ]; then
        payload+="\"duplex\": \"$data_duplex\","
    fi
    if [ "$data_enabled" != "null" ]; then
        payload+="\"enabled\": $data_enabled,"
    fi
    if [ "$data_markconnected" != "null" ]; then
        payload+="\"mark_connected\": $data_markconnected,"
    fi
    if [ "$data_macaddress" != "null" ]; then
        payload+="\"mac_address\": \"$data_macaddress\","
    fi
    if [ "$data_mgmt_only" != "null" ]; then
        payload+="\"mgmt_only\": $data_mgmt_only,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_mode" != "null" ]; then
        payload+="\"mode\": \"$data_mode\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"
    
    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Front Ports

#Rear Ports

#Console Ports

#Power Ports

#Power Outlets

#Device Bays

#Inventory Items