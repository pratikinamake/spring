#!/bin/bash

git clone https://github.com/ragsns/hello-world-spring-boot.git

cd hello-world-spring-boot

mvn clean install

docker build -t spring .

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 031173150068.dkr.ecr.us-east-1.amazonaws.com

docker tag spring:latest 031173150068.dkr.ecr.us-east-1.amazonaws.com/spring:latest

docker push 031173150068.dkr.ecr.us-east-1.amazonaws.com/spring:latest

