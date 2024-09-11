// import 'package:flutter/material.dart';
// import 'package:racha_racha/src/core/wigets/action_button.dart';
// import 'package:racha_racha/src/core/wigets/custom_text_widget.dart';
// import 'package:racha_racha/src/screens/home/controller/home_controller.dart';

// class CheckWidget extends StatefulWidget {
//   const CheckWidget({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _CheckWidgetState createState() => _CheckWidgetState();
// }

// class _CheckWidgetState extends State<CheckWidget> {
//   // HomeController controller = HomeController();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Form(
//       // key: controller.formKey,
//       child: Padding(
//         padding: EdgeInsets.all(size.height * 0.02),
//         child: Column(
//           children: [
//             SizedBox(height: size.height * 0.03),
//             const CustomTextField(
//               // initialValue: _totalPrice.toStringAsFixed(2),
//               // labelText: "R\$ ${_totalPrice.toStringAsPrecision(3)} Total",
//               labelText: "Valor total da conta",
//               icon: Icons.price_change_outlined,
//               keyboardType: TextInputType.number,
//               // validator: (totalValue) =>
//               //     controller.validateTotalValue(totalValue),
//               // onSaved: (totalValue) =>
//               //     controller.totalPrice = double.parse(totalValue!),
//             ),
//             SizedBox(
//               height: size.height * 0.01,
//             ),
//             CustomTextField(
//               // initialValue: _numPeople.toString(),
//               labelText: "Nº de pessoas na mesa",
//               hintText: "1",
//               keyboardType: TextInputType.number,
//               icon: Icons.people_outline_sharp,
//               // validator: (totalPeople) =>
//                   // controller.validateTotalPeople(totalPeople),
//               onChanged: (totalPeople) {
//                 // var aux = int.tryParse(value);
//                 if (totalPeople is int) {
//                   log(totalPeople);
//                   setState(() {
//                     // controller.numPeople = int.parse(totalPeople);
//                   });
//                 }
//               },
//             ),
//             SizedBox(
//               height: size.height * 0.03,
//             ),
//             InkWell(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Checkbox(
//                     value: controller.isDriking,
//                     value: controller.isDriking,
//                     onChanged: (bool? newValue) {
//                       setState(() {
//                         controller.isDriking = newValue!;
//                       });
//                     },
//                   ),
//                   const Text(
//                     "Alguém está bebendo?",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   const Icon(
//                     Icons.local_drink_sharp,
//                     color: Colors.red,
//                     size: 19,
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.01,
//             ),
//             if (controller.isDriking) ...isDrikingTextFormField(),
//             Text(
//               'Gorjeta: ${controller.waiterPercentage.toStringAsFixed(0)} %',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Slider(
//               value: controller.waiterPercentage.toDouble(),
//               onChanged: (value) {
//                 setState(() {
//                   controller.waiterPercentage = value.toDouble();
//                 });
//               },
//               min: 0,
//               max: 100,
//               divisions: 20,
//               // label: controller.waiterPercentage.toStringAsFixed(0),
//             ),
//             ActionButton(
//               "Rachar",
//               onPressed: () => controller.doCheck(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> isDrikingTextFormField() {
//     return [
//       CustomTextField(
//         labelText: 'Nº de pessoas bebendo',
//         enabled: controller.isDriking,
//         keyboardType: TextInputType.number,
//         onSaved: (value) {
//           controller.numDrinkers = int.parse(value!);
//         },
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'O número de pessoas não pode ser vazio!';
//           } else if (int.tryParse(value) == null) {
//             return 'O valor precisa ser numérico!';
//           } else if (int.tryParse(value)! < 1) {
//             return 'Nº de pessoas precisa ser maior que 0!';
//           } else if (int.tryParse(value)! > controller.numPeople) {
//             return 'Nº de pessoas bebendo maior do que o total de pessoas!';
//           }
//           return null;
//         },
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       CustomTextField(
//         labelText: 'Valor total das bebidas R\$',
//         enabled: controller.isDriking,
//         keyboardType: TextInputType.number,
//         onSaved: (value) {
//           controller.drinkPrice = double.parse(value!);
//         },
//         validator: (validateTotalDrinks) =>
//             controller.validadeTotalDrinks(validateTotalDrinks),
//       )
//     ];
//   }
// }
