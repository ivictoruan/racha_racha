import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

import 'main_content_widget.dart';

class SecondContentWidget extends StatelessWidget {
  const SecondContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String welcomeContent = "É muito simples, apenas digite:";
    const String titleContent = "Como funciona?";
    const String mainContent = ''' 
    1. O valor total da conta;
    
    2. A quantidade de pessoas no rolê;
    
    3. Se houver alguém bebendo, 
       o valor das bebidas;
    
    4. A quantidade de pessoas bebebendo.
''';
    const String smartphoneLottie = "assets/lottie/smartphone.json";

    return Column(
      children: [
        Lottie.asset(smartphoneLottie, height: size.height * 0.35),
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
