#!/bin/bash

path=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# First Skript
bash ${path}/organization.sh

# Second Skript
bash ${path}/devices.sh

# Third Skript

#### Coming