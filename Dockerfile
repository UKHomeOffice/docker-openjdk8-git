FROM openjdk:8-jdk-alpine

RUN apk update && apk add git && apk add openssh

COPY src/main/sh/ /root/
