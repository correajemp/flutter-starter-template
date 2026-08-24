# API & Data Conventions

## Network Client
- Use **Dio** as the sole HTTP client for external service integration.
- Ensure all Dio clients are accessed through Riverpod providers (e.g., `dioProvider`).

## Error Handling & Responses
- API client methods must handle `DioException` gracefully. Do not bubble raw `DioException`s directly to the UI.
- Catch errors at the repository layer and map them into domain-specific exceptions or return them as a `Result` type (or fold pattern).
- Models must utilize `json_serializable` and `json_annotation` for parsing JSON.
- Match external snake_case JSON keys to camelCase Dart fields using `fieldRename: FieldRename.snake` in class annotations:
  ```dart
  @JsonSerializable(fieldRename: FieldRename.snake)
  ```
