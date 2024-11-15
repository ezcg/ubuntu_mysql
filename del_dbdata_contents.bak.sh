#!/bin/bash

user=$(whoami)
echo "You are running this as user ${user}"

if [ "${user}" != "root" ]; then
  printf "\nYou must be root to run this script or run this script using sudo.\n"
  exit 1
fi

ok_to_run="no"
printf "\nYou are in directory: \n"
pwd
printf "\n\n"
if [ -d "mysql" ]; then
  printf "mysql directory does exist.\n"
fi
if [ -d "mysql/dbdata" ]; then
  printf "mysql/dbdata directory does exist. You are in the correct directory to run this script.\n "
  ok_to_run="yes"
fi
printf "\n${ok_to_run}\n"
if [ "${ok_to_run}" = "no" ]; then
  printf "\n\nYou must be in the directory of ubuntu_mysql and the parent of mysql/dbdata to run this script.\n\n"
  exit 1
fi

fullDir=$(pwd)
printf "\nThe contents of ${fullDir}/mysql/dbdata:\n"
ls -ltra mysql/dbdata/


printf '\n\nDo you want to delete the contents of mysql/dbdata (y/n)? '
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    cd mysql/dbdata || exit
    rm -fr *
    printf "\nDeleted. Exiting.\n"
    cd ../../
    printf "\nThe contents of mysql/dbdata after deletion:\n"
    ls -ltra mysql/dbdata
    exit 0
else
    echo "Not deleting and exiting."
    exit 1
fi
