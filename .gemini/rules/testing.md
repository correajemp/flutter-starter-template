# Testing Guidelines

## Test Placement
- Tests must be placed in the `test/` directory of the corresponding package (e.g., `packages/core/test/` for core-related tests).

## Riverpod State Testing
- To test Riverpod providers without running the Flutter widget tree, use a standalone `ProviderContainer`:
  ```dart
  final container = ProviderContainer();
  addTearDown(container.dispose);

  // Read provider state
  expect(container.read(myProvider), expectedState);
  ```
- Use `mocktail` or fakes to mock dependencies injected via providers (such as repositories or API clients) by overriding them:
  ```dart
  final container = ProviderContainer(
    overrides: [
      apiClientProvider.overrideWithValue(MockApiClient()),
    ],
  );
  ```

## Assertions
- Prefer using the modern `package:checks` library for expressive assertions over the standard `expect` matchers.
