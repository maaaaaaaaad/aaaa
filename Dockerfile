FROM node:16.15.1-alpine

WORKDIR /app/server

COPY package*.json ./

RUN npm install

COPY ./ ./

ENV SERVER_PORT=6464
ENV DATABASE_URL=mysql://root:12345@localhost:3306/prisma

RUN npm i -g prisma
RUN prisma generate
RUN dotenv -e .env.production -- npx prisma migrate --name prod
RUN npm run build

CMD ["npm", "run", "start:prod"]

