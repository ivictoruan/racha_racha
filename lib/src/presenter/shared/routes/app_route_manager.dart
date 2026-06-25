import 'package:flutter/material.dart';
import 'package:racha_racha/src/homepage.dart';

import '../../../domain/check/entities/check.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/history/provider/history_screen_provider.dart';
import '../../screens/is_someone_drinking/is_someone_drinking_screen.dart';
import '../../screens/result/provider/check_details_screen_provider.dart';
import '../../screens/result/check_details_screen.dart';
import '../../screens/result/widgets/want_donate_widget.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/starting/starting_screen.dart';
import '../../screens/total_people/total_people_screen.dart';
import '../../screens/total_value/total_value_screen.dart';

class AppRouteManager {
  static const String starting = '/starting';
  static const String history = '/history';
  static const String totalValue = '/totalValue';
  static const String totalPeople = '/totalPeople';
  static const String isSomeoneDrinking = '/isSomeoneDrinking';
  static const String checkDetails = '/checkDetails';
  static const String settings = '/settings';
  static const String wantDonate = '/wantDonate';
  static const String homePage = '/homepage';

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case starting:
        return MaterialPageRoute(builder: (_) => const StartingScreen());
      case history:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreenProvider(
            child: HistoryScreenWrapper(),
          ),
        );
      case totalValue:
        return MaterialPageRoute(
          builder: (_) => const TotalValueScreen(),
        );
      case totalPeople:
        return MaterialPageRoute(
          builder: (_) => const TotalPeopleScreen(),
        );
      case isSomeoneDrinking:
        return MaterialPageRoute(
          builder: (_) => const IsSomeoneDrinkingScreen(),
        );
      case checkDetails:
        return MaterialPageRoute(
          builder: (_) {
            final arguments = routeSettings.arguments as Map<String, Object>;

            final isFinishingCheck = arguments['isFinishing'] as bool;

            final check = arguments['check'] as Check;

            return CheckDetailsScreenProvider(
              child: CheckDetailsScreen(
                isFinishingCheck: isFinishingCheck,
                check: check,
              ),
            );
          },
        );
      case settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case wantDonate:
        return MaterialPageRoute(
          builder: (_) => const WantDonateWidget(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
    }
  }
}
