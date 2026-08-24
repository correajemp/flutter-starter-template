# Code Style & Structural Guidelines

## Multi-Package Structure Rules
- **Encapsulation**: Features must not import other features.
- **Shared vs Feature**: UI elements that are reused across distinct features must go into `packages/shared`. Features should only contain highly specific UI.
- **Dependency Direction**:
  - `features/*` -> imports `core`, `config`, `shared`.
  - `shared` -> imports `config`.
  - `core` -> imports `config`, `shared` (generic UI/models), and specific features only when organizing global router paths.
  - `config` -> standalone configuration.

## Coding Style
- Follow [Effective Dart](https://dart.dev/effective-dart) formatting and design guidelines.
- Prefer explicit types over `var` where type clarity enhances readability, especially on public APIs.
- Use `const` constructors on widgets and in `build()` methods to optimize rebuilds.
- Always use trailing commas for multi-line parameter lists or collections.

## Riverpod Conventions
- Use auto-disposable providers (`FutureProvider.autoDispose`, `NotifierProvider.autoDispose`) by default to prevent memory leaks when screens are popped.
- Name providers explicitly, matching their notifier: e.g., `authNotifierProvider` for an `AuthNotifier`.
