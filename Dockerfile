FROM docker.otenv.com/ot-node-base-4:latest

# override npm registry
RUN npm config set registry "http://artifactory.otenv.com:8081/artifactory/api/npm/npm-virtual"
RUN npm config set always-auth false

COPY package.json /srv/app/package.json
COPY config.json /srv/app/config.json
COPY lib /srv/app/lib

WORKDIR /srv/app
RUN npm install --production
RUN ls -la /srv/app

ENTRYPOINT [ "/usr/local/bin/node", "lib/Redis2StatsD.js", "--interval=5" ]
