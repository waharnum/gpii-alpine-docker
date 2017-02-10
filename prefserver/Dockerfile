FROM gpiilab/universal
ENV NODE_ENV gpii.preferencesServer.config.production.docker
EXPOSE 8081
WORKDIR /app
COPY gpii.preferencesServer.config.production.docker.json gpii/node_modules/preferencesServer/configs
CMD NODE_ENV=$NODE_ENV node node_modules/kettle/init.js gpii/node_modules/preferencesServer/configs
