import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/check/entities/check_model.dart';
import '../../infra/check/model/check_firestore_database_adapter.dart';
import '../../infra/services/database/check_database_service.dart';

class FirebaseCheckDatabaseService extends CheckDatabaseService {
  final CollectionReference _checksCollection =
      FirebaseFirestore.instance.collection('checks');

  FirebaseCheckDatabaseService() {
    _setupDatabase();
  }

  void _setupDatabase() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  @override
  Future<void> createCheck({required CheckModel check}) async {
    try {
      await _checksCollection.add(
        CheckFirestoreDatabaseAdapter.toMap(check),
      );
      log('Check criado com sucesso!');
    } catch (e) {
      log('Erro ao criar check: $e');
    }
  }

  @override
  Future<CheckModel?> getCheckById({required String checkId}) async {
    try {
      DocumentSnapshot doc = await _checksCollection.doc(checkId).get();
      if (doc.exists) {
        CheckFirestoreDatabaseAdapter.fromMap(
          doc.data() as Map<String, dynamic>,
        );
      }
    } catch (e) {
      log('Erro ao ler check: $e');
    }
    return null;
  }

  @override
  Future<List<CheckModel>> getAllChecks() async {
    List<CheckModel> checks = [];
    try {
      QuerySnapshot snapshot = await _checksCollection
          .orderBy(
            'creationDate',
            descending: true,
          )
          .get();
      for (var doc in snapshot.docs) {
        checks.add(CheckFirestoreDatabaseAdapter.fromMap(
          doc.data() as Map<String, dynamic>,
        ));
      }
    } catch (e) {
      log('Erro ao obter todos os checks: $e');
    }
    return checks;
  }

  @override
  Future<void> updateCheck(
      {required String checkId, required CheckModel check}) async {
    try {
      await _checksCollection.doc(checkId).update(
            CheckFirestoreDatabaseAdapter.toMap(check),
          );
      log('Check atualizado com sucesso!');
    } catch (e) {
      log('Erro ao atualizar check: $e');
    }
  }

  @override
  Future<void> deleteCheck({required String checkId}) async {
    try {
      await _checksCollection.doc(checkId).delete();
      log('Check excluído com sucesso!');
    } catch (e) {
      log('Erro ao excluir check: $e');
    }
  }
}
