FROM node:lts
USER root
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version
RUN echo "Docker Version:" && docker --version

ARG JENKINSUID
ARG JENKINSGID
ARG DOCKERGID

RUN groupadd -og ${JENKINSGID} jenkins
RUN groupmod -og ${DOCKERGID} docker
RUN useradd -oc "Jenkins user" -g ${JENKINSGID} -G ${DOCKERGID} -M -N -u ${JENKINSUID} jenkins