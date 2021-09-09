#!/bin/sh

# Decrypt the file
# --batch to prevent interactive command
# --yes to assume "yes" for questions
mkdir -p android/app/src/staging
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output android/app/src/staging/google-services.json .github/workflows/secrets/android-staging-google-services.json.gpg

mkdir -p android/app/src/production
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output android/app/src/production/google-services.json .github/workflows/secrets/android-production-google-services.json.gpg
