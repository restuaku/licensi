FROM php:8.2-cli

# Copy project files
COPY . /var/www/html/

# Create writable data directory
RUN mkdir -p /var/www/html/data && \
    chmod -R 777 /var/www/html/data

WORKDIR /var/www/html

# Use PHP built-in server - simple & reliable
CMD php -S 0.0.0.0:${PORT:-80} api.php
