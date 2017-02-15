FROM gpiilab/universal
ENV NODE_ENV gpii.preferencesServer.config.production
EXPOSE 8081
WORKDIR /app
CMD NODE_ENV=$NODE_ENV node node_modules/kettle/init.js gpii/node_modules/preferencesServer/configs
