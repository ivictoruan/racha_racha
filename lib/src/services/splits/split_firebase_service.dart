import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:racha_racha/src/models/check_model.dart';

/// Abstract class for [Split/Check] services
/// that will be used to interact with Firebase
abstract class AbstractSplitService {
  // CREATE
  bool createSplit(CheckModel model);
  // READ
  Future<List<CheckModel>> getAllSplits();
  // getSplitById() {}
  // UPDATE
  updateSplit(CheckModel model);
  // DELETE
  deleteSplitById();
}

class SplitFirebaseService implements AbstractSplitService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  bool createSplit(CheckModel model) {
    try {
      final splitsRef = _database.ref('users/${user?.uid}/splits');
      splitsRef.get().then((value) {
        log(value.children.length.toString());
        _database
            .ref('users/${user?.uid}/splits/${value.children.length - 10}')
            .set(model.copyWith(uid: UniqueKey().toString()).toMap());
      });
      return true;
    } catch (error) {
      log("Não foi possível criar uma nova divisão${error.toString()}");
      return false;
    }
  }

  @override
  deleteSplitById() {
    throw UnimplementedError();
  }

  @override
  Future<List<CheckModel>> getAllSplits() {
    // final splits = _database.ref('users/${user?.uid}/splits');
    return Future.value(<CheckModel>[]);
  }

  @override
  updateSplit(CheckModel model) {
    var splitRef = _database.ref('users/${user?.uid}/splits/${model.uid}');
    splitRef.update(
      model.toMap(),
    );
  }
}
