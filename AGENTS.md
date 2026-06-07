# AGENTS.md

This file contains instructions for AI agents working on this Flutter project.

## Project Overview

This is a Flutter project called `cctv_jmd_flutter`. It appears to be a CCTV (Closed Circuit Television) related application.

## Development Guidelines

### Flutter/Dart Specific
- Follow the official Flutter style guide
- Use `flutter analyze` to check for linting issues
- Run `flutter test` before committing changes
- Use meaningful variable and function names
- Add comments for complex logic

### Code Structure
- Keep widgets small and focused
- Use proper state management (Provider, Riverpod, Bloc, etc.)
- Follow the single responsibility principle
- Separate business logic from UI code

### Testing
- Write unit tests for business logic
- Write widget tests for UI components
- Aim for good test coverage

### Git Workflow
- Use conventional commit messages
- Create feature branches for new work
- Test thoroughly before merging

## Common Commands

```bash
# Run the app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Build for release
flutter build apk  # Android
flutter build ios  # iOS
flutter build web  # Web
```

## Notes

- This project uses Dart SDK ^3.11.1
- The project is configured for multiple platforms (Android, iOS, Web, Windows)