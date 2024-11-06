import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../external/services/cache/shared_preferences_cache_service.dart';
import '../../../external/services/database/firebase_auth_service.dart';
import '../../../external/services/database/firestore_check_database_service.dart';
import '../../../infra/services/cache/cache_service.dart';
import '../../../infra/services/database/auth_service.dart';
import '../../../infra/services/database/check_database_service.dart';
import '../controllers/check_controller.dart';
import '../controllers/user_controller.dart';

class GeneralWidgetProvider extends StatelessWidget {
  final Widget child;
  const GeneralWidgetProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<CacheService>(
            create: (_) => SharedPreferencesCacheService(),
          ),
          Provider<FirebaseAuth>(
            create: (_) => FirebaseAuth.instance,
          ),
          Provider<AuthService>(
            create: (context) => FirebaseAuthService(
              auth: context.read<FirebaseAuth>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => UserController(),
          ),
          Provider<FirebaseFirestore>(
            create: (_) => FirebaseFirestore.instance,
          ),
          Provider<CheckDatabaseService>(
            create: (context) => FirestoreCheckDatabaseService(
              user: context.read<UserController>(),
              firestore: context.read<FirebaseFirestore>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => CheckController(
              dbService: context.read<CheckDatabaseService>(),
            ),
          ),
        ],
        child: child,
      );
}
