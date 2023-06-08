import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../screens/is_someone_drinking/is_someone_drinking_screen.dart';
import '../../../screens/result/result_screen.dart';
import '../../../screens/result/widgets/want_donate_widget.dart';
import '../../../screens/settings/settings_screen.dart';
import '../../../screens/starting/checking_register_page.dart';
import '../../../screens/starting/starting_screen.dart';
import '../../../screens/total_people/total_people_screen.dart';
import '../../../screens/total_value/total_value_screen.dart';
import '../custom_utils.dart';

final providers = [EmailAuthProvider()];

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path:
          '/', //FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/totalValue',
      builder: (context, state) => const CheckingRegisterPage(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => SignInScreen(
        providers: providers,
        actions: [
          AuthStateChangeAction<SignedIn>(
            (context, state) {
              final CustomUtils utils = CustomUtils();
              utils.goTo('/profile', context);
            },
          ),
        ],
        headerBuilder: (context, constraints, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                "assets/images/app/splash.png",
                width: 100,
                height: 100,
              ),
            ),
          );
        },
      ),
    ),
    GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(
              providers: providers,
              actions: [
                SignedOutAction(
                  (context) {
                    final CustomUtils utils = CustomUtils();
                    utils.goTo('/sign-in', context);
                  },
                ),
              ],
            )),

    GoRoute(
      path: '/starting',
      builder: (context, state) => const StartingScreen(),
    ),

    GoRoute(
      path: '/totalValue',
      builder: (context, state) => const TotalValueScreen(),
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
    // WantDonateWidget
  ],
);
