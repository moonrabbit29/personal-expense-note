import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'contact.dart';

class DbHelper{

  Future<Database> initDb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contact.db';
    var peDatabase = openDatabase(path,version: 1,onCreate: _createDb);
    return peDatabase;
  }

  void _createDb(Database db,int version) async {
    await db.execute('''
      CREATE TABLE contact(
        id TEXT PRIMARY KEY,
        title TEXT,
        amount TEXT,
        date TEXT
      )
    ''');
  }

  
}


