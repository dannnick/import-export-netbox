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
    data_manufacturer=$(echo $platforms_info | jq -r ".manufacturer.name")
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
        payload+="\"manufacturer\": {\"name\": \"$data_manufacturer\"},"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Platform: $data_name"
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
    data_is_full_depth=$(echo $devices_type_info | jq -r ".is_full_depth")
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
    if [ "$data_is_full_depth" != "null" ] && [ ! -z "$data_is_full_depth" ]; then
        payload+="\"is_full_depth\": $data_is_full_depth,"
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
    data_location_name=$(echo "$devices_info" | jq -r ".location.name")
    data_location_slug=$(echo "$devices_info" | jq -r ".location.slug")
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
    if [ "$data_location_name" != "null" ] && [ ! -z "$data_location_name" ] && [ "$data_location_slug" != "null" ] && [ ! -z "$data_location_slug" ]; then
        payload+="\"location\": {\"name\": \"$data_location_name\", \"slug\": \"$data_location_slug\"},"
    fi
    if [ "$data_position" != "null" ] && [ ! -z "$data_position" ] && [ "$data_face" != "null" ] && [ ! -z "$data_face" ]; then
        payload+="\"face\": \"$data_face\", \"position\": $data_position,"
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
rear_ports=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
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
url_option=dcim/front-ports
url=$url_source/api/$url_option/?limit=0
front_ports=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $front_ports | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    front_ports_info="$1"
    url_option=$2

    data_devicename=$(echo $front_ports_info | jq -r ".device.name")
    data_name=$(echo $front_ports_info | jq -r ".name")
    data_type=$(echo $front_ports_info | jq -r ".type.value")
    data_markconnected=$(echo $front_ports_info | jq -r ".mark_connected")
    data_rear_port_name=$(echo $front_ports_info | jq -r "rear_port.name")
    data_rear_port_position=$(echo $front_ports_info | jq -r "rear_port_position")
    data_description=$(echo $front_ports_info | jq -r ".description")

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
    if [ "$data_rear_port_name" != "null" ] && [ ! -z "$data_rear_port_name" ]; then
        payload+="\"rear_port\": {\"name\": \"$data_rear_port_name\"},"
    fi
    if [ "$data_rear_port_position" != "null" ] && [ ! -z "$data_rear_port_position" ]; then
        payload+="\"rear_port_position\": $data_rear_port_position,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Front Port: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$front_ports" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Console Ports
url_option=dcim/console-ports
url=$url_source/api/$url_option/?limit=0
console_ports=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $console_ports | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    console_ports_info="$1"
    url_option=$2

    data_devicename=$(echo $console_ports_info | jq -r ".device.name")
    data_name=$(echo $console_ports_info | jq -r ".name")
    data_type=$(echo $console_ports_info | jq -r ".type.value")
    data_speed=$(echo $console_ports_info | jq -r ".speed")
    data_markconnected=$(echo $console_ports_info | jq -r ".mark_connected")
    data_description=$(echo $console_ports_info | jq -r ".description")

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
    if [ "$data_speed" != "null" ] && [ ! -z "$data_speed" ]; then
        payload+="\"speed\": $data_speed,"
    fi
    if [ "$data_markconnected" != "null" ] && [ ! -z "$data_markconnected" ]; then
        payload+="\"mark_connected\": $data_markconnected,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Console Port: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$console_ports" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Power Ports
url_option=dcim/power-ports
url=$url_source/api/$url_option/?limit=0
power_ports=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $power_ports | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    power_ports_info="$1"
    url_option=$2

    data_devicename=$(echo $power_ports_info | jq -r ".device.name")
    data_name=$(echo $power_ports_info | jq -r ".name")
    data_type=$(echo $power_ports_info | jq -r ".type.value")
    data_markconnected=$(echo $power_ports_info | jq -r ".mark_connected")
    data_maximum_draw=$(echo $power_ports_info | jq -r ".maximum_draw")
    data_allocated_draw=$(echo $power_ports_info | jq -r ".allocated_draw")
    data_description=$(echo $power_ports_info | jq -r ".description")

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
    if [ "$data_maximum_draw" != "null" ] && [ ! -z "$data_maximum_draw" ]; then
        payload+="\"maximum_draw\": $data_maximum_draw,"
    fi
    if [ "$data_allocated_draw" != "null" ] && [ ! -z "$data_allocated_draw" ]; then
        payload+="\"allocated_draw\": $data_allocated_draw,"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Power Port: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$power_ports" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Power Outlets
