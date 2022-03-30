FROM node:16.14.0-alpine as build
WORKDIR /app
COPY . /app/
RUN npm install --silent
RUN npm install react-scripts@3.0.1 -g silent
RUN npm run build

FROM  nginx:1.16.0-alpine
COPY  --from=build /app/build  /var/www
RUN   rm /etc/nginx/conf.d/default.conf
COPY  nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]