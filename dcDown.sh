. dc_dialogue.sh
printf "\n\n"
printf "docker compose file to go DOWN: \n\n"
printf ${dcFile}
printf "\n\n"
docker compose -f "${dcFile}" down
