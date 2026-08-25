import 'package:flutter/material.dart';

import '../../../domain/check/entities/check.dart';
import '../../screens/check_split/split_screen.dart';
import '../../screens/check_split/check_split_screen_provider.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/first/first_screen.dart';
import '../../screens/history/provider/history_screen_provider.dart';
import '../../screens/result/widgets/want_donate_widget.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/starting/starting_screen.dart';

class AppRouteManager {
  static const String firstScreen = '/';
  static const String starting = '/starting';
  static const String history = '/history';
  static const String splitScreen = '/splitScreen';
  // TODO: alterar nome da rota para menu/drawer
  static const String settings = '/settings';
  static const String wantDonate = '/wantDonate';

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case firstScreen:
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case starting:
        return MaterialPageRoute(builder: (_) => const StartingScreen());
      case history:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreenProvider(
            child: HistoryScreenWrapper(),
          ),
        );
      case splitScreen:
        return MaterialPageRoute(
          builder: (context) {
            final check = routeSettings.arguments is Check
                ? routeSettings.arguments as Check
                : null;
            return SplitScreenProvider(
              child: SplitScreen(check: check),
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
          builder: (_) => const StartingScreen(),
        );
    }
  }
}
