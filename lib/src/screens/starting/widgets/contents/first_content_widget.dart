import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'main_content_widget.dart';

class FirstContentWidget extends StatelessWidget {
  const FirstContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    const String welcomeContent = "Boas-vindas ao Racha Racha!";
    // const String receiptLottie = "assets/lottie/receipt.json";
    const String smartphoneLottie = "assets/lottie/smartphone.json";

    const String titleContent = "Rache a conta no rolê!";
    const String mainContent = '''
    
    - Compartilhe a conta! 💸

    - Divisões Simples:
        Todos pagam exatamente o
        mesmo valor. 😄  

    - Divisões para quem está bebendo:
        Quem não bebeu paga menos! 🚱

          ''';
    return Column(
      children: [
        Lottie.asset(smartphoneLottie, height: size.height * 0.25),
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
            textAlign: TextAlign.justify,
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
