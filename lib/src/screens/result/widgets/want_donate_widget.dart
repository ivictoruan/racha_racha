import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/custom_utils.dart';

class WantDonateWidget extends StatelessWidget {
  const WantDonateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    CustomUtils customUtils = CustomUtils();
    String myPix = "04165030392";
    // String qrCode =
    // "00020126770014BR.GOV.BCB.PIX01362eac25c1-8b35-4649-80a9-681bbeca2cb10215Muito obrigado!5204000053039865802BR5925Victor Ruan Diniz Pereira6009SAO PAULO61080540900062070503***63044082";
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.02 * size.width),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: myPix)).then(
                      (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(bottom: 575.0),
                            content: Text(
                              "Pix Copiado com sucesso!!!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                        );
                      },
                    );
                  }, // copiar o qr
                  child: SizedBox(
                    height: size.height * 0.2,
                    width: size.width * 0.8,
                    child: Material(
                      color: Colors.white,
                      elevation: 2,
                      shadowColor: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Toque para pegar minha chave pix",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                                SizedBox(width: size.width * 0.02),
                                const Icon(
                                  Icons.pix,
                                  color: Colors.deepPurple,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            const Icon(Icons.copy),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                const Divider(),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(
                //     "Ou aponte para o QR Code, no seu app de pagamentos.",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold, color: Colors.deepPurple),
                //   ),
                // ),
                // const Divider(),
                SizedBox(height: size.height * 0.01),
                // SizedBox(
                //   height: size.height * 0.35,
                //   width: size.width * 0.65,
                //   child: Material(
                //     borderOnForeground: true,
                //     color: Colors.white,
                //     elevation: 2,
                //     shadowColor: Colors.deepPurple,
                //     borderRadius: BorderRadius.circular(20),
                //     child: Center(
                //       child: QrImage(
                //         data: qrCode,
                //         version: QrVersions.auto,
                //         size: 200.0,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: size.height * 0.05),
                // const Divider(),
                FilledButton.tonal(
                  onPressed: () => customUtils.goToUrl(
                    "https://play.google.com/store/apps/details?id=com.matopibatech.racharacha",
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Obrigado por utilizar o Racha Racha! Gostaria de nos avaliar?",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
