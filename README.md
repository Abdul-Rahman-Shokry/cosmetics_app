# Cosmetics App

A beautiful Flutter application for cosmetic products, currently featuring a modern onboarding experience and elegant UI design.

## Features

- **Custom Splash Screen**: Engaging entry point for the application.
- **Onboarding Flow**: A multi-step introductory guide to welcome users and explain the app's features.
- **Custom Typography**: Integrates the elegant `LexandPeta-Light` font family for a premium aesthetic feel.
- **Material Design**: Uses Flutter's Material components.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (sdk: ^3.11.1)
- An IDE like Android Studio or VS Code with Flutter plugins

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd cosmetics_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App

To run the application on your connected device or emulator:
```bash
flutter run
```

## Project Structure

```text
lib/
├── main.dart                  # Entry point of the application
└── onboarding/                # Onboarding feature module
    ├── splash_screen.dart     # Initial loading screen
    ├── on_boarding_1.dart     # First onboarding page
    ├── on_boarding_2.dart     # Second onboarding page
    └── on_boarding_3.dart     # Third onboarding page
assets/
├── images/                    # Local image assets
└── fonts/                     # Custom fonts (LexendPeta-Light)
```

## Technologies Used

- [Flutter](https://flutter.dev/) - UI Toolkit
- [Dart](https://dart.dev/) - Programming Language

## Additional Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
