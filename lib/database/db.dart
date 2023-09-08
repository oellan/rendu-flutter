import 'package:flutter/foundation.dart';
import 'package:sqlite3/sqlite3.dart';

import '../models/user.dart';

class DB {
  static DB? _instance;
  late Database _database;

  DB() {
    _database = sqlite3.openInMemory();
    _database.execute('''
CREATE TABLE IF NOT EXISTS "users" (
id INTEGER PRIMARY KEY,
username TEXT UNIQUE,
password TEXT,
login_count INTEGER DEFAULT 0
);
''');
    // _database.execute('INSERT INTO users (username, password) VALUES (?,?);', ["aa", "bb"]);
  }

  static void dumpUsers() {
    print(instance._database.select("SELECT * FROM users;"));
  }

  static String? insertUser(User user) {
    try {
      instance._database.execute(
        "INSERT INTO users(username,password) VALUES (?,?);",
        [
          user.username,
          user.password,
        ],
      );
    } catch (e) {
      if (e.toString().contains(
          "UNIQUE constraint failed: users.username, constraint failed")) {
        return "Username already exists";
      }
      return "Unknown error";
    }
    return null;
  }

  static DB get instance => _instance ?? (_instance = DB());
}
