import 'dart:io';
import 'dart:async';

import 'package:flutter_with_data/models/Contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;

  DBHelper._createObject();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    // set database name and location
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contact.db';

    // create, read database
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    // return object value as result from function
    return todoDatabase;
  }

  // create new table name is contact
  void _createDb(Database db, int version) async {
    var sql = '''
    CREATE TABLE contact (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      phone TEXT
    )
    ''';
    await db.execute(sql);
  }

  // get and check database
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }

    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('contact', orderBy: 'name');
    return mapList;
  }

  // insert database
  Future<int> insert(Contact object) async {
    Database db = await this.database;
    int count = await db.insert('contact', object.toMap());
    return count;
  }

  // update database
  Future<int> update(Contact object) async {
    Database db = await this.database;
    int count = await db.update('contact', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  // delete database
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('contact', where: 'id=?', whereArgs: [id]);
    return count;
  }

  // delete database
  Future<List<Contact>> getContactList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<Contact> contactList = List<Contact>();
    for (int i = 0; i < count; i++) {
      contactList.add(Contact.fromMap(contactMapList[i]));
    }

    return contactList;
  }
}
