import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../external/services/firebase_check_database_service.dart';
import '../../../../infra/services/database/check_database_service.dart';
import '../controller/history_screen_controller.dart';

class HistoryScreenProvider extends StatelessWidget {
  final Widget child;

  const HistoryScreenProvider({super.key, required this.child});
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<CheckDatabaseService>(
            create: (context) => FirebaseCheckDatabaseService(),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryController(
              checkService: context.read<CheckDatabaseService>(),
            ),
          ),
        ],
        child: child,
      );
}
