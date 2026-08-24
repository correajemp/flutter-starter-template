import 'package:auth/data/auth_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final bool isLoading;
  final String? error;
  final bool success;

  const RegisterState({this.isLoading = false, this.error, this.success = false});

  const RegisterState.initial() : isLoading = false, error = null, success = false;

  RegisterState copyWith({bool? isLoading, String? Function()? error, bool? success}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      success: success ?? this.success,
    );
  }
}

class RegisterNotifier extends AutoDisposeNotifier<RegisterState> {
  @override
  RegisterState build() {
    return const RegisterState.initial();
  }

  void signupUser({required String name, required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: () => null, success: false);
    final result = await ref
        .read(authApiProvider)
        .signUpWithEmail(name: name.trim(), email: email.trim(), password: password);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: () => failure.message);
      },
      (_) {
        state = state.copyWith(isLoading: false, success: true);
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: () => null);
  }
}

final registerProvider = AutoDisposeNotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);
