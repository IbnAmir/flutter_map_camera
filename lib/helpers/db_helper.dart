import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase( path.join(dbPath, 'places.db'),
        onCreate: (db, version) async{
          return db.execute(
              'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
        }, version: 1);
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    // final dbPath = await sql.getDatabasesPath();
    // final sqlDb = await sql.openDatabase(
    //     path.join(
    //       dbPath,
    //       'places.db',
    //     ), onCreate: (db, version) {
    //   db.execute(
    //     'CREATE TABLE user_places(id TEXT PRIMARY KET, title TEXT, image TEXT)',
    //   );
    // }, version: 1);
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

   Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
