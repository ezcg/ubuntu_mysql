#!/bin/bash

#this is needed at build by ubuntu22 and ubuntu24 and fixes error:
#ERROR mysqld: File './binlog.index' not found (OS errno 13 - Permission denied)
# https://stackoverflow.com/questions/52719378/failed-to-find-valid-data-directory-mysql-generic-binary-installion/65214867#65214867

numFiles=$(ls -1q /mysql/dbdata | wc -l)
printf "\nnum files found in /mysql/dbdata: ${numFiles}"

if [ "${numFiles}" -lt 1 ]; then
  printf "\nNot finding any files in mysql/dbdata \n"
fi
if [ ! -f /is_initialized ]; then
  printf "\n /is_initialized was NOT found so mysql considered not initialized, so initializing it...\n\n"
  touch /is_initialized
  mysqld --initialize --user=mysql;
else
  printf "\nthe file /is_initialized was found so mysql considered initialized, so NOT initializing it...\n\n"
fi;
