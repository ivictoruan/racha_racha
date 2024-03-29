import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:racha_racha/src/core/ui/theme_config.dart';

import 'core/utils/routes/routes.dart';

import 'screens/authentication/label_overrides.dart';

class RachaRachaApp extends StatelessWidget {
  const RachaRachaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locales = [
      const Locale('pt', 'BR'), // Português (Brasil)
      // const Locale('en', 'US'), // Inglês (Estados Unidos), caso necessário
    ];
    return MaterialApp.router(
      localizationsDelegates: [
        // Creates an instance of FirebaseUILocalizationDelegate with overridden labels
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),

        // Delegates below take care of built-in flutter widgets
        GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,

        // This delegate is required to provide the labels that are not overridden by LabelOverrides
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: locales,
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: "Racha Racha",
      theme: ThemeConfig.theme,
    );
  }
}
