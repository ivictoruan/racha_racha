import 'package:flutter/material.dart';

import 'main_content_widget.dart';

class FirstContentWidget extends StatelessWidget {
  const FirstContentWidget({Key? key}) : super(key: key);

  String get welcomeContent => "Boas-vindas ao Racha Racha!";

  String get titleContent => "Rache a conta no rolê!";

  String get bodyContent => '''
    - Compartilhe a conta! 💸

    - Divisões Simples:
        Todos pagam exatamente o
        mesmo valor. 😄

    - Divisões para quem está bebendo:
        Quem não bebeu paga menos! 🚱

          ''';

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              welcomeContent,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.deepPurple,
              ),
            ),
          ),
          MainContentWidget(
            bodyContent: bodyContent,
            titleContent: titleContent,
          ),
        ],
      );
}
