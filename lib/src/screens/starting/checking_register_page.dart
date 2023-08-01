import 'package:flutter/material.dart';

import '../../core/widgets/racha_main_widget.dart';

class CheckingRegisterPage extends StatefulWidget {
  const CheckingRegisterPage({super.key});

  @override
  State<CheckingRegisterPage> createState() => _CheckingRegisterPageState();
}

class _CheckingRegisterPageState extends State<CheckingRegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RachaMainWidget(
              widthPercentage: 0.4,
              heightPercentage: 0.4,
            ),
            Text(
              "Rache a conta no rolê!💸",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
