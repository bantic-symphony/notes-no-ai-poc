import 'package:flutter/material.dart';

import 'package:testing_riverpod/app_router.dart';

class NestedNavigationApp extends StatelessWidget {
  const NestedNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'No AI App',
      routerConfig: router,
    );
  }
}