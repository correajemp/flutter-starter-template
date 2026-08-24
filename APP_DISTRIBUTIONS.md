# App Distribution Guide

This guide explains how to use Fastlane to build and distribute the Flutter application to **Firebase App Distribution** for both Android and iOS.

---

## Prerequisites

Ensure you have the following installed on your machine:
- **Ruby & Bundler**: Used to manage Fastlane dependencies.
- **Flutter SDK**: Installed and configured in your `PATH`.
- **Firebase CLI / Token**: Needed for App Distribution authorization.

---

## 1. Environment Setup

Copy `.env.example` to create your local `.env` if you haven't already. You need to configure the following environment variables for Fastlane distribution:

```env
# Fastlane & Firebase App Distribution Configuration
FIREBASE_TOKEN=your_firebase_cli_token_here
FIREBASE_APP_ID_ANDROID_STG=1:123456789:android:stg_app_id
FIREBASE_APP_ID_ANDROID_PROD=1:123456789:android:prod_app_id
FIREBASE_APP_ID_IOS_STG=1:123456789:ios:stg_app_id
FIREBASE_APP_ID_IOS_PROD=1:123456789:ios:prod_app_id
```

> **Note on Firebase Token:** You can generate a token by running `firebase login:ci` via the Firebase CLI, or configure Google Application Default Credentials / service accounts using `GOOGLE_APPLICATION_CREDENTIALS`.

---

## 2. One-Time Project Setup

Before running distribution lanes for the first time, install Bundler gems and Fastlane plugins:

### Android Setup
```bash
cd android
bundle install
bundle exec fastlane install_plugins
cd ..
```

### iOS Setup
```bash
cd ios
bundle install
bundle exec fastlane install_plugins
cd ..
```

---

## 3. Distribution Commands

Fastlane runs from within the platform-specific directories (`android/` or `ios/`).

### Android Distribution

Builds the APK with the corresponding flavor/environment and uploads to Firebase App Distribution.

```bash
cd android

# Distribute Staging flavor
bundle exec fastlane distribute_stg

# Distribute Production flavor
bundle exec fastlane distribute_prod
```

### iOS Distribution

Builds the IPA with the corresponding flavor/environment and uploads to Firebase App Distribution.

```bash
cd ios

# Distribute Staging flavor (ad-hoc export method)
bundle exec fastlane distribute_stg

# Distribute Production flavor (ad-hoc export method)
bundle exec fastlane distribute_prod
```

---

## Troubleshooting

### iOS Code Signing Issues
To successfully export the iOS `.ipa` file locally, you must have the correct Provisioning Profiles and Certificates (Development/Ad-hoc) installed in Xcode. Ensure your active profile supports the target bundle ID and is valid.

### Wildcard Paths for iOS IPAs
The Fastfile dynamically detects the build IPA file under `build/ios/ipa/*.ipa`. If you have multiple IPAs or build caches from previous runs, make sure to clean the build directory before building:
```bash
flutter clean
```
