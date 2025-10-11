import 'package:sqflite/sqflite.dart';
import 'package:week_06_sqlite/models/todo.dart';

class TodoController {
  static Database? _db;
  static TodoController? _instance;
  static const tableName = 'todos';

  static TodoController getInstance(Database db) {
    // if (_instance == null) {
    //   _instance = TodoController._internal(db);
    // }

    _instance ??= TodoController._internal(db);

    return _instance!;
  }

  TodoController._internal(Database db) {
    _db = db;
  }

  Future<void> insert(Todo todo) async {
    await _db!.insert(tableName, todo.toMap());
  }

  Future<void> update(Todo todo) async {
    await _db!
        .update(tableName, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteAll() async {
    await _db!.delete(tableName);
  }

  Future<List<Todo>> getTodos() async {
    final List<Map<String, dynamic>> maps = await _db!.query(tableName);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        description: maps[i]['description'],
        done: maps[i]['done'] == 1,
      );
    });
  }
}
