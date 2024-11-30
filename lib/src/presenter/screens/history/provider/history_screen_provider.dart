import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/check/repositories/check_repository.dart';
import '../../../../domain/check/usecases/delete_check.dart';
import '../../../../domain/check/usecases/get_all_checks.dart';
import '../../../../domain/check/usecases/share_check.dart';
import '../controller/history_screen_controller.dart';

class HistoryScreenProvider extends StatelessWidget {
  final Widget child;

  const HistoryScreenProvider({super.key, required this.child});
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<GetAllChecks>(
            create: (context) => GetAllChecksImpl(
              repository: context.read<CheckRepository>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryScreenController(
              getAllChecks: context.read<GetAllChecks>(),
              shareCheck: context.read<ShareCheck>(),
              deleteCheck: context.read<DeleteCheck>(),
            ),
          ),
        ],
        child: child,
      );
}
