# CLAUDE

## Project Overview
This project is a modular, multi-package Flutter application configured as a **Dart Workspace**. It is structured to ensure high maintainability, strict separation of concerns, and clean boundaries between features and core layers.

## Project Architecture
The codebase is structured under the `packages/` directory:
- **`packages/config`**: Houses application-wide configurations, localization translations (via `easy_localization`), theme data, and generated asset files (via `flutter_gen`).
- **`packages/core`**: Implements global and cross-cutting concerns, including abstract API clients, security, logging, global utility extensions, dependency injection (DI) hooks, and the main navigation setup (via `go_router`).
- **`packages/shared`**: Contains generic UI widgets, reusable layout templates, standard components, and shared model data.
- **`packages/features/`**: Individual feature modules that encapsulate complete user flows:
  - `auth`: Manages authentication flows.
  - `showcase`: Contains showcases or developer tools.
  - `splash`: Manages the application launch and initial loading sequence.

## Tech Stack & Libraries
- **Language**: Dart (SDK ^3.13.1)
- **Framework**: Flutter
- **State Management**: `flutter_riverpod` (Riverpod) for predictable reactive state management.
- **Routing**: `go_router` for declarative, deep-linkable routing.
- **Networking**: `dio` for powerful HTTP networking with interceptor support.
- **Localization**: `easy_localization` for translation keys.
- **Storage**: `shared_preferences` and `flutter_secure_storage` for local cache and secure tokens.
- **Asset Generation**: `flutter_gen` for type-safe assets.

## Architectural Conventions
- **Feature Encapsulation**: Feature packages must remain independent. They should not directly import other feature packages. Share logic via `core` or `shared` where necessary.
- **MVVM Pattern**: Structure presentation layers with Views (Widgets) and ViewModels/State Notifiers (Riverpod providers).
- **Dependency Injection**: Utilize Riverpod providers as the main DI container. Do not manually pass deep dependencies down the widget tree.
