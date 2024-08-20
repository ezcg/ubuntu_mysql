printf "\n\nmysql version running in container 'db':\n\n"

docker exec -it db mysql -V

#r=$(docker exec -it db mysql -uroot -proot --host=db -e "use laravel_docker;" 2>&1 | grep -v "Using a password")
#printf "\n\n"
#printf "${r}"
#printf "\n\n"

printf "\n\nRunning mysql queries\n\n"
sleep 3
qArr=(
"show databases"
"select user,host from mysql.user where user='mysql.infoschema';"
"select host from mysql.user where user='root';"
"use laravel_docker;"
)

for i in ${!qArr[@]}; do

  printf "\n\n"
  echo "${qArr[$i]}"
  docker exec -it db mysql -uroot -proot --host=db -e "${qArr[$i]}" 2>&1 | grep -v "Using a password"

done

printf "\n\n"

docker exec -it db mysql -V

printf "\m\mmysql Warnings in the logs\n\n"
docker logs db | grep Warning

printf "\n\n"

