import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:flutter_riverpod_base/src/feature/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/feature/login/view/login.dart';
import 'package:flutter_riverpod_base/src/widgets/button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  static const routePath = "/Details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final loginViewModel = ref.read(loginViewModelProvider);

                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      detais('Email', loginViewModel.user!.email),
                      const SizedBox(height: 10),
                      detais('Name', loginViewModel.user!.name),
                      const SizedBox(height: 10),
                      detais('ID', loginViewModel.user!.id),
                      const SizedBox(height: 10),
                      CustomButton(
                        label: 'Sign Out',
                        onPressed: () {
                          ref.read(loginViewModelProvider.notifier).logout(
                                context,
                                () => context.go(LoginView.routePath),
                              );
                        },
                      ),
                    ],
                  );
                },
                child: const Text('data'),
              ),
              const Spacer(),
              CustomButton(
                label: 'back',
                onPressed: () => context.go(HomeView.routePath),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detais(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue, // Outline color
          width: 2.0,
          // Outline thickness
        ),
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0), // Spacing between label and value
          Text(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
