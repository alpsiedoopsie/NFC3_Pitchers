import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './models/emergency_contact.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'emergency_contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        number TEXT
      )
    ''');
  }

  Future<int> insertContact(EmergencyContact contact) async {
    Database db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<EmergencyContact>> getContacts() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return EmergencyContact.fromMap(maps[i]);
    });
  }

  Future<int> updateContact(EmergencyContact contact) async {
    Database db = await database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
