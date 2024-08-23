#!/bin/bash

printf "\n\nThis script should be executed manually inside the db container after mysql has been initialized and only done once.\n\n"

if [ -f /.dockerenv ]; then
  echo "Running inside a container"
else
  echo "Running outside a container"
  exit 1
fi

if [ -f /is_initialized ]; then
  echo "mysql appears to have been initialized"
else
  echo "mysql does NOT appear to have been initialized. When mysql is intialized a file /is_initialized is created and that file is not found."
  exit 1
fi

# get temporary password from error.log
# 2024-08-22T21:25:07.447596Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@    localhost: Zo8Plk#y/lUp
str=$(cat /var/log/mysql/error.log | grep -o "A temporary password is generated for .*: .*$")
printf "\n\n"
echo "${str}"
printf "\n\n"
str2=$(echo "${str}" | grep -o ": .*$")
#echo "$str2"

# remove : and any spaces
password=$(echo "${str2:1}" | tr -d ' ')
#echo "|$password|"
#password="root"
printf "The password is:\n"
echo "${password}"
#printf "\nCopy it and paste it at the prompt and hit enter:\n\n"

#change the root user's password to root
mysql --connect-expired-password -uroot -p"${password}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'";

mysql -uroot -proot -e "select Host, User from mysql.user where user='root'\G"

debianPassword=$(grep -m 1 -oP "(?<=password =).*$" /etc/mysql/debian.cnf | tr -d ' ')

mysql -uroot -proot -e "CREATE USER 'debian-sys-maint'@'localhost' IDENTIFIED BY '${debianPassword}'"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' WITH GRANT OPTION";
mysql -uroot -proot -e "FLUSH PRIVILEGES";

service mysql status




