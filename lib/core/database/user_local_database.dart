import 'dart:convert';

import 'package:contactapp/auth/model/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDatasource {
  UserLocalDatasource._init();

  static final UserLocalDatasource instance = UserLocalDatasource._init();

  late final String tableUsers = "users";
  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("my_app.db");
    return _database!;
  }

  String hashPassword(String password){
    String hashedPassword = password;
    for (var i = 0; i < 10; i++) {
      final bytes = utf8.encode(hashedPassword);
      hashedPassword = sha256.convert(bytes).toString();
    }
    return hashedPassword;
  }

  Future<int> register(UserModel user)async{
    final hashedPassword = hashPassword(user.password);

    final db = await instance.database;
    return await db.rawInsert('''
      INSERT INTO users(name, email, password)
      VALUES (\$1, \$2, \$3)
    ''', [user.name, user.email, hashedPassword]);
  }

  Future<dynamic> login(String email, String password) async {
    final hashedPassword = hashPassword(password);

    final db = await instance.database;
    final List<Map<String, dynamic>> users =  await db.rawQuery('''
      SELECT * FROM users WHERE email = ? AND password = ?
    ''', [email, hashedPassword]);

    return users.isNotEmpty 
      ? UserModel.fromMap(users.first)
      : users;
  }
}
