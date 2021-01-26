FROM nginx:1.19.6

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 5432
