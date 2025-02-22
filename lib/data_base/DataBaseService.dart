import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/data_base/User.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  final String _userTable = "users";
  final String _id = "id";
  final String _name = "name";
  final String _skill = "skill";

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final dirPath = await getDatabasesPath();
    final dbPath = join(dirPath, 'my_database.db');

    final database = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_userTable ($_id INTEGER PRIMARY KEY, $_name TEXT, $_skill TEXT)
          ''');
      });

    return database;
  }

  // CRUD operations
  void addUser(String name, String skill) async {
    final db = await database;
    await db.insert(_userTable, {_name: name, _skill: skill});
  }

  void updateUser(int id, String name, String skill) async {
    final db = await database;
    db.update(
      _userTable,
      {_name: name, _skill: skill},
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  void deleteUser(int id) async {
    final db = await database;
    db.delete(
      _userTable,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final data = await db.query(_userTable);

    List<User> finalData = data.map((e) => User(
      id: e["id"] as int,
      name: e["name"] as String,
      skill: e["skill"] as String,
    )).toList();

    print(data);
    return finalData;
  }


  void temp() {

    List<String> temp = ["2", "3", "5"];

    final data = temp.map((item) {
      return item.toUpperCase();
    }).toList();

  }



}
