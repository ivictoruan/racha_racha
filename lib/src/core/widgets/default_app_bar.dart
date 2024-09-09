import 'package:flutter/material.dart';

import '../utils/custom_utils.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // void checkIfUserIsLogged() async {
    //   final CustomUtils utils = CustomUtils();
    //   await Future.delayed(const Duration(seconds: 4));
    //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //     if (user == null) {
    //       // print('Usuário não está logado!');
    //       utils.goTo('/sign-in', context);
    //     } else {
    //       // print('Usuário está logado!!');
    //       utils.goTo('/profile', context);
    //     }
    //   });
    // }

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: FilledButton.tonalIcon(
        onPressed: () {
          final CustomUtils utils = CustomUtils();

          utils.goToUrl(
            "https://play.google.com/store/apps/details?id=com.matopibatech.racharacha",
          );
          // checkIfUserIsLogged();
        },
        icon: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.purple[50],
          child: const Icon(
            Icons.group,
            color: Colors.grey,
          ),
        ),
        label: const Text(
          'Racha Racha',
          style: TextStyle(
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      centerTitle: true,
    );
  }
}
