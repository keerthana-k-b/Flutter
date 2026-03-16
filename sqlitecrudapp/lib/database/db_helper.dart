import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper  {
  static Future<Database> database() async{
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath,'todo.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
       "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)"

        );
      },
    );
  }

  //create
  static Future<int> insertTodo(String title) async {
    final db = await database();
    return db.insert('todos', {'title': title});
  }

// READ
  static Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await database();
    return db.query('todos');
  }

  // UPDATE
  static Future<int> updateTodo(int id, String title) async {
    final db = await database();
    return db.update(
      'todos',
      {'title': title},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // DELETE
  static Future<void> deleteTodo(int id) async {
    final db = await database();
    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}