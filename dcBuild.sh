#!/bin/bash

. dc_dialogue.sh

printf "\n\n"
printf "docker compose file to BUILD: \n\n"
printf ${dcFile}
docker compose -f "${dcFile}" build --no-cache
