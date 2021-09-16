#!/bin/sh

# Decrypt the file
# --batch to prevent interactive command
# --yes to assume "yes" for questions

# env
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output .env .github/workflows/secrets/.env.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output .env.staging .github/workflows/secrets/.env.staging.gpg

# Android
mkdir -p android/app/src/staging
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output android/app/src/staging/google-services.json .github/workflows/secrets/android-staging-google-services.json.gpg

mkdir -p android/app/src/production
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output android/app/src/production/google-services.json .github/workflows/secrets/android-production-google-services.json.gpg

# iOS
mkdir -p ios/fastlane/certs
gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output ios/fastlane/certs/Adhoc_Distribution_Lucas_Flutter_Survey.mobileprovision .github/workflows/secrets/ios_Adhoc_Distribution_Lucas_Flutter_Survey.mobileprovision.gpg

gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output ios/fastlane/certs/distribution_certificate_4TWS7E2EPE.cer .github/workflows/secrets/ios_distribution_certificate_4TWS7E2EPE.cer.gpg

gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output ios/fastlane/certs/private_certificate.p12 .github/workflows/secrets/ios_private_certificate.p12.gpg

gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output ios/Runner/GoogleService-Info.plist .github/workflows/secrets/ios-GoogleService-Info.plist.gpg
