import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/core/providers/custom_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.purple[100],
    ),
  );

  runApp(
    const CustomProvider(),
  );
}
