import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/custom_utils.dart';
import '../../core/widgets/racha_main_button_widget.dart';
import 'widgets/split_history_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  List splits = [];

  startSplit() {
    log("[USUÁRIO] Iniciando nova divisão");
    CustomUtils().goTo('/totalValue', context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return loading == true
        ? const LinearProgressIndicator()
        : Scaffold(
            body: SizedBox(
              height: size.height * 0.9,
              child: splits.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset(
                            'assets/lottie/empty.json',
                            height: size.height * 0.45,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Você ainda não fez nenhuma divisão! Para começar toque no botão abaixo!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: splits.length,
                      itemBuilder: (BuildContext context, int index) {
                        var split = splits[index];
                        log('alguma coisa${split[index]}');
                        return const SplitHistoryWidget();
                      },
                    ),
            ),
            floatingActionButton: RachaMainButtonWidget(
              text: "Nova Divisão!",
              icon: Icons.add_box_outlined,
              onPressed: startSplit,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
