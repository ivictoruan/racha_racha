
// import 'package:firebase_auth/firebase_auth.dart';

// import '../utils/custom_utils.dart';

// class FirebaseService {
//   void checkIfUserIsLogged() async {
//     final CustomUtils utils = CustomUtils();
//     await Future.delayed(const Duration(seconds: 4));
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         // print('Usuário não está logado!');
//         // utils.goTo('/starting', context);
//       } else {
//         // print('Usuário está logado!!');
//         // utils.goTo('/totalValue', context);
//       }
//     });
//   }
// }