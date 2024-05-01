import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/controllers/is_someone_drinking_controller.dart';

import '../../app_widget.dart';
import '../../controllers/check_controller/check_controller.dart';
import '../../controllers/result_controller.dart';
import '../../controllers/total_people_controller.dart';
import '../../controllers/total_value_controller.dart';
import '../../models/check_model.dart';
import '../../models/user_model.dart';

class CustomProvider extends StatelessWidget {
  const CustomProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CheckModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TotalValueController(
            model: context.read<CheckModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TotalPeopleController(
            model: context.read<CheckModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => IsSomeoneDrinkingController(
            model: context.read<CheckModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ResultController(
            model: context.read<CheckModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckController(
            model: context.read<CheckModel>(),
          ),
        ),
      ],
      child: const RachaRachaApp(),
    );
  }
}
