import 'package:sqflite/sqlite_api.dart';
import 'contact.dart';
import 'dbhelper.dart';

class CRUD {
  DbHelper dbHelper = new DbHelper();

  Future<int> insert(Contact pe) async {
    Database db = await dbHelper.initDb();
    int count = await db.insert('contact', pe.toMap());
    return count;
  }
Future<int> update(Contact pe) async {
    Database db = await dbHelper.initDb();
    int count = await db.update('contact', pe.toMap(),
        where: 'id=?', whereArgs: [pe.transaction.id]);
    return count;
  }
Future<int> delete(Contact pe) async {
    Database db = await dbHelper.initDb();
    int count =
        await db.delete('contact', where: 'id=?', whereArgs: [pe.transaction.id]);
    return count;
  }
Future<List<Contact>> getContactList() async {
    Database db = await dbHelper.initDb();
    List<Map<String, dynamic>> mapList =
        await db.query('contact', orderBy: 'id');
    int count = mapList.length;
    List<Contact> contactList = List<Contact>();
    for (int i = 0; i < count; i++) {
      contactList.add(Contact.fromMap(mapList[i]));
    }
    return contactList;
  }
}