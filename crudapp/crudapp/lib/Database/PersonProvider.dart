import 'package:sqflite/sqflite.dart';

import '../Entities/PersonModel.dart';

class PersonProvider {
  late Database db;

  // Get a location using getDatabasesPath

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = (databasesPath + 'demo.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableperson ( 
  $columnid integer primary key autoincrement, 
  $columnname text not null,
  $columnrate integer not null)
''');
    });
  }

//insert person to the databse

  Future<Person> insert(Person person) async {
    person.id = await db.insert(tableperson, person.toMap());
    print("Alredy added to the database");
    return person;
  }

//get all persons from the datbase
  Future<List<Person>> getAllPersons() async {
    List<Map<String, Object?>> records = await db.query(tableperson);
    return records.map((persons) => Person.fromMap(persons)).toList();
  }

  //get a specific person

  Future<Person?> getPerson(int id) async {
    List<Map<String, Object?>> maps = await db.query(tableperson,
        columns: [columnid, columnname, columnrate],
        where: '$columnid = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Person.fromMap(maps.first);
    }
    return null;
  }

//delete a given person with id
  Future<int> delete(int id) async {
    return await db
        .delete(tableperson, where: '$columnid = ?', whereArgs: [id]);
  }

//update a given person
  Future<int> update(Person person) async {
    return await db.update(tableperson, person.toMap(),
        where: '$columnid = ?', whereArgs: [person.id]);
  }

  Future close() async => db.close();
}
