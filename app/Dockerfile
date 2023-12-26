FROM node:18-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN  npm ci --log-level=verbose --only=production

COPY public  /app/public
COPY src  /app/src

CMD ["npm", "start"]