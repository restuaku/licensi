FROM php:8.2-cli

COPY . /var/www/html/

RUN mkdir -p /var/www/html/data && \
    chmod -R 777 /var/www/html/data

WORKDIR /var/www/html

RUN chmod +x start.sh

CMD ["bash", "start.sh"]
