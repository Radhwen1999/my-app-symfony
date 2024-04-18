# Use the official PHP image with Apache
FROM php:8.2.12-apache

# Install system dependencies and PHP extensions required for Symfony
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set Composer to allow super user operation, adjust as necessary for security in production
ENV COMPOSER_ALLOW_SUPERUSER=1

# Copy existing application directory contents to the working directory
COPY . /var/www/html

# Install dependencies
RUN composer install --no-interaction

# Change ownership of the application directory
RUN chown -R www-data:www-data /var/www/html

# Enable mod_rewrite for URL rewrite and mod_headers for .htaccess extra headers like Access-Control-Allow-Origin-
RUN a2enmod rewrite headers

# Expose port 80
EXPOSE 80
