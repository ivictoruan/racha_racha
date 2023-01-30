import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_widget.dart';
import 'package:racha_racha/src/core/controller/check_controller.dart';
import '../models/check_model.dart';

class CustomProvider extends StatelessWidget {
  const CustomProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => CheckModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckController(model: CheckModel()),
        ),
      ],
      child: const RachaRachaApp(),
    );
  }
}
