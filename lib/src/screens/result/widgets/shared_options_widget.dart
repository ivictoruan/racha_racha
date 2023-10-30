import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

import '../../../controllers/check_controller/check_controller.dart';
import '../../../core/widgets/racha_main_button_widget.dart';

class SharedOptionsWidget extends StatelessWidget {
  const SharedOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);

    return Consumer<CheckController>(
      builder: (context, controller, child) {
        return RachaMainButtonWidget(
          text: "Compartilhar",
          icon: Icons.share,
          // TODO: criar função que consome dados do usuário sem precisar passar cada parâmetro
          onPressed: () => shareWithWhatsApp(
            controller.isSomeoneDrinking,
            controller.totalWaiterValue,
            controller.totalCheckPrice,
            (controller.totalCheckPrice -
                controller.totalWaiterValue), // sem gorjeta
            controller.individualPrice,
            controller.individualPriceWhoIsDrinking,
          ),
          // child: FloatingActionButton.extended(
          //   focusColor: const Color.fromARGB(255, 247, 243, 247),
          //   backgroundColor: Colors.white,
          //   onPressed: () => shareWithWhatsApp(
          //     controller.isSomeoneDrinking,
          //     controller.totalWaiterValue,
          //     controller.totalCheckPrice,
          //     (controller.totalCheckPrice -
          //         controller.totalWaiterValue), // sem gorjeta
          //     controller.individualPrice,
          //     controller.individualPriceWhoIsDrinking,
          //   ),
          //   icon: const Icon(Icons.share, color: Colors.deepPurple),
          //   label: Text(
          //     // "Compartilhe a Divisão",
          //     "Compartilhar",
          //     textAlign: TextAlign.center,
          //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //           color: Colors.deepPurple,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //         ),
          //   ),
          // ),
        );
      },
    );
  }

  void shareWithWhatsApp(
    isDrinking,
    totalWaiterValue,
    totalValue,
    totalValueWithoutWaiterValue,
    individualValue,
    individualPriceWhoIsDrinking,
  ) {
    SocialShare.shareWhatsapp(
      isDrinking
          ? '''
---------------------------------------------
| *A conta deu: R\$* ${totalValue.toStringAsFixed(2)}
| *Total sem Gorjeta:* R\$ ${totalValueWithoutWaiterValue.toStringAsFixed(2)}
------------------------------------------------------------
| *Para quem não bebeu:* R\$ ${individualValue.toStringAsFixed(2)}
------------------------------------------------------------
| *Para quem bebeu:* R\$ ${individualPriceWhoIsDrinking.toStringAsFixed(2)}
------------------------------------------------------------
| *Garçom/Gorjeta:*  R\$ ${totalWaiterValue.toStringAsFixed(2)}
------------------------------------------------------------

*Faça o download do Racha Racha: https://play.google.com/store/apps/details?id=com.matopibatech.racharacha*
    '''
          : '''
------------------------------------------------------------
| *A conta deu:* R\$ ${totalValue.toStringAsFixed(2)}
| *Total sem Gorjeta:* R\$ ${totalValueWithoutWaiterValue.toStringAsFixed(2)}
------------------------------------------------------------
| *Valor Individual:* R\$ ${individualValue.toStringAsFixed(2)}
------------------------------------------------------------
| *Garçom/Gorjeta:*  R\$ ${totalWaiterValue.toStringAsFixed(2)}
------------------------------------------------------------

Faça o download do Racha Racha: https://play.google.com/store/apps/details?id=com.matopibatech.racharacha

    ''',
    );
  }

//   void shareWithGeneral(
//     isDrinking,
//     totalWaiterValue,
//     totalValue,
//     individualValue,
//     individualPriceWhoIsDrinking,
//   ) {
//     SocialShare.shareOptions(
//       isDrinking
//           ? '''
// ------------------------------------------------------------
// | A conta deu: R\$ ${totalValue.toStringAsFixed(2)}
// ------------------------------------------------------------
// | Para quem não bebeu: R\$ ${individualValue.toStringAsFixed(2)}
// ------------------------------------------------------------
// | Para quem bebeu: R\$ ${individualPriceWhoIsDrinking.toStringAsFixed(2)}
// ------------------------------------------------------------
// | Garçom/Gorjeta:  R\$ ${totalWaiterValue.toStringAsFixed(2)}
// ------------------------------------------------------------

// Faça o download do Racha Racha: https://play.google.com/store/apps/details?id=com.nu.production&hl=pt_BR&gl=US
//     '''
//           : '''
// ------------------------------------------------------------
// | Valor Total: R\$ ${totalValue.toStringAsFixed(2)}
// ------------------------------------------------------------
// | Valor individual: R\$ ${individualValue.toStringAsFixed(2)}
// ------------------------------------------------------------
// | Garçom/Gorjeta:  R\$ ${totalWaiterValue.toStringAsFixed(2)}
// ------------------------------------------------------------

// Faça o download do Racha Racha: https://play.google.com/store/apps/details?id=com.nu.production&hl=pt_BR&gl=US

//     ''',
//     );
//   }
}

