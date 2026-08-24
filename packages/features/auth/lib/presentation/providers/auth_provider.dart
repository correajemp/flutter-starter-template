import 'dart:async';

import 'package:auth/data/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final User? user;
  final bool isLoggedIn;

  const AuthState({this.user, this.isLoggedIn = false});

  const AuthState.initial() : user = null, isLoggedIn = false;

  AuthState copyWith({User? Function()? user, bool? isLoggedIn}) {
    return AuthState(
      user: user != null ? user() : this.user,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  String get providerName {
    final providerId = user?.providerData.firstOrNull?.providerId;
    final isGoogle = providerId == 'google.com' || (providerId == null);
    final isFacebook = providerId == 'facebook.com';

    return isGoogle
        ? 'Google'
        : isFacebook
        ? 'Facebook'
        : 'Apple';
  }
}

class AuthNotifier extends Notifier<AuthState> {
  StreamSubscription<User?>? _sub;

  @override
  AuthState build() {
    final auth = FirebaseAuth.instance;
    final current = auth.currentUser;

    _sub?.cancel();
    _sub = auth.authStateChanges().listen((user) {
      if (user != null) {
        state = state.copyWith(user: () => user, isLoggedIn: true);
      } else {
        state = const AuthState();
      }
    });

    ref.onDispose(() {
      _sub?.cancel();
    });

    if (current != null) {
      return AuthState(user: current, isLoggedIn: true);
    }
    return const AuthState.initial();
  }

  void signOut() async {
    await ref.read(authApiProvider).signOut();
    state = const AuthState.initial();
  }

  void deleteUser() async {
    await ref.read(authApiProvider).delete();
    state = const AuthState.initial();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
