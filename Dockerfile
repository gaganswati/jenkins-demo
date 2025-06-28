# Use official Drupal base image
FROM drupal:10.2-apache

# Copy your custom modules/themes from GitHub clone
# Assuming your Drupal project is in ./drupal/ (relative to Dockerfile)
COPY ./drupal /var/www/html

# Set correct permissions (optional, adjust as needed)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 (already exposed in base image)
