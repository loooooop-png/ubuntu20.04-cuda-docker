# Ubuntu20.04 wth cuda deployed in docker container
This repository contains docker-compose.yml of ubuntu20.04 wth cuda that you can use it easily.
## NOTICE
> 1 . This repository's container is a ubuntu container with cuda driver of 12.2.2. You can use it through ssh service by change port mapping.  
> 2 . You shou edit docker-compose.yml according to your requirement.  
> 3 . The container has installed **conda** already.  
> 4 . The container has installed **ssh** service already. You should change **port mapping** in docker-compose.yml so that you can get into container by ssh service.  
> 5 . The username and password is **root**.
## Usage  
    docker-compose up -d