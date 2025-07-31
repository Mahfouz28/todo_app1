# Onboarding App

A beautiful and responsive Flutter onboarding application with 3 screens, built using BLoC state management and screen_util for responsive design.

## Features

- **3 Onboarding Screens**: Beautiful illustrations and content for note-taking app introduction
- **Responsive Design**: Uses flutter_screenutil for consistent UI across different screen sizes
- **State Management**: BLoC pattern for clean and maintainable code
- **Smooth Navigation**: PageView with smooth transitions between screens
- **Custom Illustrations**: Built-in Flutter widgets for illustrations (no external images required)
- **Modern UI**: Clean, minimalist design with Material Design 3

## Screens

1. **Screen 1**: "Manage your notes easily" - Person at desk with notes and mirror
2. **Screen 2**: "Organize your thoughts" - Person walking with smartphone and thought bubble
3. **Screen 3**: "Create cards and easy styling" - Two people with laptop and digital card

## Project Structure

```
lib/
├── bloc/
│   └── onboarding_bloc.dart          # BLoC for state management
├── data/
│   └── onboarding_data.dart          # Onboarding content data
├── models/
│   └── onboarding_page.dart          # Onboarding page model
├── screens/
│   └── onboarding_screen.dart        # Main onboarding screen
├── widgets/
│   ├── onboarding_page_widget.dart   # Individual page widget
│   └── onboarding_illustrations.dart # Custom illustrations
└── main.dart                         # App entry point
```

## Dependencies

- `flutter_bloc`: State management
- `flutter_screenutil`: Responsive design
- `equatable`: Value equality for BLoC

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## Design Specifications

- **Design Size**: 390 × 844 (iPhone 14 Pro)
- **Primary Color**: #2196F3 (Blue)
- **Background**: White
- **Typography**: SF Pro Display (system font)

## Navigation

- **Next Button**: Navigate to next screen or complete onboarding
- **Back Button**: Navigate to previous screen (available from screen 2)
- **Skip Button**: Skip to end (available on screens 1 and 2)

## State Management

The app uses BLoC pattern with the following events and states:

**Events:**
- `NextPageEvent`: Navigate to next page
- `PreviousPageEvent`: Navigate to previous page
- `SkipOnboardingEvent`: Skip to end

**States:**
- `OnboardingInitial`: Current page state
- `OnboardingCompleted`: Onboarding finished

## Customization

To add your own images, replace the custom illustrations in `onboarding_illustrations.dart` with actual image assets and update the `imagePath` in `onboarding_data.dart`.
