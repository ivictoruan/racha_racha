import 'package:go_router/go_router.dart';

import '../../screens/history/history_screen.dart';
import '../../screens/is_someone_drinking/is_someone_drinking_screen.dart';
import '../../screens/result/provider/check_result_screen_provider.dart';
import '../../screens/result/check_result_screen.dart';
import '../../screens/result/widgets/want_donate_widget.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/starting/starting_screen.dart';
import '../../screens/total_people/total_people_screen.dart';
import '../../screens/total_value/total_value_screen.dart';

class AppRouteManager {
  static final GoRouter routes = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, __) => const StartingScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (_, __) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/totalValue',
        builder: (_, __) => const TotalValueScreen(),
      ),
      GoRoute(
        path: '/totalPeople',
        builder: (_, __) => const TotalPeopleScreen(),
      ),
      GoRoute(
        path: '/isSomeoneDrinking',
        builder: (_, __) => const IsSomeoneDrinkingScreen(),
      ),
      GoRoute(
        path: '/result',
        builder: (_, __) => const CheckResultScreenProvider(
          child: CheckResultScreen(),
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),
      // TODO: verificar se esta rota é necessaria
      GoRoute(
        path: '/wantDonate',
        builder: (_, __) => const WantDonateWidget(),
      ),
    ],
  );
}
