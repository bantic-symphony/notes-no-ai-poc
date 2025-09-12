import 'package:flutter/material.dart';
import 'package:testing_riverpod/core/di/locators.dart';
import 'package:testing_riverpod/ui/nested_navigation_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
  runApp(const NestedNavigationApp());
}
