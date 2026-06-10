# Cosmetics App

A beautiful Flutter application for cosmetic products, featuring a modern onboarding experience, elegant UI design, and robust architecture.

## Features

- **Custom Splash Screen**: Engaging entry point for the application.
- **Onboarding Flow**: A multi-step introductory guide to welcome users and explain the app's features.
- **State Management & Networking**: Uses `flutter_bloc` for scalable state management and `dio` for efficient API requests.
- **Local Storage**: Uses `shared_preferences` for managing local user data and sessions.
- **Custom Typography**: Integrates elegant fonts like `Montserrat`, `Inter`, and `Segoe UI` for a premium aesthetic feel.
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
├── core/                      # Core application code (constants, network, utils, widgets)
├── features/                  # Feature modules
│   ├── auth/                  # Authentication feature
│   ├── home/                  # Home screen feature
│   ├── intro/                 # Splash and onboarding feature
│   ├── layout/                # Main app layout and navigation
│   └── profile/               # User profile feature
└── main.dart                  # Entry point of the application
assets/
├── images/                    # Local image assets
├── svg/                       # SVG icon assets
└── fonts/                     # Custom fonts (Montserrat, Inter, Segoe-UI)
```

## Technologies Used

- [Flutter](https://flutter.dev/) - UI Toolkit
- [Dart](https://dart.dev/) - Programming Language
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - State Management
- [dio](https://pub.dev/packages/dio) - HTTP Client
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Local Storage
- [flutter_svg](https://pub.dev/packages/flutter_svg) - SVG Rendering
- [pinput](https://pub.dev/packages/pinput) - Pin code input
