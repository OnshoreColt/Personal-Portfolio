# Stage 1: Build the Hugo site
FROM hugomods/hugo:exts-0.145.0 AS builder

WORKDIR /src
COPY . /src

RUN npm install --prefix /src

# Fetch modules (if using Hugo modules) and build the site
RUN hugo mod get -u && hugo --minify

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Default Nginx command is fine, no need to override