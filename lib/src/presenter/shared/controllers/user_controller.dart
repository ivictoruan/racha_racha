import 'package:flutter/material.dart';

import '../../../domain/user/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel _user;

  UserController({String? id}) : _user = UserModel(id: id ?? '');

  String get id => _user.id;

  set id(String value) {
    if (_user.id != value) {
      _user = _user.copyWith(id: value);
      notifyListeners();
    }
  }
}
