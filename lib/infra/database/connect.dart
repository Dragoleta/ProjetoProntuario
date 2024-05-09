import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static const String _dbname = 'test2.db';

  Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbname),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute(_user);
    await db.execute(_workplaces);
    await db.execute(_patients);
    await db.execute(_history);
  }

  String get _user => '''
    CREATE TABLE user(
      email TEXT NOT NULL
      )
  ''';

  String get _workplaces => '''
    CREATE TABLE workplaces(
      id integer PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      professinal_id integer NOT NULL
    )
  ''';

  String get _patients => '''
    CREATE TABLE patients(
      id integer PRIMARY KEY AUTOINCREMENT,
      professional_id integer NOT NULL,
      workplace_id integer NOT NULL,
      name TEXT NOT NULL,
      sex TEXT NOT NULL,
      birthdate TEXT NOT NULL,
      mother_name TEXT NOT NULL,
      father_name TEXT NOT NULL,
      diagnose TEXT NOT NULL
    )
  ''';

  String get _history => '''
    CREATE TABLE history(
      id integer PRIMARY KEY AUTOINCREMENT,
      patient_id integer NOT NULL,
      history_text TEXT NOT NULL,
      appointment_date TEXT NOT NULL
    )
  ''';
}
