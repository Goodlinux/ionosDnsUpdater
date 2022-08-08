# IonosDnsUpdater
Update DNS by API in Shell
based on the project : 

image:https://img.shields.io/static/v1?label=based on&message=DomainConnectDDNS-Python&color=blue[link=https://github.com/Domain-Connect/DomainConnectDDNS-Python,float="left"]

Take your local IP and send it to ionos if it has changed 
Contenair Docker to periodcaly update the IP adress of my DNS hosted in Ionos 
Modifiez la variable d'environnement DOMAIN pour qu'elle colle à votre Nom de domaine à mettre à jour Modifiez la variable  
TZ pour qu'elle colle avotre Timezone 

Vous pouvez aussi mofifier le declenchement de la verification et mise a jour via la commande crontab du script (par default 5 minutes) 
Aprés avoir lancé le conteneur il faut aller un terminal pour valider le lien avec votre domaine. lancer le script "setupDomain" 
autre option lancer la commande suivante 
domain-connect-dyndns setup --domain xx.votredomaine.com 
et suivez les instructions 

Pour construire l'image Docker, télécharger le fichier DockerFile dans un dossier, placez vous dans le dossier et lancer la commande 
docker build -t NomDeVotreConteneur --no-cache --force-rm . 
Vous pouvez aussi télécharger l'image depuis le Docker Hub : 

image:https://img.shields.io/static/v1?label=docker&message=Image Docker&color=green[link=https://hub.docker.com/r/goodlinux/dnsupdater,float="left"]

# INSTALLATION 

Lors du premier lancement, un message va apparaitre vous invitant a coller une adresse dans le navigateur WEB 
https://domainconnect.1and1.com/async/v2/domainTemplates/providers/domainconnect.org?client_id=domainconnect.org&scope=dynamicdns-v2&domain=dns.me&host=my&IP=0.0.0.0&IPv4=0.0.0.0&IPv6=%3A%3A&redirect_uri=https%3A%2F%2Fdynamicdns.domainconnect.org%2Fddnscode

pour récupérer la cléf de connexion pour la mise à jour du nom de domaine. 
Copiez cette adresse compléte dans le navigateur Web, autorisez l'accés, copiez le code d'authorisation et collez le 
afin d'autoriser cette connexion

Vous pouvez aussi opter pour une configuration manuelle, quand votre container est lancé, vous pouvez dans un shell lancer la comande suivante : 
domain-connect-dyndns setup --domain new.domain.org --config \$CONFFILE 
and follow the instructions. You can parameter others domain via this command. at the launch of update, all the parameterised domain will be updated. 


# ENVIRONMENT 
 DOMAIN = DNS DOMAIN name to be updated  ex : my.dns.org  
 TZ = TimeZone  ex : Europe/Paris  
 CONFFILE = place to store dns config and key  ex : /root/dns-update.conf  
 CRONDELAY = delay to verify if the ip has changes in minutes ex :  */5 for evry 5 minutes   
