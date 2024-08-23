#!/bin/bash

dateStr=$(printf "%(%H.%M_%Y-%m-%d)T")

. dc_dialogue.sh

printf "\n\n"
printf "docker compose file to BUILD: \n\n"
printf ${dcFile}
printf "\n\n"
docker compose --progress=plain -f "${dcFile}" build --no-cache | tee "${dateStr}"_"${dcFile}"_build.log 2>&1
