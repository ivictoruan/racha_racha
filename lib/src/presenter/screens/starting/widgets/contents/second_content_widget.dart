import 'package:flutter/material.dart';

import 'main_content_widget.dart';

class SecondContentWidget extends StatelessWidget {
  const SecondContentWidget({Key? key}) : super(key: key);

  String get titleContent => "Como funciona?";

  String get mainContent => '''
    1. 💰 O valor total da conta;

    2. 👥 A quantidade de pessoas
          no rolê;

    3. 🍻 Se houver alguém bebendo,
          o valor das bebidas;

    4. 🥂 Quantidade de pessoas bebendo.
''';

  String get welcomeContent => "É muito simples, apenas digite:";

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              titleContent,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 18,
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
