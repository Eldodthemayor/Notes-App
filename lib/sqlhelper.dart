// Database //
// Sql //

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  Database? database;

  getDatabase() async {
    if (database != null) {
      return database;
    } else {
      database = await initDatabase();
      return database;
    }
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), '3C.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, index) async {
        await db.execute('''
             CREATE TABLE notes (
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               title TEXT,
               content TEXT
             )
          ''');
      },
    );
  }
  // Create table //
  // insert

  Future insertNote(Note newNote) async {
    Database db = await getDatabase();
    await db.insert('notes', newNote.toMap());
  }

  Future<List<Map>> readData() async {
    Database db = await getDatabase();
    return await db.query('notes');
  }
}

// Note - id - title - content

class Note {
  int? id;
  String title;
  String content;

  Note(this.title, this.content, [this.id]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
