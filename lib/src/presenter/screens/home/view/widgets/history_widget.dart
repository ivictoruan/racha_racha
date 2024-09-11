import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40,
         title: const Text(
          "Histórico",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        
        // automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Está é a página de histórico!")],
        ),
      ),
    );
  }
}
