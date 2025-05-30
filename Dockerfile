FROM php:8.1-apache
# Set the working directory
WORKDIR /var/www/html

# Copy the current directory contents into the container
COPY . /var/www/html/

# Expose port 80 for web traffic
EXPOSE 80
