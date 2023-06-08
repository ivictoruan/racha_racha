import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racha_racha/firebase_options.dart';
// import 'package:firebase_ui_auth/src/providers/email_auth_provider.dart'
//     as email_auth;

import 'src/core/providers/custom_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseUIAuth.configureProviders([email_auth.EmailAuthProvider()]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const CustomProvider(),
  );
}
