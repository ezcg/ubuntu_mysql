#!/bin/bash
num=$1
if [ -z "${num}" ]; then
	printf "\n\nPossible projects:\n"
	printf "1 mysql8.0_oracle-linux-server9.4_Dockerfile\n"
	printf "2 mysql8.0_ubuntu22_Dockerfile\n"
	printf "3 slimandbusty\n"
	printf "4 atheistdogs\n"
	read -p "Type number of project and hit enter:" num
fi

project=""
if [[ "$num" == 1 ]]; then
  project="1"
elif [[ "$num" == 2 ]]; then
  project="2"
elif [[ "$num" == 3 ]]; then
  project="slimandbusty"
elif [[ "$num" == 4 ]]; then
  project="atheistdogs"
else
  printf "\nNot recognizing entry: $num\n"
  exit
fi

printf "\nSelected Project: ${project}\n\n"

#if ! [ -f ${site}.env ]; then
#  echo "${site}.env does not exist and must be created. See .env.example"
#  exit
#fi

dcFile="dc${project}.yml"


