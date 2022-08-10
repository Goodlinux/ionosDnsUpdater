FROM alpine:latest
MAINTAINER Ludovic MAILLET <Ludoivc@maillet.me>

# Installation de domain-connect
# Mise en place des time zone pour que l'heure soit correct sur le systeme
# Creation du batch de mise à jour du domaine avec log
# crontab : Ajout de la commande de mise à jour du domaine a crontab (toutes les 5 minutes)
# Rendre les batch executables

ENV API_KEY=xxx.yyyy  \
    DNS_TYPE=A  \
    DOMAIN=test.maillet.me \ 
    TZ=Europe/Paris

RUN apk -U upgrade && apk add git curl apk-cron tzdata jq nano \ 
  && cd /opt && git clone https://github.com/Goodlinux/IonosDnsUpdater.git && chmod a+x /opt/IonosDnsUpdater/updateDns.sh \
  && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ >  /etc/timezone \ 
  && echo "apk -U upgrade && cd /opt/IonosDnsUpdater && git pull" > /usr/local/bin/updtPkg \ 
  && echo '*/5     *       *       *       *       /opt/IonosDnsUpdater/updateDns.sh' >> /etc/crontabs/root \
  && echo '00     1       *       *       sun       /usr/local/bin/updtPkg' >> /etc/crontabs/root \ 
  && echo "#! /bin/sh"                                                     > /usr/local/bin/entrypoint.sh \
  && echo "echo 'Mise à jour ...'"                                         >> /usr/local/bin/entrypoint.sh  \
  && echo "apk -U upgrade "                                                >> /usr/local/bin/entrypoint.sh  \
  && echo "cd /opt/IonosDnsUpdater  && git pull --rebase"                  >> /usr/local/bin/entrypoint.sh  \
  && echo "chmod +x /opt/IonosDnsUpdater/updatDns.sh"                      >> /usr/local/bin/entrypoint.sh  \
  && echo "echo 'lancement de cron ...'"                                   >> /usr/local/bin/entrypoint.sh  \
  && echo "crond -b "                                                      >> /usr/local/bin/entrypoint.sh  \
  && echo "/bin/sh"                                                        >> /usr/local/bin/entrypoint.sh  \
  && chmod a+x /usr/local/bin/*
# Lancement du daemon cron
CMD /usr/local/bin/entrypoint.sh
