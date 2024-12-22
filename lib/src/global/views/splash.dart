import 'package:flutter_riverpod_base/src/global/controller/init_controller.dart';
import 'package:flutter_riverpod_base/src/global/providers/common_providers.dart';
import 'package:flutter_riverpod_base/src/feature/login/view/login.dart';
import 'package:flutter_riverpod_base/src/feature/home/view/home.dart';
import 'package:flutter_riverpod_base/src/utils/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    if (AppConfig.devMode) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        context.go(LoginView.routePath);
      });
    } else {
      ref.read(initControllerProvider).initUserAndToken().then((value) {
        final user = ref.read(currentUserProvider);
        final token = ref.read(authTokenProvider);

        if (user == null || token == null) {
          context.go(HomeView.routePath);
        } else {
          context.go(LoginView.routePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 165, 174),
      body: Center(
        child: Text(
          "Splash",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
