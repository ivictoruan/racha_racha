import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_widget.dart';
import '../controller/check_controller.dart';
import '../models/check_model.dart';

class CustomProvider extends StatelessWidget {
  const CustomProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CheckModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckController(model: CheckModel()),
        ),
      ],
      child: const RachaRachaApp(),
    );
  }
}
