FROM nginx:latest

COPY sites/default.conf /etc/nginx/conf.d/

COPY nginx.conf /etc/nginx
RUN apt-get update
RUN apt-get -y install curl dos2unix

RUN mkdir /.nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

ENV NODE_VERSION=16.11.1

ENV NVM_DIR=/root/.nvm

RUN /bin/bash -c "source ~/.profile"

RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

RUN npm install yarn -g

WORKDIR /app

RUN mkdir /var/.startup

COPY ./env/.ca.cnf /var/.ca.cnf

COPY ./install.sh /var/.startup/install.sh
RUN dos2unix /var/.startup/install.sh
RUN ["chmod", "+x", "/var/.startup/install.sh"]

COPY ./entrypoint.sh /var/.startup/entrypoint.sh
RUN dos2unix /var/.startup/entrypoint.sh
RUN ["chmod", "+x", "/var/.startup/entrypoint.sh"]

ENTRYPOINT ["sh", "/var/.startup/entrypoint.sh"]
