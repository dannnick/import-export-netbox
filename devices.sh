#!/bin/bash

#Variablen Laden
source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh

#Device Roles
url_option=dcim/device-roles
url=$url_source/api/$url_option/?limit=0
device_roles=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $device_roles | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    devices_roles_info="$1"
    url_option=$2

    data_name=$(echo $devices_roles_info | jq -r ".name")
    data_slug=$(echo $devices_roles_info | jq -r ".slug")
    data_color=$(echo $devices_roles_info | jq -r ".color")
    data_vm_role=$(echo $devices_roles_info | jq -r ".vm_role")
    data_description=$(echo $devices_roles_info | jq -r ".description")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ] && [ ! -z "$data_slug" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_color" != "null" ] && [ ! -z "$data_color" ]; then
        payload+="\"color\": \"$data_color\","
    fi
    if [ "$data_vm_role" != "null" ] && [ ! -z "$data_vm_role" ]; then
        payload+="\"vm_role\": $data_vm_role,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Device Role: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$device_roles" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Platforms
url_option=dcim/platforms
url=$url_source/api/$url_option/?limit=0
platforms=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $platforms | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    platforms_info="$1"
    url_option=$2

    data_name=$(echo $platforms_info | jq -r ".name")
    data_slug=$(echo $platforms_info | jq -r ".slug")
    data_manufacturer=$(echo $platforms_info | jq -r ".manufacturer")
    data_description=$(echo $platforms_info | jq -r ".description")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ] && [ ! -z "$data_slug" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_manufacturer" != "null" ] && [ ! -z "$data_manufacturer" ]; then
        payload+="\"manufacturer\": \"$data_manufacturer\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Device Role: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$platforms" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Manufacturers
url_option=dcim/manufacturers
url=$url_source/api/$url_option/?limit=0
manufacturers=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $manufacturers | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    manufacturers_info="$1"
    url_option=$2

    data_name=$(echo $manufacturers_info | jq -r ".name")
    data_slug=$(echo $manufacturers_info | jq -r ".slug")
    data_description=$(echo $manufacturers_info | jq -r ".description")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ] && [ ! -z "$data_slug" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Device Role: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$manufacturers" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Device Types
url_option=dcim/device-types
url=$url_source/api/$url_option/?limit=0
device_types=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $device_types | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    devices_type_info="$1"
    url_option=$2

    data_model=$(echo $devices_type_info | jq -r ".model")
    data_slug=$(echo $devices_type_info | jq -r ".slug")
    data_manufacturer_name=$(echo $devices_type_info | jq -r ".manufacturer.name")
    data_manufacturer_slug=$(echo $devices_type_info | jq -r ".manufacturer.slug")
    data_description=$(echo $devices_type_info | jq -r ".description")
    data_uheight=$(echo $devices_type_info | jq -r ".u_height")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_model" != "null" ] && [ ! -z "$data_model" ]; then
        payload+="\"model\": \"$data_model\","
    fi
    if [ "$data_slug" != "null" ] && [ ! -z "$data_slug" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_manufacturer_name" != "null" ] && [ ! -z "$data_manufacturer_name" ] && [ "$data_manufacturer_slug" != "null" ] && [ ! -z "$data_manufacturer_slug" ]; then
        payload+="\"manufacturer\": {\"name\": \"$data_manufacturer_name\", \"slug\": \"$data_manufacturer_slug\"},"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_uheight" != "null" ] && [ ! -z "$data_uheight" ]; then
        payload+="\"u_height\": $data_uheight,"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Data Type: $data_model"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$device_types" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Devices
url_option=dcim/devices
url=$url_source/api/$url_option/?limit=0
devices=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $devices | jq '.results | length')

# Funktion zum Ausführen einer POST-Anfrage
post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    devices_info="$1"
    url_option=$2

    data_name=$(echo "$devices_info" | jq -r ".name")
    data_devicerole_name=$(echo "$devices_info" | jq -r ".device_role.name")
    data_devicerole_slug=$(echo "$devices_info" | jq -r ".device_role.slug")
    data_manufacturer_name=$(echo "$devices_info" | jq -r ".device_type.manufacturer.name")
    data_manufacturer_slug=$(echo "$devices_info" | jq -r ".device_type.manufacturer.slug")
    data_devicetype_model=$(echo "$devices_info" | jq -r ".device_type.model")
    data_devicetype_slug=$(echo "$devices_info" | jq -r ".device_type.slug")
    data_serial=$(echo "$devices_info" | jq -r ".serial")
    data_assettag=$(echo "$devices_info" | jq -r ".asset_tag")
    data_status=$(echo "$devices_info" | jq -r ".status.value")
    data_site_name=$(echo "$devices_info" | jq -r ".site.name")
    data_site_slug=$(echo "$devices_info" | jq -r ".site.slug")
    data_rack_name_source=$(echo "$devices_info" | jq -r ".rack.name")
    data_position=$(echo "$devices_info" | jq -r ".position")
    data_face=$(echo "$devices_info" | jq -r ".face.value")

    payload="{"
    payload+="\"name\": \"$data_name\","
    payload+="\"device_role\": {\"name\": \"$data_devicerole_name\", \"slug\": \"$data_devicerole_slug\"},"
    payload+="\"device_type\": {\"manufacturer\": {\"name\": \"$data_manufacturer_name\", \"slug\": \"$data_manufacturer_slug\"}, \"model\": \"$data_devicetype_model\", \"slug\": \"$data_devicetype_slug\"},"
    payload+="\"status\": \"$data_status\","
    payload+="\"site\": {\"name\": \"$data_site_name\", \"slug\": \"$data_site_slug\"},"

    if [ "$data_rack_name_source" != "null" ] && [ ! -z "$data_rack_name_source" ]; then
        data_rack_id_dest=$(curl -s -k -X GET -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url_dest/api/dcim/racks/" | jq ".results | .[]" | grep "$data_rack_name_source" -B 2 | grep id | sed -re 's+.*: ++g;s+,.*++g')
        if [ "$data_rack_id_dest" != "null" ] && [ ! -z "$data_rack_id_dest" ]; then
            payload+="\"rack\": {\"id\": $data_rack_id_dest},"
        fi
    fi
    if [ "$data_position" != "null" ] && [ ! -z "$data_position" ] && [ "$data_face" != "null" ] && [ ! -z "$data_face" ]; then
        payload+="\"position\": $data_position, \"face\": \"$data_face\","
    fi
    if [ "$data_serial" != "null" ] && [ ! -z "$data_serial" ]; then
        payload+="\"serial\": \"$data_serial\","
    fi
    if [ "$data_assettag" != "null" ] && [ ! -z "$data_assettag" ]; then
        payload+="\"asset_tag\": \"$data_assettag\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Device: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$devices" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Interfaces
url_option=dcim/interfaces
url=$url_source/api/$url_option/?limit=0
interfaces=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $interfaces | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    interfaces_info="$1"
    url_option=$2

    data_devicename=$(echo $interfaces_info | jq -r ".device.name")
    data_name=$(echo $interfaces_info | jq -r ".name")
    data_lag_name=$(echo $interfaces_info | jq -r ".lag.name")
    data_lag_device_name=$(echo $interfaces_info | jq -r ".lag.device.name")
    data_type=$(echo $interfaces_info | jq -r ".type.value")
    data_speed=$(echo $interfaces_info | jq -r ".speed")
    data_duplex=$(echo $interfaces_info | jq -r ".duplex.value")
    data_enabled=$(echo $interfaces_info | jq -r ".enabled")
    data_markconnected=$(echo $interfaces_info | jq -r ".mark_connected")
    data_macaddress=$(echo $interfaces_info | jq -r ".mac_address")
    data_mgmt_only=$(echo $interfaces_info | jq -r ".mgmt_only")
    data_description=$(echo $interfaces_info | jq -r ".description")
    data_mode=$(echo $interfaces_info | jq -r ".mode.value")

    payload="{"

    # Überprüfung und Hinzufügen von location
    if [ "$data_devicename" != "null" ] && [ ! -z "$data_devicename" ]; then
        payload+="\"device\": {\"name\": \"$data_devicename\"},"
    fi
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_lag_name" != "null" ] && [ ! -z "$data_lag_name" ] && [ "$data_lag_device_name" != "null" ] && [ ! -z "$data_lag_device_name" ]; then
        payload+="\"lag\": {\"name\": \"$data_lag_name\", \"device\": {\"name\": \"$data_lag_device_name\"}},"
    fi
    if [ "$data_type" != "null" ] && [ ! -z "$data_type" ]; then
        payload+="\"type\": \"$data_type\","
    fi
    if [ "$data_speed" != "null" ] && [ ! -z "$data_speed" ]; then
        payload+="\"speed\": $data_speed,"
    fi
    if [ "$data_duplex" != "null" ] && [ ! -z "$data_duplex" ]; then
        payload+="\"duplex\": \"$data_duplex\","
    fi
    if [ "$data_enabled" != "null" ] && [ ! -z "$data_enabled" ]; then
        payload+="\"enabled\": $data_enabled,"
    fi
    if [ "$data_markconnected" != "null" ] && [ ! -z "$data_markconnected" ]; then
        payload+="\"mark_connected\": $data_markconnected,"
    fi
    if [ "$data_macaddress" != "null" ] && [ ! -z "$data_macaddress" ]; then
        payload+="\"mac_address\": \"$data_macaddress\","
    fi
    if [ "$data_mgmt_only" != "null" ] && [ ! -z "$data_mgmt_only" ]; then
        payload+="\"mgmt_only\": $data_mgmt_only,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_mode" != "null" ] && [ ! -z "$data_mode" ]; then
        payload+="\"mode\": \"$data_mode\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Interface: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$interfaces" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Rear Ports
url_option=dcim/rear-ports
url=$url_source/api/$url_option/?limit=0
rear_ports=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $rear_ports | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    rear_ports_info="$1"
    url_option=$2

    data_devicename=$(echo $rear_ports_info | jq -r ".device.name")
    data_name=$(echo $rear_ports_info | jq -r ".name")
    data_type=$(echo $rear_ports_info | jq -r ".type.value")
    data_markconnected=$(echo $rear_ports_info | jq -r ".mark_connected")
    data_positions=$(echo $rear_ports_info | jq -r ".positions")
    data_description=$(echo $rear_ports_info | jq -r ".description")

    payload="{"

    # Überprüfung und Hinzufügen von location
    if [ "$data_devicename" != "null" ] && [ ! -z "$data_devicename" ]; then
        payload+="\"device\": {\"name\": \"$data_devicename\"},"
    fi
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_type" != "null" ] && [ ! -z "$data_type" ]; then
        payload+="\"type\": \"$data_type\","
    fi
    if [ "$data_markconnected" != "null" ] && [ ! -z "$data_markconnected" ]; then
        payload+="\"mark_connected\": $data_markconnected,"
    fi
    if [ "$data_positions" != "null" ] && [ ! -z "$data_positions" ]; then
        payload+="\"positions\": \"$data_positions\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Rear Port: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$rear_ports" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Front Ports


#Console Ports

#Power Ports

#Power Outlets

#Device Bays

#Inventory Items