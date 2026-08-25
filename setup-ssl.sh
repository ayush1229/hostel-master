#!/bin/bash
# setup-ssl.sh - Helper script to fetch initial Let's Encrypt certificates

if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup-ssl.sh <your-domain> <your-email>"
    echo "Example: ./setup-ssl.sh example.com admin@example.com"
    exit 1
fi

DOMAIN=$1
EMAIL=$2

echo "Requesting Let's Encrypt certificates for $DOMAIN..."
echo "Domains: authority.$DOMAIN, student.$DOMAIN, guard.$DOMAIN, api.$DOMAIN"

docker compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    -d authority.$DOMAIN \
    -d student.$DOMAIN \
    -d guard.$DOMAIN \
    -d api.$DOMAIN \
    --email $EMAIL \
    --rsa-key-size 4096 \
    --agree-tos \
    --no-eff-email \
    --force-renewal" certbot

echo ""
echo "Reloading Nginx to apply the new certificates..."
docker compose exec nginx nginx -s reload

echo "SSL setup complete!"
