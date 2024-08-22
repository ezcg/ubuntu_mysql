#!/bin/bash

#this is needed at build by ubuntu22 and ubuntu24

numFiles=$(ls -1q /mysql/dbdata | wc -l)
printf "\nnum files found in /mysql/dbdata: ${numFiles}"

if [ "${numFiles}" -lt 1 ]; then
  #ERROR mysqld: File './binlog.index' not found (OS errno 13 - Permission denied)
  # https://stackoverflow.com/questions/52719378/failed-to-find-valid-data-directory-mysql-generic-binary-installion/65214867#65214867
  #
  printf "\nmysqld init\n"
  mysqld --initialize
else
  printf "\nfiles found in /mysql/dbdata so not initilizing\n"
fi

service mysql start

service mysql status


