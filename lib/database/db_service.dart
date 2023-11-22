import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDB(String dbName) async {
  String dbpath = join(await getDatabasesPath(), dbName);
  if (await databaseExists(dbpath)) {}
  final db = await openDatabase(
    dbpath,
    version: 1,
  );

  return db;
}

// code to check table exist in db

Future<bool> doesTableExists(Database db, String tableName) async {
  List<Map<String, dynamic>> tables = await db.rawQuery(
      'SELECT * FROM sqlite_master WHERE type="table" AND name=?', [tableName]);
  return tables.isNotEmpty;
}

//create table
Future<void> createTable(Database db, String tableName) async {
  if (!await doesTableExists(db, 'expense')) {
    await db.execute('''
      CREATE TABLE expense (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL
      );
    ''');
  }
}

Future<void> insertData(
    Database db, String table, Map<String, dynamic> data) async {
  await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.ignore);
}

Future<List<Map<String, dynamic>>> getData(Database db, String table) async {
  List<Map<String, dynamic>> data = await db.query(
    table,
  );
  return data;
}

Future<void> deleteData(Database db, String table, key) async {
  await db.delete(
    table,
    where: 'id=?',
    whereArgs: [key],
  );
}
