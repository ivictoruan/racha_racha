import 'package:flutter/material.dart';

import 'src/app_starter.dart';
import 'src/racha_racha_app.dart';
import 'src/presenter/shared/providers/general_widget_provider.dart';

Future<void> 
main() async {
  await AppStarter.initApp();
  runApp(
    const GeneralWidgetProvider(
      child: RachaRachaApp(),
    ),
  );
}
