import 'package:flutter/material.dart';
import 'package:racha_racha/src/core/ui/theme_config.dart';

import 'core/utils/routes/routes.dart';


class RachaRachaApp extends StatelessWidget {
  const RachaRachaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return MaterialApp.router(
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: "Racha Racha",
      theme: ThemeConfig.theme,
    );
  }
}
