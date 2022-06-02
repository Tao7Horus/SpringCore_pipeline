FROM node:12.18-alpine

WORKDIR /app

COPY . .
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

RUN npm install && npm install -g pm2

CMD ["pm2-runtime", "ecosystem.config.js"]
