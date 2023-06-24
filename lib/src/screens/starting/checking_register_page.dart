import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:racha_racha/src/core/utils/custom_utils.dart';

import '../../core/widgets/racha_main_widget.dart';

class CheckingRegisterPage extends StatefulWidget {
  const CheckingRegisterPage({super.key});

  @override
  State<CheckingRegisterPage> createState() => _CheckingRegisterPageState();
}

class _CheckingRegisterPageState extends State<CheckingRegisterPage> {
  @override
  void initState() {
    super.initState();
    checkIfUserIsLogged();
  }

  void checkIfUserIsLogged() async {
    final CustomUtils utils = CustomUtils();
    await Future.delayed(const Duration(milliseconds: 2000));
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // print('Usuário não está logado!');
        utils.goTo('/starting', context);
      } else {
        // print('Usuário está logado!!');
        utils.goTo('/totalValue', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
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
