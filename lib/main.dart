import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/core/providers/custom_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
  );
  runApp(
    const CustomProvider(),
  );
}
