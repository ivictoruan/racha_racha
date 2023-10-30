import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthService {
  Future<void> signInUserAnonymously();
  signInUserWithEmail();
}


class AuthService implements AbstractAuthService{

  @override
   Future<void> signInUserAnonymously() async {
     try {
      final user = FirebaseAuth.instance;
      
      if (user.currentUser?.uid == null) {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();
        log(" ID: ${userCredential.user?.uid ?? "ID indisponível!"} - Signed in with temporary account. ");
      }
    } on FirebaseAuthException catch (e) {
      log("Erro Firebase: ${e.code}");
    }
  }

  @override
  signInUserWithEmail() {
    throw UnimplementedError();
  }
  
  

}