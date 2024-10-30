import 'package:flutter/material.dart';

import '../../screens/history/history_screen.dart';
import '../../screens/history/provider/history_screen_provider.dart';
import '../../screens/is_someone_drinking/is_someone_drinking_screen.dart';
import '../../screens/result/provider/check_result_screen_provider.dart';
import '../../screens/result/check_result_screen.dart';
import '../../screens/result/widgets/want_donate_widget.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/starting/starting_screen.dart';
import '../../screens/total_people/total_people_screen.dart';
import '../../screens/total_value/total_value_screen.dart';

class AppRouteManager {
  static const String starting = '/';
  static const String history = '/history';
  static const String totalValue = '/totalValue';
  static const String totalPeople = '/totalPeople';
  static const String isSomeoneDrinking = '/isSomeoneDrinking';
  static const String result = '/result';
  static const String settings = '/settings';
  static const String wantDonate = '/wantDonate';

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case starting:
        return MaterialPageRoute(builder: (_) => const StartingScreen());
      case history:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreenProvider(
            child: HistoryScreen(),
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
      case result:
        return MaterialPageRoute(
          builder: (_) => const CheckResultScreenProvider(
            child: CheckResultScreen(),
          ),
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
          builder: (_) => const StartingScreen(),
        );
    }
  }
}
