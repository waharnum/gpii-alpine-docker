FROM gpiilab/nodejs
USER app
RUN git clone --depth=1 https://github.com/GPII/universal /app && \
      npm install && \
      npm prune --production
