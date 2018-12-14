FROM python:3.7.0

# Install node prereqs, nodejs and yarn
# Ref: https://deb.nodesource.com/setup_10.x
# Ref: https://yarnpkg.com/en/docs/install
RUN \
  apt-get update && \
  apt-get install -yqq apt-transport-https
RUN \
  echo "deb https://deb.nodesource.com/node_8.x stretch main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -yqq nodejs yarn && \
  pip install -U pip && pip install pipenv && \
  npm i -g npm@^6 && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libgtkextra-dev libgconf2-dev libnss3 libasound2 libxtst-dev libxss1 libcanberra-gtk-module

COPY ./GrandeOmega/ /var/GrandeOmega/

RUN python --version

WORKDIR /var/GrandeOmega

RUN yarn add electron-prebuilt@1.4.13

CMD ["node", "./bin/my-app.js"]