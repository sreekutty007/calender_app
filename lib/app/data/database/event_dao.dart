import 'package:calender_app/app/data/database/database.dart';
import 'package:calender_app/app/data/database/event_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class EventDAO {
  static final db = EventDatabase();

  static Future<int> addDb(EventDBModel itemDBModel) async {
    var client = await EventDatabase.db;
    return client.insert('event', itemDBModel.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<EventDBModel>> fetchAll() async {
    var client = await EventDatabase.db;
    var res = await client.query('event');

    if (res.isNotEmpty) {
      var item = res.map((value) => EventDBModel.fromDb(value)).toList();
      return item;
    }
    return [];
  }

  static Future<List<EventDBModel>> fetchEvent(DateTime date, String yearly,
      String monthly, String weekly, String daily) async {
    int d = DateFormat("yyyy-MM-dd")
        .parse(DateFormat("yyyy-MM-dd").format(date))
        .millisecondsSinceEpoch;

    var client = await EventDatabase.db;
    var res = await client.query('event',
        where:
            ' startDate<=? AND endDate>=? OR repeatValue = ? OR repeatValue = ? OR repeatValue = ? OR repeatValue = ?',
        whereArgs: [d, d, yearly, monthly, weekly, daily]);

    if (res.isNotEmpty) {
      var item = res.map((value) => EventDBModel.fromDb(value)).toList();
      return item;
    }
    return [];
  }

  // static Future<List<EventDBModel>> fetchEvent(DateTime date) async {
  //   var client = await EventDatabase.db;
  //   var res = await client.query('event',where: 'startDate = ?', whereArgs: [date]);

  //   if (res.isNotEmpty) {
  //     var item = res.map((value) => EventDBModel.fromDb(value)).toList();
  //     return item;
  //   }
  //   return [];
  // }

  static Future<void> saveToDB(String eventName, DateTime startDate,
      DateTime endDate, String repeat, String repeatValue) async {
    var sync = EventDBModel.random(
        
        eventName,
        DateFormat("yyyy-MM-dd")
            .parse(DateFormat("yyyy-MM-dd").format(startDate))
            .millisecondsSinceEpoch,
        DateFormat("yyyy-MM-dd")
            .parse(DateFormat("yyyy-MM-dd").format(endDate))
            .millisecondsSinceEpoch,
        repeat,
        repeatValue);

    var id = await addDb(sync);
    print("$id created");
  }

  static Future<void> removeAll() async {
    await db.remove("event");
  }

  static Future<int> deleteRow(String eventName) async {
    var client = await EventDatabase.db;
    return client.delete('event', where: 'eventName  = ?', whereArgs: [eventName]);
  }
}
