# Cosmetics App

A beautiful Flutter application for cosmetic products, featuring a modern onboarding experience, elegant UI design, and robust architecture.

## Features

- **Custom Splash Screen**: Engaging entry point for the application.
- **Onboarding Flow**: A multi-step introductory guide to welcome users and explain the app's features.
- **Authentication**: Secure login, registration, and forgot password flows.
- **Product Categories & Cart**: Browse cosmetics by categories and manage a shopping cart.
- **State Management & Networking**: Uses `flutter_bloc` for scalable state management and `dio` for efficient API requests.
- **Local Storage**: Uses `shared_preferences` and `flutter_secure_storage` for managing local user data and sessions securely.
- **Custom Typography**: Integrates elegant fonts like `Montserrat`, `Inter`, and `Segoe UI` (as well as `google_fonts`) for a premium aesthetic feel.
- **Material Design**: Uses Flutter's Material components.

## Architecture & Implementation Details

- **Singleton Dio Setup**: Implemented the Singleton design pattern with Dio to initialize the baseURL connection only once, allowing the rest of the application to reuse the same instance instead of creating a connection for each Cubit.
- **Centralized API Error Handler**: Implemented a centralized API error handler to ensure consistent and robust error management.
- **Shared AppImage Widget**: Created a shared `AppImage` widget for reliable and unified image rendering across the UI.
- **Storage Strategy**:
  - Uses `SharedPreferences` for settings and simple preferences.
  - Uses `FlutterSecureStorage` to store tokens, which utilizes AES-256-GCM encryption.
- **Optimized Asynchronous Operations**: Uses `Future.wait` to run multiple asynchronous tasks in parallel, improving performance.

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
│   ├── cart/                  # Shopping cart feature
│   ├── categories/            # Product categories feature
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
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - Secure Storage
- [flutter_svg](https://pub.dev/packages/flutter_svg) - SVG Rendering
- [pinput](https://pub.dev/packages/pinput) - Pin code input
- [google_fonts](https://pub.dev/packages/google_fonts) - Google Fonts
