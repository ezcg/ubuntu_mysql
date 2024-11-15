#!/bin/bash

get_current_user() {
  whoami
}

check_root_user() {
  local current_user="$1"
  if [ "$current_user" != "root" ]; then
    printf "\nYou must be root to run this script or run this script using sudo.\n"
    exit 1
  fi
}

check_directories() {
  local ok_to_run="no"

  printf "\nYou are in directory: $(pwd)\n\n"
  if [ -d "mysql" ]; then
    printf "mysql directory does exist.\n"
  fi
  if [ -d "mysql/dbdata" ]; then
    printf "mysql/dbdata directory does exist. You are in the correct directory to run this script.\n"
    ok_to_run="yes"
  fi

  echo "$ok_to_run"
}

confirm_directory() {
  local dir_status="$1"
  if [ "$dir_status" = "no" ]; then
    printf "\n\nYou must be in the directory of ubuntu_mysql and the parent of mysql/dbdata to run this script.\n\n"
    exit 1
  fi
}

list_and_remove_dbdata() {
  printf "\nThe contents of $(pwd)/mysql/dbdata:\n"
  ls -ltra mysql/dbdata/

  printf '\n\nDo you want to delete the contents of mysql/dbdata (y/n)? '
  read -r answer

  if [ "$answer" != "${answer#[Yy]}" ]; then
    cd mysql/dbdata || exit
    rm -fr -- *
    printf "\nDeleted. Exiting.\n"
    cd ../../
    printf "\nThe contents of mysql/dbdata after deletion:\n"
    ls -ltra mysql/dbdata
    exit 0
  else
    printf '\n\n'
    echo "Not deleting and exiting."
    printf '\n\n'
    exit 1
  fi
}

main() {
  local current_user
  current_user=$(get_current_user)
  echo "You are running this as user ${current_user}"

  check_root_user "$current_user"

  local ok_to_run
  ok_to_run=$(check_directories)

  confirm_directory "$ok_to_run"

  list_and_remove_dbdata
}

main
