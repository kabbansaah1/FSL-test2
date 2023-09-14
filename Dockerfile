FROM node:15

WORKDIR /app

COPY . /app

RUN npm install

RUN npm run build

EXPOSE 80

CMD npm run start