FROM node:alpine

WORKDIR /api

COPY package*.json ./

# RUN npm install --only=production
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node","index.js"]
