import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:racha_racha/src/core/utils/custom_utils.dart';

import '../../core/widgets/custom_subtitle_text_widget.dart';

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
    await Future.delayed(const Duration(seconds: 4));
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomSubitleTextWidget(
          subtitle: "Nunca mais seja enrolado no rolê!",
        ),
      ),
    );
  }
}
