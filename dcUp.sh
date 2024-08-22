#!/bin/bash

. dc_dialogue.sh

printf "\n\n"
printf "docker compose file to go UP: \n\n"
printf ${dcFile}
printf "\n\nIf it hasn't been built yet, it will be built before going up, \nbut it may use cache when building so it is better to build using\ndcBuild.sh which use the  --no-cache flag\n"
printf "\n\nIf you get an Invalid MySQL server downgrade error, run dcDown.sh and delete the files in ./mysql/dbdata and run dcUp.sh again\n\n"

docker compose -f "${dcFile}" up
#sleep 3
#bash get_output.sh

