import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/check_controller.dart';

class CustomProvider extends StatelessWidget {
  final Widget child;
  const CustomProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CheckController(),
          ),
        ],
        child: child,
      );
}