url_option=dcim/power-outlets
url=$url_source/api/$url_option/?limit=0
power_outlets=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $power_outlets | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    power_outlets_info="$1"
    url_option=$2

    data_devicename=$(echo $power_outlets_info | jq -r ".device.name")
    data_name=$(echo $power_outlets_info | jq -r ".name")
    data_type=$(echo $power_outlets_info | jq -r ".type.value")
    data_markconnected=$(echo $power_outlets_info | jq -r ".mark_connected")
    data_power_port=$(echo $power_outlets_info | jq -r ".power_port.name")
    data_feed_leg=$(echo $power_outlets_info | jq -r ".feed_leg")
    data_description=$(echo $power_outlets_info | jq -r ".description")

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
    if [ "$data_power_port" != "null" ] && [ ! -z "$data_power_port" ]; then
        payload+="\"power_port\": \"$data_power_port\","
    fi
    if [ "$data_feed_leg" != "null" ] && [ ! -z "$data_feed_leg" ]; then
        payload+="\"feed_leg\": \"$data_feed_leg\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Power Outlets: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$power_outlets" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Device Bays
url_option=dcim/device-bays
url=$url_source/api/$url_option/?limit=0
device_bays=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $device_bays | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    device_bays_info="$1"
    url_option=$2

    data_devicename=$(echo $device_bays_info | jq -r ".device.name")
    data_name=$(echo $device_bays_info | jq -r ".name")
    data_type=$(echo $device_bays_info | jq -r ".type.value")
    data_installed_device=$(echo $device_bays_info | jq -r ".installed_device.name")
    data_description=$(echo $device_bays_info | jq -r ".description")

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
    if [ "$data_installed_device" != "null" ] && [ ! -z "$data_installed_device" ]; then
        payload+="\"installed_device\": {\"name\": \"$data_installed_device\"},"
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Device Bays: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$device_bays" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Inventory Items
url_option=dcim/inventory-items
url=$url_source/api/$url_option/?limit=0
inventory_items=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $inventory_items | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    inventory_items_info="$1"
    url_option=$2

    data_devicename=$(echo $inventory_items_info | jq -r ".device.name")
    data_name=$(echo $inventory_items_info | jq -r ".name")
    data_role_name=$(echo $inventory_items_info | jq -r ".role.name")
    data_manufacturer_name=$(echo $inventory_items_info | jq -r ".manufacturer.name")
    data_part_id=$(echo $inventory_items_info | jq -r ".part_id")
    data_serial=$(echo $inventory_items_info | jq -r ".serial")
    data_assettag=$(echo $inventory_items_info | jq -r ".asset_tag")
    data_discovered=$(echo $inventory_items_info | jq -r ".discovered")
    data_component_type=$(echo $inventory_items_info | jq -r ".component_type")
    data_componenet_name=$(echo $inventory_items_info | jq -r ".component_name")
    data_description=$(echo $inventory_items_info | jq -r ".description")

    payload="{"

    # Überprüfung und Hinzufügen von location
    if [ "$data_devicename" != "null" ] && [ ! -z "$data_devicename" ]; then
        payload+="\"device\": {\"name\": \"$data_devicename\"},"
    fi
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_role_name" != "null" ] && [ ! -z "$data_role_name" ]; then
        payload+="\"role\": {\"name\": \"$data_role_name\"},"
    fi
    if [ "$data_manufacturer_name" != "null" ] && [ ! -z "$data_manufacturer_name" ]; then
        payload+="\"manufacturer\": {\"name\": \"$data_manufacturer_name\"},"
    fi
    if [ "$data_part_id" != "null" ] && [ ! -z "$data_part_id" ]; then
        payload+="\"part_id\": $data_part_id,"
    fi
    if [ "$data_serial" != "null" ] && [ ! -z "$data_serial" ]; then
        payload+="\"serial\": \"$data_serial\","
    fi
    if [ "$data_assettag" != "null" ] && [ ! -z "$data_assettag" ]; then
        payload+="\"asset_tag\": \"$data_assettag\","
    fi
    if [ "$data_discovered" != "null" ] && [ ! -z "$data_discovered" ]; then
        payload+="\"discovered\": $data_discovered,"
    fi
    if [ "$data_componenet_type" != "null" ] && [ ! -z "$data_component_type" ]; then
        payload+="\"component_type\": \"$data_component_type\","
    fi
    if [ "$data_componenet_name" != "null" ] && [ ! -z "$data_component_name" ]; then
        payload+="\"component_name\": \"$data_component_name\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo -e "Inventory Items: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}

export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$inventory_items" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"