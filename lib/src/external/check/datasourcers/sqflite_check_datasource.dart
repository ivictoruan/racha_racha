import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../infra/check/adapters/sqflite_check_adapter.dart';
import '../../../infra/check/datasourcers/local_check_datasource.dart';
import '../../../domain/check/entities/check.dart';

class SqfliteCheckDatasource implements LocalCheckDatasource {
  static const String _tableName = 'checks';
  static const String _databaseName = 'checks_database.db';
  static const int _databaseVersion = 2;

  Database? _database;

  Future<Database> get _db async {
    if (_database == null) {
      await _initializeDatabase();
    }
    return _database!;
  }

  Future<void> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            creationDate TEXT,
            totalValue REAL,
            participants TEXT,
            items TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE $_tableName ADD COLUMN participants TEXT',
          );
          await db.execute(
            'ALTER TABLE $_tableName ADD COLUMN items TEXT',
          );
        }
      },
    );
  }

  @override
  Future<String> createCheck({required Check check}) async {
    try {
      final db = await _db;
      final id = check.id ?? const Uuid().v4();
      final creationDate = check.creationDate ?? DateTime.now();
      final updatedCheck = check.copyWith(
        id: id,
        creationDate: creationDate,
      );

      final checkMap = SqfliteCheckAdapter.toMap(updatedCheck);
      await db.insert(
        _tableName,
        checkMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e, stackTrace) {
      log('[SqfliteCheckDatasource] Erro ao criar/salvar check: $e', stackTrace: stackTrace);
      throw Exception('Erro ao criar o check: $e');
    }
  }

  @override
  Future<List<Check>> getAllChecks() async {
    try {
      final db = await _db;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        orderBy: 'creationDate DESC',
      );

      final checks = maps.map(SqfliteCheckAdapter.fromMap).toList();

      return checks;
    } catch (e) {
      throw Exception('Erro ao buscar todos os checks: $e');
    }
  }

  @override
  Future<void> deleteCheck({required Check check}) async {
    try {
      final db = await _db;
      await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [check.id],
      );
    } catch (e) {
      throw Exception('Erro ao deletar o check com ID $check.id: $e');
    }
  }
}
