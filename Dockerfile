FROM ubuntu
RUN apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install nginx php8.1-fpm php-mysql php-gd -y
WORKDIR /var/www/html/
COPY ./wordpress .
RUN chmod 777 *
COPY ./default /etc/nginx/sites-available/
COPY sjn.sh .
RUN chmod +x sjn.sh
ENTRYPOINT ./sjn.sh
EXPOSE 80