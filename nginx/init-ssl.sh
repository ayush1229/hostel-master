#!/bin/sh
CERT_DIR="/etc/letsencrypt/live/hostel"
if [ ! -f "$CERT_DIR/fullchain.pem" ]; then
    echo "Let's Encrypt certificates not found. Generating dummy certificates to allow Nginx to start..."
    apk add --no-cache openssl
    mkdir -p $CERT_DIR
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout $CERT_DIR/privkey.pem \
        -out $CERT_DIR/fullchain.pem \
        -subj "/CN=localhost"
    touch $CERT_DIR/is_dummy
fi
