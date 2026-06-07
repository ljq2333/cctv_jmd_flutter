---
name: flutter-dev
description: Flutter development assistance. Use when working with Flutter widgets, Dart code, state management, or Flutter project structure.
---

# Flutter Development Skill

This skill provides assistance with Flutter development tasks.

## When to Use

Use this skill when:
- Creating or modifying Flutter widgets
- Working with Dart code
- Implementing state management solutions
- Structuring Flutter projects
- Debugging Flutter applications
- Running Flutter commands

## Flutter Best Practices

### Widget Structure
- Keep widgets small and focused
- Use const constructors when possible
- Prefer composition over inheritance
- Extract reusable widgets into separate files

### State Management
- Choose appropriate state management solution (Provider, Riverpod, Bloc, etc.)
- Keep state as local as possible
- Avoid deeply nested state dependencies

### Performance
- Use const widgets to reduce rebuilds
- Implement proper list view optimizations
- Avoid expensive operations in build methods

### Testing
- Write unit tests for business logic
- Write widget tests for UI components
- Use integration tests for user flows

## Common Flutter Commands

```bash
# Run the app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Build for different platforms
flutter build apk
flutter build ios
flutter build web

# Clean project
flutter clean

# Get dependencies
flutter pub get
```

## Project Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── routes.dart
├── features/
│   ├── feature1/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── feature2/
├── shared/
│   ├── widgets/
│   ├── utils/
│   └── constants/
└── core/
    ├── services/
    └── theme/
```