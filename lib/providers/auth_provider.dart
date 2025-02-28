import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.unauthenticated());

  Future<void> signIn(String email, String password) async {
    state = AuthState.loading();
    try {
      // Implement sign in logic here
      // For now, just simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      state = AuthState.authenticated(
        UserModel(
          id: '1',
          name: 'Test User',
          email: email,
        ),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void signOut() {
    state = AuthState.unauthenticated();
  }
}

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final UserModel? user;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.error,
    this.user,
  });

  factory AuthState.unauthenticated() {
    return AuthState(
      isAuthenticated: false,
      isLoading: false,
    );
  }

  factory AuthState.authenticated(UserModel user) {
    return AuthState(
      isAuthenticated: true,
      isLoading: false,
      user: user,
    );
  }

  factory AuthState.loading() {
    return AuthState(
      isAuthenticated: false,
      isLoading: true,
    );
  }

  factory AuthState.error(String error) {
    return AuthState(
      isAuthenticated: false,
      isLoading: false,
      error: error,
    );
  }
} 