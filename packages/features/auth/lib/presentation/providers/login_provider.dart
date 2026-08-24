import 'package:auth/data/auth_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final bool success;

  const LoginState({this.isLoading = false, this.error, this.success = false});

  const LoginState.initial() : isLoading = false, error = null, success = false;

  LoginState copyWith({bool? isLoading, String? Function()? error, bool? success}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      success: success ?? this.success,
    );
  }
}

class LoginNotifier extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState.initial();
  }

  void signInWithFacebook() async {
    state = state.copyWith(isLoading: true, error: () => null, success: false);
    final result = await ref.read(authApiProvider).signInWithFacebook();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: () => failure.message);
      },
      (_) {
        state = state.copyWith(isLoading: false, success: true);
      },
    );
  }

  void signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: () => null, success: false);
    final result = await ref.read(authApiProvider).signInWithGoogle();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: () => failure.message);
      },
      (_) {
        state = state.copyWith(isLoading: false, success: true);
      },
    );
  }

  void signInWithApple() async {
    state = state.copyWith(isLoading: true, error: () => null, success: false);
    final result = await ref.read(authApiProvider).signInWithApple();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: () => failure.message);
      },
      (_) {
        state = state.copyWith(isLoading: false, success: true);
      },
    );
  }

  void signInWithEmail({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: () => null, success: false);
    final result = await ref
        .read(authApiProvider)
        .signInWithEmail(email: email.trim(), password: password);
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

final loginProvider = AutoDisposeNotifierProvider<LoginNotifier, LoginState>(LoginNotifier.new);
