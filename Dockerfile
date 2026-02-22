FROM php:8.2-apache

# Fix MPM conflict: disable event, keep prefork
RUN a2dismod mpm_event 2>/dev/null; a2enmod mpm_prefork rewrite

# Allow .htaccess overrides
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# Copy project files
COPY . /var/www/html/

# Create writable data directory
RUN mkdir -p /var/www/html/data && \
    chown -R www-data:www-data /var/www/html/data && \
    chmod -R 755 /var/www/html/data

WORKDIR /var/www/html

EXPOSE 80

# Runtime: set PORT then start Apache
CMD sed -i "s/Listen 80/Listen ${PORT:-80}/g" /etc/apache2/ports.conf && \
    sed -i "s/:80/:${PORT:-80}/g" /etc/apache2/sites-available/000-default.conf && \
    apache2-foreground
