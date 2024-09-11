import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../screens/total_value/controller/total_value_controller.dart';
import '../../../../domain/check/entities/check_model.dart';
import '../../../screens/is_someone_drinking/is_someone_drinking_screen.dart';
import '../../../screens/result/provider/result_screen_provider.dart';
import '../../../screens/result/result_screen.dart';
import '../../../screens/result/widgets/want_donate_widget.dart';
import '../../../screens/settings/settings_screen.dart';
import '../../../screens/starting/starting_screen.dart';
import '../../../screens/total_people/total_people_screen.dart';
import '../../../screens/total_value/total_value_screen.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StartingScreen(),
    ),
    GoRoute(
      path: '/totalValue',
      // TODO: criar uma classe para comportar este MultiProvider
      builder: (context, state) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => TotalValueController(
              // TODO: remover modelo do controller.
              model: CheckModel(),
            ),
          ),
        ],
        child: const TotalValueScreen(),
      ),
    ),
    GoRoute(
      path: '/totalPeople',
      builder: (context, state) => const TotalPeopleScreen(),
    ),
    GoRoute(
      path: '/isSomeoneDrinking',
      builder: (context, state) => const IsSomeoneDrinkingScreen(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) => const ResultScreenProvider(
        child: ResultScreen(),
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/wantDonate',
      builder: (context, state) => const WantDonateWidget(),
    ),
  ],
);
