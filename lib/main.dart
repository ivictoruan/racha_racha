import 'package:flutter/material.dart';

import 'src/app_starter.dart';
import 'src/app_widget.dart';
import 'src/presenter/shared/providers/custom_provider.dart';

void main() async {
  await AppStarter.initApp();

  runApp(
    const CustomProvider(
      child: RachaRachaApp(),
    ),
  );
}
