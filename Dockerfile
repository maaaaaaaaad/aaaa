FROM node:16.15.1-alpine

WORKDIR /app/server

COPY package*.json ./
COPY prisma ./prisma/

RUN npm install -g dotenv-cli
RUN npm i -g prisma
RUN npm ci

COPY ./ ./

ENV CI=true
RUN npm run test:e2e

ENV SERVER_PORT=6464
ENV DATABASE_URL=mysql://root:12345@db:3306/prisma

RUN prisma generate
RUN npm run build

CMD ["npm", "run", "start:prod"]

