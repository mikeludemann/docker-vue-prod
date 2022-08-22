FROM node:alpine AS production

ENV NODE_ENV production

# Add a work directory
WORKDIR /app

# Cache dependencies
COPY package*.json .
COPY yarn.lock .

# Install dependencies
RUN yarn install

# Copy app files
COPY . .

# Build the application
RUN yarn run build

# ------------------------------------------------

FROM httpd:alpine

# Server path
WORKDIR /var/www/html

# Copy
COPY --from=production /app/build .

# Start the app
CMD [ "sudo", "service", "apache2", "restart" ]
