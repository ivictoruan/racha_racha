import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../controllers/total_value_controller.dart';
import '../../../screens/is_someone_drinking/is_someone_drinking_screen.dart';
import '../../../screens/result/result_screen.dart';
import '../../../screens/result/widgets/want_donate_widget.dart';
import '../../../screens/settings/settings_screen.dart';
import '../../../screens/starting/starting_screen.dart';
import '../../../screens/total_people/total_people_screen.dart';
import '../../../screens/total_value/total_value_screen.dart';
import '../../models/check_model.dart';

final GoRouter routes = GoRouter(
  routes: [
    // TODO: criar rota de checagem
    // GoRoute(
    //   path:
    //       '/', //FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/totalValue',
    //   builder: (context, state) => const CheckingRegisterPage(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => const StartingScreen(),
    ),
    GoRoute(
      path: '/totalValue',
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
      builder: (context, state) => const ResultScreen(),
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
