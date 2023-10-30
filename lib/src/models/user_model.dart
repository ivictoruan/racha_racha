import 'package:flutter/material.dart';

import 'check_model.dart';

class UserModel extends ChangeNotifier {
  String id;
  List<CheckModel> splits = [];
  UserModel({
    this.id = '',
  });
}
