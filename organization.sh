#!/bin/bash

#Variablen Laden
source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh

#Region
url_option=dcim/regions
url=$url_source/api/$url_option/?limit=0
regions=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $regions | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_name=$(echo $regions | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_slug=$(echo $regions | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_parent=$(echo $regions | jq ".results | .[$i] | .parent" | sed -re 's+["]++g')
    data_description=$(echo $regions | jq ".results | .[$i] | .description" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_description" != "null" ] || [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_parent" != "null" ]; then
        data_parent_name=$(echo $regions | jq ".results | .[$i] | .parent | .name" | sed -re 's+["]++g')
        data_parent_slug=$(echo $regions | jq ".results | .[$i] | .parent | .slug" | sed -re 's+["]++g')

        payload+="\"parent\": {\"name\": \"$data_parent_name\", \"slug\": \"$data_parent_slug\"},"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    
    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/dcim/regions/" | jq
done

#Sites
url_option=dcim/sites
url=$url_source/api/$url_option/?limit=0
sites=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $sites | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_name=$(echo $sites | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_slug=$(echo $sites | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_status=$(echo $sites | jq ".results | .[$i] | .status | .value" | sed -re 's+["]++g')
    data_region_name=$(echo $sites | jq ".results | .[$i] | .region | .name" | sed -re 's+["]++g')
    data_region_slug=$(echo $sites | jq ".results | .[$i] | .region | .slug" | sed -re 's+["]++g')
    data_timezone=$(echo $sites | jq ".results | .[$i] | .time_zone" | sed -re 's+["]++g')
    data_description=$(echo $sites | jq ".results | .[$i] | .description" | sed -re 's+["]++g')
    data_physical_address=$(echo $sites | jq ".results | .[$i] | .physical_address" | sed -re 's+["]++g')
    data_latitude=$(echo $sites | jq ".results | .[$i] | .latitude" | sed -re 's+["]++g')
    data_longitude=$(echo $sites | jq ".results | .[$i] | .longitude" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_region_name" != "null" ] && [ "$data_region_slug" != "null" ]; then
        payload+="\"region\": {\"name\": \"$data_region_name\", \"slug\": \"$data_region_slug\"},"
    fi
    if [ "$data_timezone" != "null" ]; then
        payload+="\"time_zone\": \"$data_timezone\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_physical_address" != "null" ]; then
        payload+="\"physical_address\": \"$data_physical_address\","
    fi
    if [ "$data_latitude" != "null" ]; then
        payload+="\"latitude\": $data_latitude,"
    fi
    if [ "$data_longitude" != "null" ]; then
        payload+="\"longitude\": $data_longitude,"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
done

#Locations
url_option=dcim/locations
url=$url_source/api/$url_option/?limit=0
count=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_site_name=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq ".results | .[$i] | .site | .name" | sed -re 's+["]++g')
    data_site_slug=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq ".results | .[$i] | .site | .slug" | sed -re 's+["]++g')
    data_name=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_slug=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq ".results | .[$i] | .slug" | sed -re 's+["]++g')
    data_status=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq ".results | .[$i] | .status | .value" | sed -re 's+["]++g')
    data_description=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url" | jq ".results | .[$i] | .description" | sed -re 's+["]++g')

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_site_name" != "null" ] && [ "$data_site_slug" != "null" ]; then
        payload+="\"site\": {\"name\": \"$data_site_name\", \"slug\": \"$data_site_slug\"},"
    fi
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_status" != "null" ]; then
        payload+="\"status\": \"$data_status\","
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

#Racks
url_option=dcim/racks
url=$url_source/api/$url_option/?limit=0
racks=$(curl -s -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $racks | jq '.results | length')

for (( i=0;i<${count};i++ )); do
    data_site_name=$(echo $racks | jq ".results | .[$i] | .site | .name" | sed -re 's+["]++g')
    data_site_slug=$(echo $racks | jq ".results | .[$i] | .site | .slug" | sed -re 's+["]++g')
    data_name=$(echo $racks | jq ".results | .[$i] | .name" | sed -re 's+["]++g')
    data_status=$(echo $racks | jq ".results | .[$i] | .status | .value" | sed -re 's+["]++g')
    data_description=$(echo $racks | jq ".results | .[$i] | .description" | sed -re 's+["]++g')
    data_width=$(echo $racks | jq ".results | .[$i] | .width | .value")
    data_uheight=$(echo $racks | jq ".results | .[$i] | .u_height")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_site_name" != "null" ] && [ "$data_site_slug" != "null" ]; then
        payload+="\"site\": {\"name\": \"$data_site_name\", \"slug\": \"$data_site_slug\"},"
    fi
    if [ "$data_name" != "null" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_status" != "null" ]; then
        payload+="\"status\": \"$data_status\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_width" != "null" ]; then
        payload+="\"width\": $data_width,"
    fi
    if [ "$data_uheight" != "null" ]; then
        payload+="\"u_height\": $data_uheight,"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    # überprüfen, ob schon vorhanden, weil es sonst mehrfach in der netbox drin ist
    check=$(echo $racks | jq ".results | .[]" | grep "$data_name")

    if [ -z "$check" ]; then
        curl -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    fi
done