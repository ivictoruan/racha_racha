import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/custom_utils.dart';

class ThirdContentWidget extends StatelessWidget {
  const ThirdContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    const String registerLottie = "assets/lottie/register.json";

    const String titleContent = "Faça seu cadastro!";

    return Column(
      children: [
        Lottie.asset(registerLottie, height: size.height * 0.35),
        // SizedBox(height: size.height * 0.35),
        const Text(
          titleContent,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.deepPurple,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Cadastre-se para ter acesso ao seu histórico",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.deepPurple,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "- Com ele é possível que você possa compartilhar as dividas do rolê no outro dia ou semana (quem sabe um ano? 🤔)",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.deepPurple,
              fontSize: 14,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
          child: Text(
            "- Ter acesso ao histórico em outros dispotivos",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.deepPurple,
              fontSize: 14,
            ),
          ),
        ),
        FilledButton.tonal(
          onPressed: () {
            CustomUtils utils = CustomUtils();
            utils.goTo('/sign-in', context);
          },
          child: const Text(
            "Cadastre-se",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
        )
      ],
    );
  }
}
