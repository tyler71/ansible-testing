appname := "control"

start:
    #!/bin/bash
    if [ ! -f nodes/id_rsa ]; then
        echo "Need to create the public keys"
        ssh-keygen -t rsa -f nodes/id_rsa -q -N ""
        docker-compose build
    fi
    docker-compose up -d
    just enter
stop:
    docker-compose stop
remove:
    docker-compose down
enter:
    #!/usr/bin/env bash
    DB="$(docker inspect -f '{{ "{{" }} .Name {{ "}}" }}' $(docker-compose ps -q {{appname}}) | cut -c2-)"
    docker container exec -it "$DB" zsh
