import 'package:flutter/material.dart';

import 'core/app/my_app.dart';
import 'core/di/app_di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInjector();
  runApp(const MyApp());
}
