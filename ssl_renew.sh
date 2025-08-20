#!/bin/bash
set -e

certbot renew --quiet
systemctl reload nginx

echo "Certificati TLS rinnovati e Nginx ricaricato"
