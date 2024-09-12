import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presenter/shared/ui/theme/theme_config.dart';
import 'presenter/shared/ui/routes/app_route_manager.dart';

class RachaRachaApp extends StatelessWidget {
  const RachaRachaApp({Key? key}) : super(key: key);

  GoRouter get routes => AppRouteManageranager.routes;

  String get title => "Racha Racha";

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeConfig.theme,
      );
}
