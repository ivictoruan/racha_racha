import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/custom_utils.dart';

class WantDonateWidget extends StatelessWidget {
  const WantDonateWidget({Key? key}) : super(key: key);

  String get appPix => "04165030392";

  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => customUtils.goToBack(context),
          icon: const Icon(
            Icons.close,
            color: Colors.deepPurple,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Apoie nosso trabalho",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Se você gosta do nosso aplicativo, considere fazer uma doação via PIX!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: appPix)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "Chave PIX copiada com sucesso!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.deepPurple,
                    ),
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 150,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Clique para copiar a chave PIX",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pix, color: Colors.deepPurple, size: 40),
                        SizedBox(width: 10),
                        Icon(Icons.copy, color: Colors.deepPurple, size: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            FilledButton.tonal(
              onPressed: () => customUtils.goToUrl(
                "https://play.google.com/store/apps/details?id=com.matopibatech.racharacha",
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Obrigado por utilizar o Racha Racha! \nGostaria de nos avaliar?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.deepPurple[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
