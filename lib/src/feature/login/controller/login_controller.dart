import 'package:flutter_riverpod_base/src/feature/fireBase/auth_service.dart';
import 'package:flutter_riverpod_base/src/feature/login/view/login.dart';
import 'package:flutter_riverpod_base/src/utils/snackbar_service.dart';
import 'package:flutter_riverpod_base/src/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel();
});

class LoginViewModel extends StateNotifier<LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  LoginViewModel() : super(LoginState());

  Future<void> login(BuildContext? context, Function navigate) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final result = await auth.loginUserWithEmailAndPassword(
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
        navigate();
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid User ',
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

  void signup(BuildContext? context, Function navigate) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final result = await auth.createUserWithEmailAndPassword(
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
        navigate();
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid User ',
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

  void logout(context, Function navigate) {
    auth.signout();
    state = LoginState();

    if (context != null) {
      SnackBarService.showSnackBar(
        context: context,
        message: "Logged out successfully.",
      );
    }
    navigate();
  }
}

class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final UserAcc? user;
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
    UserAcc? user,
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
