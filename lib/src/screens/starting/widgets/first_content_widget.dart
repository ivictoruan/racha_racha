import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

class FirstContentWidget extends StatelessWidget {
  const FirstContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    Size size = MediaQuery.of(context).size;
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
        SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.9,
              child: Markdown(
                data: mainContent,
                // shrinkWrap: true,
                controller: ScrollController(),
                selectable: true,
                softLineBreak: true,
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
