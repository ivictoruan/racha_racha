import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/utils/custom_utils.dart';
import '../../core/widgets/racha_main_widget.dart';

class CheckingRegisterPage extends StatefulWidget {
  const CheckingRegisterPage({super.key});

  @override
  State<CheckingRegisterPage> createState() => _CheckingRegisterPageState();
}

class _CheckingRegisterPageState extends State<CheckingRegisterPage> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    signInUserAnonymously(context);
  }

  signInUserAnonymously(BuildContext context) async {
    CustomUtils utils = CustomUtils();
    setState(() => loading = true);
    try {
      final user = FirebaseAuth.instance;
      final goToHome = utils.goTo('/home', context);
      if (user.currentUser?.uid == null) {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();
        log(" ID: ${userCredential.user?.uid ?? "ID indisponível!"} - Signed in with temporary account. ");
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => const StartingScreen()),
        //     (route) => false);
        // TODO: verificar se está funcionando
        goToHome;
      } else {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => const StartingScreen()),
        //     (route) => false);
        // navigateTo(const StartingScreen());
        utils.goTo('/starting', context);
      }
      setState(() => loading = false);
    } on FirebaseAuthException catch (e) {
      log("Erro Firebase: ${e.code}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RachaMainWidget(
              widthPercentage: 0.4,
              heightPercentage: 0.4,
            ),
            Text(
              "Rache a conta no rolê!💸",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
