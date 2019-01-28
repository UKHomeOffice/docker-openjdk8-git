FROM openjdk:8-jdk-alpine

RUN apk update && apk add git && apk add openssh && apk add bash

COPY src/main/sh/ /root/
