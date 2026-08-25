import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/check/usecases/create_check.dart';
import '../../shared/controllers/split_screen_controller.dart';

class SplitScreenProvider extends StatelessWidget {
  final Widget child;

  const SplitScreenProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('[SplitScreenProvider] Arguments recebidos: ${ModalRoute.of(context)?.  settings.name}');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplitScreenController(
            createCheck: context.read<CreateCheck>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
