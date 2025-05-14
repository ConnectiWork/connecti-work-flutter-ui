# ConnectiWork

ConnectiWork is a mobile app for job connections during the 2030 World Cup in Morocco. It helps regular people (youth, adults, unemployed) find short-term jobs during the event, such as restaurant workers, event organizers, and security personnel.

## Features

- Modern UI with iOS-inspired design
- Google Maps integration for job location visualization
- Job swipe interface
- Chat functionality
- Multilingual support
- Profile management

## Getting Started

### API Keys Setup

This project requires a Google Maps API key to function properly. For security reasons, the actual API keys have been removed from the repository and replaced with placeholders.

Before running the app, you need to:

1. Get a Google Maps API key from the [Google Cloud Console](https://console.cloud.google.com/)
2. Replace the placeholder `YOUR_API_KEY_HERE` with your actual API key in the following files:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/AppDelegate.swift`
   - `ios/Runner/Info.plist`

### Running the App

1. Ensure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Set up your API keys as described above
5. Run `flutter run` to start the app

## Resources

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
