import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../external/services/generate_check_service_impl.dart';
import '../../../../external/services/share_plus_service_impl.dart';
import '../../../../infra/services/generate_check_service.dart';
import '../../../../infra/services/share_service.dart';

class CheckDetailsScreenProvider extends StatelessWidget {
  final Widget child;
  const CheckDetailsScreenProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<GenerateCheckService>(
            create: (_) => GenerateCheckServiceImpl(),
          ),
          Provider<ShareService>(
            create: (_) => SharePlusCheckServiceImpl(),
          ),
        ],
        child: child,
      );
}
