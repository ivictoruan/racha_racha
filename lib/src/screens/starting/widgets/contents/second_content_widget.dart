import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'main_content_widget.dart';

class SecondContentWidget extends StatelessWidget {
  const SecondContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    const String welcomeContent = "É muito simples, apenas digite:";
    const String titleContent = "Como funciona?";
    const String mainContent = ''' 
    1. 💰 O valor total da conta;

    2. 👥 A quantidade de pessoas 
          no rolê;

    3. 🍻 Se houver alguém bebendo, 
          o valor das bebidas;

    4. 🥂 Quantidade de pessoas bebendo.
''';
    // const String smartphoneLottie = "assets/lottie/smartphone.json";
    const String receiptLottie = "assets/lottie/receipt.json";

    return Column(
      children: [
        Lottie.asset(receiptLottie, height: size.height * 0.25),
        const Text(
          titleContent,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Colors.deepPurple,
          ),
        ),
        // const Divider(color: Colors.deepPurple),
        const Align(
          alignment: Alignment.center,
          child: Text(
            welcomeContent,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
        ),
        const MainContentWidget(mainContent: mainContent),
        // const Divider(color: Colors.deepPurple),
      ],
    );
  }
}
