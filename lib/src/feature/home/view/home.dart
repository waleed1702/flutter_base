import 'package:flutter_riverpod_base/src/feature/details/details_view.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routePath = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(AppStrings.appName),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.go(DetailsView.routePath);
              },
              child: const Text(AppStrings.profile),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [Text('Welcome')],
        ),
      ),
    );
  }
}
