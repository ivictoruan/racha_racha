import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../infra/check/adapters/sqflite_check_adapter.dart';
import '../../../infra/check/datasourcers/local_check_datasource.dart';
import '../../../domain/check/entities/check.dart';

class SqfliteCheckDatasource implements LocalCheckDatasource {
  static const String _tableName = 'checks';
  static const String _databaseName = 'checks_database.db';
  static const int _databaseVersion = 1;

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
            individualPrice REAL,
            waiterPercentage REAL,
            totalWaiterValue REAL,
            isSomeoneDrinking INTEGER,
            totalDrinkPrice REAL,
            totalPeopleDrinking INTEGER,
            individualPriceWhoIsDrinking REAL,
            totalPeople INTEGER
          )
        ''');
      },
    );
  }

  @override
  Future<void> createCheck({required Check check}) async {
    try {
      final db = await _db;
      final id = const Uuid().v4();
      final updatedCheck = check.copyWith(id: id);

      final checkMap = SqfliteCheckAdapter.toMap(updatedCheck);
      await db.insert(
        _tableName,
        checkMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
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
  Future<void> deleteCheck({required String checkId}) async {
    try {
      final db = await _db;
      await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [checkId],
      );
    } catch (e) {
      throw Exception('Erro ao deletar o check com ID $checkId: $e');
    }
  }
}
