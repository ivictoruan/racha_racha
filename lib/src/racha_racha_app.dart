import 'package:flutter/material.dart';

import 'presenter/shared/ui/theme/theme_config.dart';
import 'presenter/shared/routes/app_route_manager.dart';

class RachaRachaApp extends StatelessWidget {
  const RachaRachaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateRoute: AppRouteManager.onGenerateRoute,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        title: "Racha Racha",
        theme: ThemeConfig.theme,
      );
}
