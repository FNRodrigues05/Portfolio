import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poke_api/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../presentation/routes/routes.dart';
import '../l10n/generated/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Poke Api',
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: Routes.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt'), Locale('es'), Locale('en')],
    );
  }
}
