# flutter_bloc_cubit

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project 
- Structure: MVVM
- State Management: Bloc-Cubit
- Firebase Services:
  - FireStore
  - Authentication

# Flavor
- Production
- Demo

## Command
- generate Localization
  - flutter gen-l10n --template-arb-file=en.arb 
- generate DefaultFirebaseOptions
  - create app, if not existed : flutterfire configure
  - flutterfire configure --project=<firebase_project_id> --out=lib/firebase_options_demo.dart --ios-bundle-id=<package_id> --android-app-id=<package_id>
- generate Fingerprint (Android)
  -  keytool -keystore <path-to-debug-or-production-keystore> -list -v  

## Release
- dart-define for config
- shell script