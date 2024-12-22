import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/feature/home%20copy/view/home.dart';
import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:go_router/go_router.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  static const routePath = "/Details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final loginViewModel = ref.read(loginViewModelProvider);

                  return Column(
                    children: [
                      detais('Email', loginViewModel.user!.email),
                      SizedBox(height: 10),
                      detais('Name', loginViewModel.user!.name),
                      SizedBox(height: 10),
                      detais('ID', loginViewModel.user!.id),
                      SizedBox(height: 10)
                    ],
                  );
                },
                child: const Text('data')),
            ElevatedButton(
              onPressed: () => context.go(HomeView.routePath),
              child: const Text('Back'),
            ),
          ],
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
