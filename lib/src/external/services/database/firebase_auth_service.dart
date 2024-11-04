import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../infra/services/database/auth_service.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<String> signInAnonymously() async {
    User? user = _auth.currentUser;
    if (user == null) {
      UserCredential userCredential = await _auth.signInAnonymously();

      log('1º signInAnonymously: ${userCredential.user!.uid} ');
      return userCredential.user!.uid;
    }
    log('signInAnonymously: ${user.uid} ');

    return user.uid;
  }
  // TODO: avaliar quando utilizar esta função (deve ser chamada toda vez que o app é iniciado?)
  // Future<void> refreshCurrentUser() async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     try {
  //       await user.reload();
  //       log('RefreshCurretUser: ${user.uid}');
  //     } catch (e) {
  //       log('RefreshCurretUser:  $e');
  //     }
  //   }
  // }
}
