# Use an official PHP runtime as a parent image
FROM php:7.4-apache

# Install any PHP extensions if required
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set the working directory
WORKDIR /var/www/html

# Copy the current directory contents into the container
COPY . /var/www/html/

# Expose port 80 for web traffic
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
