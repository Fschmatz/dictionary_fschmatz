import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class HistoryDao {

  static final _databaseName = 'Dictionary.db';
  static final _databaseVersion = 1;

  static final table = 'wordHistory';
  static final columnId = 'id';
  static final columnWord = 'word';
  static final columnLanguage = 'language';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  HistoryDao._privateConstructor();
  static final HistoryDao instance = HistoryDao._privateConstructor();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL create DB
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
           $columnId INTEGER PRIMARY KEY,            
           $columnWord TEXT NOT NULL,
           $columnLanguage TEXT NOT NULL
          )
          ''');

    //max item size = 10
    Batch batch = db.batch();
    for(int i = 1; i <= 10 ; i++) {
      batch.insert('wordHistory', {'id': i, 'word': ' ','language':' '});
    }
    await batch.commit(noResult: true);

    await db.execute('''
          CREATE TRIGGER deleteOnAdd
          AFTER INSERT ON $table           
          BEGIN
            DELETE FROM $table WHERE $columnId IN (SELECT $columnId FROM $table LIMIT 1);
          END;
          
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id DESC');
  }

}