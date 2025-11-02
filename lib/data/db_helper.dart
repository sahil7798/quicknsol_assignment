// lib/data/local/db_helper.dart
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  factory DBHelper() => _instance;
  DBHelper._();

  static Database? _db;

  Future<Database> get db async {
    _db ??= await _init();
    return _db!;
  }

  Future<Database> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'sync_queue.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, ver) async {
        await db.execute('''
          CREATE TABLE sync_queue (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            operation TEXT NOT NULL,   -- "delete" | "update"
            payload TEXT NOT NULL,     -- JSON string
            created_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // ---------- Queue ----------
  Future<int> enqueue(String operation, Map<String, dynamic> payload) async {
    final map = {
      'operation': operation,
      'payload': jsonEncode(payload),
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
    return (await db).insert('sync_queue', map);
  }

  Future<List<Map<String, dynamic>>> getPending() async {
    return (await db).query('sync_queue', orderBy: 'created_at ASC');
  }

  Future<void> deleteFromQueue(int id) async {
    await (await db).delete('sync_queue', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearQueue() async {
    await (await db).delete('sync_queue');
  }
}
