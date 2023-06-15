import 'package:flutter/material.dart';

import 'main_content_widget.dart';

class SecondContentWidget extends StatelessWidget {
  const SecondContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String titleContent = "Como funciona?";
    const String mainContent = ''' 
    1. 💰 O valor total da conta;

    2. 👥 A quantidade de pessoas 
          no rolê;

    3. 🍻 Se houver alguém bebendo, 
          o valor das bebidas;

    4. 🥂 Quantidade de pessoas bebendo.
''';

    const String welcomeContent = "É muito simples, apenas digite:";

    return const Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            titleContent,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
        ),
        MainContentWidget(
          titleContent: welcomeContent,
          bodyContent: mainContent,
        ),
      ],
    );
  }
}
