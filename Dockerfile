FROM nginx:1.29.0-alpine

WORKDIR /app
COPY ./public /app
COPY nginx.conf /etc/nginx/templates/default.conf.template

EXPOSE 9999
