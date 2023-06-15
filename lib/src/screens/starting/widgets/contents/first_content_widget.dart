import 'package:flutter/material.dart';

import 'main_content_widget.dart';

class FirstContentWidget extends StatelessWidget {
  const FirstContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String welcomeContent = "Boas-vindas ao Racha Racha!";
    // const String receiptLottie = "assets/lottie/receipt.json";

    const String titleContent = "Rache a conta no rolê!";
    const String bodyContent = '''
    
    - Compartilhe a conta! 💸

    - Divisões Simples:
        Todos pagam exatamente o
        mesmo valor. 😄  

    - Divisões para quem está bebendo:
        Quem não bebeu paga menos! 🚱

          ''';
    return const Column(
      children: [
        // const Divider(color: Colors.deepPurple),
        Align(
          alignment: Alignment.center,
          child: Text(
            welcomeContent,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
        ),
        
        MainContentWidget(
          bodyContent: bodyContent,
          titleContent: titleContent,
        ),

        // const Divider(color: Colors.deepPurple),
      ],
    );
  }
}
