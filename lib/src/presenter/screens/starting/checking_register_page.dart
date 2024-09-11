import 'package:flutter/material.dart';

import '../../shared/widgets/custom_subtitle_text_widget.dart';

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
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomSubitleTextWidget(
          subtitle: "Nunca mais seja enrolado no rolê!",
        ),
      ),
    );
  }
}
