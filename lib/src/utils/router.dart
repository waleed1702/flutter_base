import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/feature/details/details_view.dart';
import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:flutter_riverpod_base/src/feature/login/view/login.dart';
import 'package:flutter_riverpod_base/src/feature/signup/signup_view.dart';
import 'package:flutter_riverpod_base/src/global/views/splash.dart';
import 'package:flutter_riverpod_base/src/feature/home/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: LoginView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final provider = loginViewModelProvider;

        return LoginView(provider: provider);
      },
    ),
    GoRoute(
      path: DetailsView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const DetailsView();
      },
    ),
    GoRoute(
      path: SignupView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final provider = loginViewModelProvider;

        return SignupView(provider: provider);
      },
    ),
  ],
);
