import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:flutter_riverpod_base/src/feature/home/view/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class LoginView extends ConsumerWidget {
  final StateNotifierProvider provider;

  static const routePath = "/login";

  const LoginView({required this.provider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(provider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: loginViewModel.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: !(loginState.isLoading),
            ),
            TextField(
              controller: loginViewModel.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              enabled: !(loginState.isLoading),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (loginState.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (loginState.isLoggedIn)
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome, ${loginState.user!.name}!',
                      style: const TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => loginViewModel.logout(context),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              )
            else ...[
              ElevatedButton(
                onPressed: () {
                  loginViewModel.login(
                    context,
                    () => context.go(HomeView.routePath),
                  );
                },
                child: const Text('Login'),
              ),
              if (loginState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    loginState.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
