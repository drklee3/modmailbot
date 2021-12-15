FROM node:14-alpine
LABEL name "modmailbot"
LABEL version "3.2.0"

RUN apk add bash git make libc-dev gcc linux-headers eudev-dev jq curl

WORKDIR /usr/modmailbot

COPY package.json package-lock.json ./
RUN npm ci --production

RUN mkdir -p /data/db \
  && mkdir /data/logs \
  && mkdir /data/attachments

COPY src ./src
COPY knexfile.js ./knexfile.js

CMD ["npm", "start"]
