#!/bin/bash
num=$1
if [ -z "${num}" ]; then
	printf "\n\nPossible projects:\n"
	printf "1 php8.2-fpm-alpine-Dockerfile and mysql image\n"
	printf "2 s3OnlySite\n"
	printf "3 slimandbusty\n"
	printf "4 atheistdogs\n"
	read -p "Type number of project and hit enter:" num
fi

project=""
if [[ "$num" == 1 ]]; then
  project="1"
elif [[ "$num" == 2 ]]; then
  project="s3OnlySite"
elif [[ "$num" == 3 ]]; then
  project="slimandbusty"
elif [[ "$num" == 4 ]]; then
  project="atheistdogs"
else
  printf "\nNot recognizing entry: $num\n"
  exit
fi

#if ! [ -f ${site}.env ]; then
#  echo "${site}.env does not exist and must be created. See .env.example"
#  exit
#fi

dcFile="dc${project}.yml"

printf "\nProject: ${project}\n\n"
