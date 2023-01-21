import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

class SecondContentWidget extends StatelessWidget {
  const SecondContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            "É muito simples, apenas digite:",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.purple,
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.9,
              child: Expanded(
                child: Markdown(
                  data: mainContent,
                  // shrinkWrap: true,
                  onTapText: () {},
                  controller: ScrollController(),
                  softLineBreak: true,
                  selectable: true,
                ),
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.purple,
        ),
      ],
    );
  }
}
