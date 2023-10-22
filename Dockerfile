# FROM node:16.13.0-alpine as builder
# # RUN apk add --no-cache chromium
# # ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
# #     PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser 
# # COPY . /app
# WORKDIR /app

# RUN npm install
# RUN npm run lint
# RUN npm run test
# RUN npm run build

# FROM nginx:1.17.10-alpine
# EXPOSE 80
# COPY --from=builder /app/dist/angular-docker-app /usr/share/nginx/html


# Use the official Nginx base image
FROM nginx:1.17.10-alpine

# Copy the custom Nginx configuration file to the container
COPY custom-nginx.conf /etc/nginx/conf.d/default.conf

# Remove the default Nginx welcome page
RUN rm /usr/share/nginx/html/*

# Copy the Angular application's contents to the container's document root
COPY dist/angular-docker-app/ /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
