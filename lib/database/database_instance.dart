import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:pas_android/api/model/favorite_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance extends ChangeNotifier{
  final String _databaseName = 'my_database.db';
  final int _databaseVersion = 1;

  // Product Table
  final String table = 'favorite';
  final String id = 'id';
  final String image = 'image';
  final String price = 'price';
  final String name = 'name';
  final String location = 'location';
  final String description = 'description';

  List<FavoriteModel> FavoriteData = [];

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion ,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ($id INTEGER PRIMARY KEY, $image BLOB NULL, $price DOUBLE NULL, $name TEXT NULL, $location TEXT NULL, $description TEXT NULL)');
  }

  Future<void> all() async {
    final data = await _database?.query(table);
    FavoriteData = data!.map((e) => FavoriteModel.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> insert(Map<String, dynamic> row) async {
    await _database!.insert(table, row);
    notifyListeners();
    all();
  }

  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final query = await _database!.update(table, row, where: '$id = ?', whereArgs: [idParam]);
    return query;
  }

  Future delete(int? idParam) async {
    await _database!.delete(table, where: '$id = ?', whereArgs: [idParam]);
    all();
  }
}