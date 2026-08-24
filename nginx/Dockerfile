FROM nginx:alpine
# Copy the init script and make it executable at build time,
# so it is not affected by Windows filesystem mount permission issues.
COPY init-ssl.sh /docker-entrypoint.d/99-init-ssl.sh
RUN chmod +x /docker-entrypoint.d/99-init-ssl.sh
