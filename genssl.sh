#!/bin/bash
openssl \
    req \
    -new \
    -nodes \
    -days 3650 \
    -x509 \
    -newkey rsa:4096 \
    -keyout ./traefik/certificates/cert.key \
    -out ./traefik/certificates/cert.crt \
    -subj "/CN=localhost" \
    -addext "subjectAltName = DNS:social.localhost"
