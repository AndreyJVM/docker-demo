FROM node:alpine

WORKDIR /app

EXPOSE 5000

COPY package* ./

RUN npm install

COPY . ./

CMD ["npm", "run", "dev"]