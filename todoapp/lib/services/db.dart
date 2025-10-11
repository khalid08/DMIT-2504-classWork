import 'package:sqflite/sqflite.dart';

const databaseName = 'todos.db';

Future<Database> getDatabase() async {
  return openDatabase(databaseName, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY,
            description TEXT,
            done INTEGER DEFAULT 0
          )
        ''');
  });
}
