#!/bin/bash
nginxConfig=$(pwd)/nginx/nginx.conf
initLetsencryptScript=$(pwd)/init_letsencrypt.sh
exampleHostName=example.org
exampleContainerName=app_name

sudo rm -rf ./certbot ./nginx

mkdir ./certbot
mkdir ./nginx
cp ./initialConf/nginx.conf ./nginx/nginx.conf
cp ./initialConf/init_letsencrypt.sh ./init_letsencrypt.sh
read -p "Nome host:" hostName
#read -p "Nome container da proxare: " containerName 
read -p "email per rinnovo certificati: " emailAddr 

#rimpiazzo tutte le occorrenze di example.org con $nomeHost nella configurazione di nginx
sed -i "s/$exampleHostName/$hostName/g" $nginxConfig

#rimpiazzo tutte le occorrenze di $exampleContainerName con $containerName nella configurazione di nginx
#sed -i "s/$exampleContainerName/$containerName/g" $nginxConfig

#rimpiazzo tutte le occorrenze di example.org con $nomeHost nello script iniziale di letsencrypt
sed -i "s/$exampleHostName/$hostName/g" $initLetsencryptScript

#setto email di rinnovo nello script di letsencrypt
sed -i "s/email=.*/email=$emailAddr/" $initLetsencryptScript

chmod +x $initLetsencryptScript
echo "Avvio script letsencrypt e compose"
sudo $initLetsencryptScript

