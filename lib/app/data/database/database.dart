import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EventDatabase {
  static final EventDatabase _instance = EventDatabase._();
  static var _database;

  EventDatabase._();

  factory EventDatabase() {
    return _instance;
  }

  static Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  static Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath, version: 2, onCreate: _onCreate);

    return database;
  }

  static void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE event(
        eventName TEXT,
        startDate INTEGER,
        endDate INTEGER,
        repeat TEXT,
        repeatValue TEXT)
    ''');
    print("database was created");
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }

  Future<void> removeAll() async {
    var client = await db;
    client.rawDelete("DELETE FROM event");
  }

  Future<void> remove(String table) async {
    var client = await db;
    client.rawDelete("DELETE FROM $table");
  }
}
