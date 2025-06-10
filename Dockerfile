FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    sqlite3 \
    npm \
    nodejs

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_sqlite mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application code
COPY . /var/www

# Fix permissions (especially for logs and cache)
RUN mkdir -p /var/www/storage/logs \
    && mkdir -p /var/www/bootstrap/cache \
    && chown -R www-data:www-data /var/www \
    && chmod -R ug+rwx /var/www/storage \
    && chmod -R ug+rwx /var/www/bootstrap/cache

# Install backend and frontend dependencies
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

# Create SQLite DB file if needed
RUN mkdir -p database && touch database/database.sqlite

# ❌ DO NOT cache config here — moved to runtime!
# RUN php artisan config:cache \
#     && php artisan route:cache \
#     && php artisan view:cache

# Add runtime script for Laravel + logging
COPY wait-for-log.sh /usr/local/bin/wait-for-log.sh
RUN chmod +x /usr/local/bin/wait-for-log.sh

# Expose port
EXPOSE 8000

# Start Laravel server and stream log (via script)
CMD ["wait-for-log.sh"]
