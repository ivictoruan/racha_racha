import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/check/entities/check_model.dart';
import '../../../infra/check/model/check_firestore_database_adapter.dart';
import '../../../infra/services/database/check_database_service.dart';
import '../../../presenter/shared/controllers/user_controller.dart';

// TODO: alterar para repository
class FirestoreCheckDatabaseService implements CheckDatabaseService {
  late final FirebaseFirestore _firestore;
  late final UserController _user;

  FirestoreCheckDatabaseService({
    required UserController user,
    required FirebaseFirestore firestore,
  }) {
    _user = user;
    _firestore = firestore;
    _setupDatabase();
  }
  void _setupDatabase() {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  CollectionReference get _userChecksCollection =>
      _firestore.collection('users').doc(_user.id).collection('checks');

  @override
  Future<void> createCheck({required CheckModel check}) async {
    try {
      await _userChecksCollection.add(
        CheckFirestoreDatabaseAdapter.toMap(check),
      );
      log('Check criado com sucesso para o usuário ${_user.id}!');
    } catch (e) {
      log('Erro ao criar check para o usuário ${_user.id}: $e');
    }
  }

  @override
  Future<List<CheckModel>> getAllChecks() async {
    List<CheckModel> checks = [];
    try {
      QuerySnapshot snapshot = await _userChecksCollection
          .orderBy('creationDate', descending: true)
          .get();
      for (var doc in snapshot.docs) {
        checks.add(CheckFirestoreDatabaseAdapter.fromMap(
          doc.data() as Map<String, dynamic>,
        ));
      }
    } catch (e) {
      log('Erro ao obter todos os checks do usuário ${_user.id}: $e');
    }
    return checks;
  }

//  @override
//   Future<CheckModel?> getCheckById({required String checkId}) async {
//     try {
//       DocumentSnapshot doc = await _userChecksCollection.doc(checkId).get();
//       if (doc.exists) {
//         return CheckFirestoreDatabaseAdapter.fromMap(
//           doc.data() as Map<String, dynamic>,
//         );
//       }
//     } catch (e) {
//       log('Erro ao ler check do usuário $_userId: $e');
//     }
//     return null;
//   }

  // @override
  // Future<void> updateCheck(
  //     {required String checkId, required CheckModel check}) async {
  //   try {
  //     await _userChecksCollection.doc(checkId).update(
  //           CheckFirestoreDatabaseAdapter.toMap(check),
  //         );
  //     log('Check atualizado com sucesso para o usuário $_userId!');
  //   } catch (e) {
  //     log('Erro ao atualizar check do usuário $_userId: $e');
  //   }
  // }

  // @override
  // Future<void> deleteCheck({required String checkId}) async {
  //   try {
  //     await _userChecksCollection.doc(checkId).delete();
  //     log('Check excluído com sucesso para o usuário $_userId!');
  //   } catch (e) {
  //     log('Erro ao excluir check do usuário $_userId: $e');
  //   }
  // }
}
