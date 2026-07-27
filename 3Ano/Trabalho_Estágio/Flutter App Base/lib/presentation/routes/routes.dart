import 'package:exercicio_um/presentation/ui/settings/page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/my_home/page/my_home_page.dart';

sealed class Routes {
  static const initial = homePage;
  static const homePage = 'MyHomePage';
  static const settingsPage = 'SettingsPage';

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return Scaffold(backgroundColor: Colors.red, body: Container());
    },
    initialLocation: '/$initial',
    routes: routes,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: homePage,
      path: '/$homePage',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: MyHomePage()),
      routes: [
        GoRoute(
          name: settingsPage,
          path: settingsPage,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SettingsPage()),
        ),
      ],
    ),
  ];
}
