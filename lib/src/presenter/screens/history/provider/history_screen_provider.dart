import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../external/services/generate_check_service_impl.dart';
import '../../../../external/services/share_plus_service_impl.dart';
import '../../../../infra/services/database/check_database_service.dart';
import '../../../../infra/services/generate_check_service.dart';
import '../../../../infra/services/share_check_service.dart';
import '../controller/history_screen_controller.dart';

class HistoryScreenProvider extends StatelessWidget {
  final Widget child;

  const HistoryScreenProvider({super.key, required this.child});
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<GenerateCheckService>(
            create: (_) => GenerateCheckServiceImpl(),
          ),
          Provider<ShareCheckService>(
            create: (_) => SharePlusCheckServiceImpl(),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryScreenController(
              checkService: context.read<CheckDatabaseService>(),
            ),
          ),
        ],
        child: child,
      );
}
