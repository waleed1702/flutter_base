import 'package:flutter_riverpod_base/src/feature/home/repo/login_repo.dart';
import 'package:flutter_riverpod_base/src/utils/snackbar_service.dart';
import 'package:flutter_riverpod_base/src/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final repo =
      ref.watch(authRepoProvider); // Replace with your AuthRepo provider
  return LoginViewModel(repo: repo);
});

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepo _repo;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginViewModel({required AuthRepo repo})
      : _repo = repo,
        super(LoginState());

  Future<void> login(BuildContext? context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final result = await _repo.login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (result != null) {
        passwordController.text = '';
        state = state.copyWith(
          isLoading: false,
          isLoggedIn: true,
          user: result,
          errorMessage: null,
        );

        if (context != null && mounted == true) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Welcome, ${result.name}!",
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid',
          isLoggedIn: false,
          user: null,
        );

        if (context != null) {
          SnackBarService.showSnackBar(context: context, message: 'Fails');
        }
      }
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: emailController.text.isEmpty == true
            ? 'Email is not valid'
            : 'Password is not valid',
        isLoggedIn: false,
        user: null,
      );
    }
  }

  void logout(BuildContext? context) {
    // Reset state
    state = LoginState(); // Reset to the initial state

    if (context != null) {
      SnackBarService.showSnackBar(
        context: context,
        message: "Logged out successfully.",
      );
    }
  }
}

class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final User? user;
  final String? errorMessage;

  LoginState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.user,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    User? user,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}
