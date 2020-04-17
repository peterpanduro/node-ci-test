FROM node:12-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --only=production
COPY ./build .

EXPOSE 3000
CMD [ "node", "index.js" ]