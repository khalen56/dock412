# Dock412

## Installation

* Déployer une image mariadb : `docker run --name mariadb -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_DATABASE=t412 -d mariadb:latest`
* Construire l'image : `docker build . -t dock412`
* Lancer l'image :

    docker run -it \
    --restart always \
    --link mariadb:mysql \
    -e "T411_DOMAIN=le_domaine_pour_l_application" \
    -e "T411_USER=utilisateur_pour_cron" \
    -e "T411_KEY=une_clef_256_bits" \
    --dns 8.8.8.8 \
    --name t412 \
    -d \
    dock412