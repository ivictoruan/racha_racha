import 'package:flutter/material.dart';

import 'presenter/shared/ui/theme_config.dart';
import 'presenter/shared/utils/routes/routes.dart';

class RachaRachaApp extends StatelessWidget {
  const RachaRachaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        title: "Racha Racha",
        theme: ThemeConfig.theme,
      );
}
