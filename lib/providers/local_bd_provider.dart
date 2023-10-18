import 'package:great_places/utils/db_adapter.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class LocalDbProvider implements DbAdapter<Database> {
  @override
  Future<Database> openDb() async {
    final String dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  Database? _db;

  @override
  Future<Database> getInstance() async {
    _db ??= await openDb();
    return _db as Database;
  }

  @override
  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await getInstance();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, Object?>>> query(String table) async {
    final db = await getInstance();
    return db.query(table);
  }
}
