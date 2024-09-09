// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:racha_racha/src/core/wigets/custom_text_field_widget.dart';
// import 'package:racha_racha/src/screens/home/controller/check_controller.dart';

// class FormHomeWidget extends StatelessWidget {
//   const FormHomeWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return SingleChildScrollView(
//       child: Consumer<CheckController>(
//         builder: (context, controller, child) {
//           return Form(
//             key: controller.formKey,
//             child: Padding(
//               padding: EdgeInsets.all(size.height * 0.01),
//               child: Column(
//                 children: [
//                   SizedBox(height: size.height * 0.02),
//                   if (!controller.model.isSomeoneDrinking)
//                     SizedBox(height: size.height * 0.15),
//                   CustomTextField(
//                     // controller: controller.totalPriceController,
//                     hintText:
//                         controller.model.totalCheckPrice.toStringAsFixed(0),
//                     labelText: "Valor total da conta",
//                     icon: Icons.price_change_outlined,
//                     keyboardType: TextInputType.number,
//                     validator: (totalValue) {
//                       if (totalValue == null ||
//                           totalValue.isEmpty ||
//                           totalValue.contains(" ")) {
//                         return 'O valor da conta não pode ser vazio!';
//                       } else if (double.tryParse(totalValue) == null) {
//                         return 'O valor precisa ser numérico!';
//                       }
//                       return null;
//                     },
//                     onChanged: (totalCheckPrice) {
//                       try {
//                         if (totalCheckPrice != "0" &&
//                             totalCheckPrice.isNotEmpty &&
//                             !totalCheckPrice.startsWith('.')) {
//                           // var doubleTotalCheckPice =
//                           //     double.parse(totalCheckPrice);
//                           // controller.setTotalCheckPrice = doubleTotalCheckPice;
//                         }
//                       } catch (e) {
//                         // controller.state = CheckState.error;
//                         debugPrint('erro ao setar changeTotalCheckPrice ');
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   CustomTextField(
//                     // controller: controller.totalPeopleController,
//                     labelText: "Nº de pessoas na mesa",
//                     hintText: controller.model.totalPeopleNotDrinking.toStringAsFixed(0),
//                     keyboardType: TextInputType.number,
//                     icon: Icons.people_outline_sharp,
//                     validator: (totalPeople) {
//                       if (totalPeople == null ||
//                           totalPeople.isEmpty ||
//                           totalPeople.contains(' ')) {
//                         // controller.changeState(CheckState.error);
//                         return 'O número de pessoas não pode ser vazio!';
//                       } else if (int.tryParse(totalPeople) == null) {
//                         // controller.changeState(CheckState.error);
//                         return 'O número de pessoas precisa ser numérico!';
//                       } else if (int.tryParse(totalPeople)! < 1) {
//                         // controller.changeState(CheckState.error);
//                         return 'O número de pessoas precisa ser maior que 0!';
//                       }
//                       return null;
//                     },
//                     onChanged: (totalPeople) {
//                       try {
//                         // int? aux = int.tryParse(totalPeople);
//                         if (!totalPeople.contains('.') &&
//                             totalPeople != '0' &&
//                             !totalPeople.contains('-')) {
//                           // controller.setTotalPeople = int.parse(totalPeople);
//                           // controller.changeState(CheckState.completeTypingForm);
//                           debugPrint('OH SH');
//                           // controller.validateForm();
//                         }
//                       } catch (e) {
//                         // controller.validateForm();
//                         debugPrint('Impossível setar totalPeople !');
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   InkWell(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Checkbox(
//                           value: controller.model.isSomeoneDrinking,
//                           onChanged: (bool? newValue) {
//                             // controller.formKey.currentState!.save();
//                             // controller.calculateResult();
//                             // controller.switchSomeoneDrinking(newValue);
//                           },
//                           side: const BorderSide(color: Colors.black, width: 2),
//                         ),
//                         const Text(
//                           "Alguém está bebendo?",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   if (controller.model.isSomeoneDrinking)
//                     // const IsDrikingFormFieldWidget(),
//                     const SizedBox(height: 10),
//                   Text(
//                     'Gorjeta: ${controller.model.waiterPercentage.toStringAsFixed(0)} %',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Slider(
//                     value: controller.model.waiterPercentage,
//                     onChanged: (value) => {},
//                         // controller.changeWaiterPercentage(value),
//                     min: 0,
//                     max: 100,
//                     divisions: 20,
//                     label: controller.model.waiterPercentage.toStringAsFixed(0),
//                     thumbColor: Colors.redAccent,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
