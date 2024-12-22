import 'package:flutter_riverpod_base/src/feature/home/home.dart';
import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/feature/login/view/login.dart';
import 'package:flutter_riverpod_base/src/widgets/button.dart';
import 'package:flutter_riverpod_base/src/widgets/textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SignupView extends ConsumerWidget {
  final StateNotifierProvider provider;

  static const routePath = "/signup";

  const SignupView({required this.provider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(provider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            const Text("Signup",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: loginViewModel.emailController,
              isEnable: !(loginState.isLoading),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              isPassword: true,
              controller: loginViewModel.passwordController,
              isEnable: !(loginState.isLoading),
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Signup",
              onPressed: () => loginViewModel.signup(
                  context, () => context.go(HomeView.routePath)),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => context.go(LoginView.routePath),
                child: const Text("Login", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
