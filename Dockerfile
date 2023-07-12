#Install Setup Node
FROM node:alpine3.18 as nodeapp
WORKDIR /reactapp
COPY package.json .
RUN npm install --force
COPY . .
RUN npm run test
RUN npm run build

#Install Setup nginx
FROM nginx:1.25.1-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=nodeapp /reactapp/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;"  ]
