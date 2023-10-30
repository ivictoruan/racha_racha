import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:racha_racha/src/core/widgets/custom_will_pop_scope_widget.dart';

import '../../core/widgets/racha_main_widget.dart';
import 'widgets/bottom_rachar_widget.dart';
import 'widgets/introduction_widget.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  // late final User user;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  // startApp() {
  //   try {
      
  //   user = FirebaseAuth.instance.currentUser!;
  //   } on FirebaseAuthException catch (e) {
  //     log("Erro Firebase: ${e.code}");
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return CustomWillPopWidget(
      isExitedPaged: true,
      appBar: AppBar(
        title: const RachaMainWidget(
          widthPercentage: 0.3,
          heightPercentage: 0.15,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const IntroductionWidget(),
      isBodyScrollable: false,
      floatingActionButton: const BottomRacharWidget(),
    );
  }
}
