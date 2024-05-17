#!/usr/bin/env bash

DATE=$(date +"%Y-%m-%d")
PRIVATE_KEYS="gpg_private_keys_$DATE.asc"
PUBLIC_KEYS="gpg_public_keys_$DATE.asc"

gpg --export-secret-keys > "./$PRIVATE_KEYS"

gpg --export > "./$PUBLIC_KEYS"

