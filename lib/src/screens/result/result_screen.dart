import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/custom_utils.dart';
import '../../core/wigets/custom_will_pop_scope_widget.dart';
import '../../core/wigets/wrong_total_check_value_widget.dart';
import '../home/controller/check_controller.dart';
import 'widgets/result_body_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  CustomUtils customUtils = CustomUtils();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomWillPopWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.restart_alt_rounded),
            onPressed: () => customUtils.goTo("/totalValue", context),
          ),
          centerTitle: true,
          shadowColor: Colors.purpleAccent,
          elevation: 1,
          title: const Text('Resultado da Conta'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => customUtils.goTo("/settings", context),
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ],
          toolbarHeight: size.height * 0.06,
        ),
        body: Padding(
          padding: EdgeInsets.all(0.03125 * size.height),
          child: const ResultBodyWidget(),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(0.0125 * size.height),
          child: Consumer<CheckController>(
            builder: (context, controller, child) {
              return const WrongTotalCheckValueWidget(
                text: "Fazer outra rachada!",
              );
            },
          ),
        ),
      ),
    );
  }
}
