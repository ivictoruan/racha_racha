import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'main_content_widget.dart';

class FirstContentWidget extends StatelessWidget {
  const FirstContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String welcomeContent = "Boas-vindas ao Racha Racha!";
    const String receiptLottie = "assets/lottie/receipt.json";
    const String titleContent = "Rache a conta no rolê!";
    const String mainContent = '''
    - Divisões Simples:
        Todos exatamente pagam o
        mesmo valor.  
          
    - Divisões para quem está bebendo:
        Quem não bebeu paga menos! 
          ''';
    return Column(
      children: [
        Lottie.asset(receiptLottie, height: size.height * 0.35),
        const Text(
          titleContent,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Colors.purple,
          ),
        ),
        const Divider(
          color: Colors.purple,
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            welcomeContent,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.purple,
            ),
          ),
        ),
        const MainContentWidget(mainContent: mainContent),
        const Divider(
          color: Colors.purple,
        ),
      ],
    );
  }
}
