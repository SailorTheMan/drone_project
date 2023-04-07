#!/bin/bash

DOCKER_IMAGE=sailor/stm-builder
DOCKER_TAG=latest
DOCKER_CONTAINER=stm-builder

terminate() {
    echo "----------------------------------------------------------------"
    echo -e " \e[96mStopping docker container \"${DOCKER_CONTAINER}\"...\e[0m"
    echo -e " \e[96mThis may take a few seconds to complete.\e[0m"
    echo "----------------------------------------------------------------"
    docker kill ${DOCKER_CONTAINER}
    KILLED=$?
    echo "----------------------------------------------------------------"
    if [[ $KILLED -ne 0 ]]; then
        echo -e " \e[91mError stopping docker container \"${DOCKER_CONTAINER}\"\e[0m"
    else
        echo -e " \e[96mDocker container \"${DOCKER_CONTAINER}\" stopped\e[0m"
    fi
    echo "----------------------------------------------------------------"
}

trap terminate SIGKILL SIGINT

# Переменные окружения для запуска контейнера
HOST_USER_NAME=$(id -un)
HOST_USER_ID=$(id -u)
HOST_GROUP_NAME=$(id -g -n ${USERNAME} || echo ${USERNAME})
HOST_GROUP_ID=$(id -g ${USERNAME})
PATH_HOME=/home/app

cd "$(dirname $0)" && \
docker run --rm \
    -e HOST_USER_NAME=${HOST_USER_NAME} \
    -e HOST_USER_ID=${HOST_USER_ID} \
    -e HOST_GROUP_NAME=${HOST_GROUP_NAME} \
    -e HOST_GROUP_ID=${HOST_GROUP_ID} \
    -e PATH_HOME=${PATH_HOME} \
    -e "TERM=xterm-256color" \
    --name ${DOCKER_CONTAINER} \
    -v $(pwd):${PATH_HOME} \
    ${DOCKER_IMAGE}:${DOCKER_TAG} \
    ./build.sh ${*} &
wait -n


