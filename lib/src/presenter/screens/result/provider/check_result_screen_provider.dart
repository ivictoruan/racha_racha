import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../external/services/generate_check_service_impl.dart';
import '../../../../external/services/share_plus_service_impl.dart';
import '../../../../infra/services/generate_check_service.dart';
import '../../../../infra/services/share_check_service.dart';

class CheckResultScreenProvider extends StatelessWidget {
  final Widget child;
  const CheckResultScreenProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<GenerateCheckService>(
            create: (_) => GenerateCheckServiceImpl(),
          ),
          Provider<ShareCheckService>(
            create: (_) => SharePlusCheckServiceImpl(),
          ),
        ],
        child: child,
      );
}
