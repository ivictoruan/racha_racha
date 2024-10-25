import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'external/services/firebase_check_database_service.dart';

class AppStarter {
  static Future initFirebase() async {
    await Firebase.initializeApp();

    final db =
        FirebaseCheckDatabaseService(firestore: FirebaseFirestore.instance);
    log('Iniciando DB databaseId: ${db.firestore.databaseId}');

    _initCrashlytics();
  }

  static Future<void> initApp() async {
    log("[Usuário] iniciou app");

    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    await initFirebase();
  }

  static void _initCrashlytics() {
    FlutterError.onError =
        (errorDetails) => FirebaseCrashlytics.instance.recordFlutterFatalError(
              errorDetails,
            );

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };
  }
}

class FirebaseFirestoreDatabaseService {
  void _setupDatabase() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, // Habilita persistência offline (padrão)
      cacheSizeBytes:
          Settings.CACHE_SIZE_UNLIMITED, // Tamanho do cache opcional
    );
  }

  FirebaseFirestoreDatabaseService() {
    _setupDatabase();
  }
}
