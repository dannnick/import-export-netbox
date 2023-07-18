#!/bin/bash

#Variablen Laden
source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh

#Region
url_option=dcim/regions
url=$url_source/api/$url_option/?limit=0
regions=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $regions | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    regions_info="$1"
    url_option=$2

    data_name=$(echo $regions_info | jq -r ".name")
    data_slug=$(echo $regions_info | jq -r ".slug")
    data_parent=$(echo $regions_info | jq -r ".parent")
    data_description=$(echo $regions_info | jq -r ".description")

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
    if [ "$data_parent" != "null" ] && [ ! -z "$data_parent" ]; then
        data_parent_name=$(echo $regions_info | jq -r ".parent.name")
        data_parent_slug=$(echo $regions_info | jq -r ".parent.slug")

        payload+="\"parent\": {\"name\": \"$data_parent_name\", \"slug\": \"$data_parent_slug\"},"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Region: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$regions" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Sites
url_option=dcim/sites
url=$url_source/api/$url_option/?limit=0
sites=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $sites | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    sites_info="$1"
    url_option=$2

    data_name=$(echo $sites_info | jq -r ".name")
    data_slug=$(echo $sites_info | jq -r ".slug")
    data_status=$(echo $sites_info | jq -r ".status.value")
    data_region_name=$(echo $sites_info | jq -r ".region.name")
    data_region_slug=$(echo $sites_info | jq -r ".region.slug")
    data_timezone=$(echo $sites_info | jq -r ".time_zone")
    data_description=$(echo $sites_info | jq -r ".description")
    data_physical_address=$(echo $sites_info | jq ".physical_address" | sed -re 's+["]++g')
    data_latitude=$(echo $sites_info | jq -r ".latitude")
    data_longitude=$(echo $sites_info | jq -r ".longitude")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ] && [ ! -z "$data_slug" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_region_name" != "null" ] && [ ! -z "$data_region_name" ] && [ "$data_region_slug" != "null" ] && [ ! -z "$data_region_slug" ]; then
        payload+="\"region\": {\"name\": \"$data_region_name\", \"slug\": \"$data_region_slug\"},"
    fi
    if [ "$data_timezone" != "null" ] && [ ! -z "$data_timezone" ]; then
        payload+="\"time_zone\": \"$data_timezone\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_physical_address" != "null" ] && [ ! -z "$data_physical_address" ]; then
        payload+="\"physical_address\": \"$data_physical_address\","
    fi
    if [ "$data_latitude" != "null" ] && [ ! -z "$data_latitude" ]; then
        payload+="\"latitude\": $data_latitude,"
    fi
    if [ "$data_longitude" != "null" ] && [ ! -z "$data_longitude" ]; then
        payload+="\"longitude\": $data_longitude,"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Site: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$sites" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Locations
url_option=dcim/locations
url=$url_source/api/$url_option/?limit=0
locations=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $locations | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    locations_info="$1"
    url_option=$2

    data_site_name=$(echo $locations_info | jq -r ".site.name")
    data_site_slug=$(echo $locations_info | jq -r ".site.slug")
    data_name=$(echo $locations_info | jq -r ".name")
    data_slug=$(echo $locations_info | jq -r ".slug")
    data_status=$(echo $locations_info | jq -r ".status.value")
    data_description=$(echo $locations_info | jq -r ".description")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_site_name" != "null" ] && [ ! -z "$data_site_name" ] && [ "$data_site_slug" != "null" ] && [ ! -z "$data_site_slug" ]; then
        payload+="\"site\": {\"name\": \"$data_site_name\", \"slug\": \"$data_site_slug\"},"
    fi
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_slug" != "null" ] && [ ! -z "$data_slug" ]; then
        payload+="\"slug\": \"$data_slug\","
    fi
    if [ "$data_status" != "null" ] && [ ! -z "$data_status" ]; then
        payload+="\"status\": \"$data_status\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    echo "Location: $data_name"
    curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
    echo -e "\n\n\n"
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$locations" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"

#Racks
url_option=dcim/racks
url=$url_source/api/$url_option/?limit=0
racks=$(curl -s -k -X GET -H "Authorization: Token $token_source" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url")
count=$(echo $racks | jq '.results | length')

post_request() {
    source $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/variablen.sh
    racks_info="$1"
    url_option=$2

    data_site_name=$(echo $racks_info | jq -r ".site.name")
    data_site_slug=$(echo $racks_info | jq -r ".site.slug")
    data_name=$(echo $racks_info | jq -r ".name")
    data_status=$(echo $racks_info | jq -r ".status.value")
    data_description=$(echo $racks_info | jq -r ".description")
    data_width=$(echo $racks_info | jq -r ".width.value")
    data_uheight=$(echo $racks_info | jq -r ".u_height")

    payload="{"

    # Überprüfung und Hinzufügen
    if [ "$data_site_name" != "null" ] && [ ! -z "$data_site_name" ] && [ "$data_site_slug" != "null" ] && [ ! -z "$data_site_slug" ]; then
        payload+="\"site\": {\"name\": \"$data_site_name\", \"slug\": \"$data_site_slug\"},"
    fi
    if [ "$data_name" != "null" ] && [ ! -z "$data_name" ]; then
        payload+="\"name\": \"$data_name\","
    fi
    if [ "$data_status" != "null" ] && [ ! -z "$data_status" ]; then
        payload+="\"status\": \"$data_status\","
    fi
    if [ "$data_description" != "null" ] && [ ! -z "$data_description" ]; then
        payload+="\"description\": \"$data_description\","
    fi
    if [ "$data_width" != "null" ] && [ ! -z "$data_width" ]; then
        payload+="\"width\": $data_width,"
    fi
    if [ "$data_uheight" != "null" ] && [ ! -z "$data_uheight" ]; then
        payload+="\"u_height\": $data_uheight,"
    fi

    # Entfernen des letzten Kommas, falls vorhanden
    payload="${payload%,}"

    # Hinzufügen des schließenden geschweiften Klammerns
    payload+="}"

    # überprüfen, ob schon vorhanden, weil es sonst mehrfach in der netbox drin ist
    check=$(curl -s -k -X GET -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" "$url_dest/api/$url_option/?limit=0" | jq ".results | .[]" | grep "$data_name")

    if [ -z "$check" ]; then
        echo "Rack: $data_name"
        curl -s -k -X POST -H "Authorization: Token $token_dest" -H "Accept: application/json; inent=4" -H "Content-Type: application/json" --data "$payload" "$url_dest/api/$url_option/" | jq
        echo -e "\n\n\n"
    fi
}
export -f post_request

# Parallele Ausführung der POST-Anfragen
echo "$racks" | jq -c '.results[]' | parallel -j $how_many_parallel post_request {} "$url_option"