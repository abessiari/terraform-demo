#!/usr/bin/env bash
# set -x

terraform -chdir=aws init
terraform -chdir=aws apply -auto-approve 

servers=`terraform -chdir=aws output -json | jq .demo_servers.value`
servers=`echo $servers | tr -d '[,"]'`
servers=($servers)

echo "[ubuntu]" > hosts
for server in ${servers[@]}
do
    echo "$server ansible_user=ubuntu" >> hosts
    ansible-playbook -i hosts stage.yaml
    ansible-playbook -i hosts start_services.yaml
done

for server in ${servers[@]}
do
    echo "http://$server"
done
