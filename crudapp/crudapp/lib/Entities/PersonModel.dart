import 'package:sqflite/sqflite.dart';

const String tableperson = 'persons';
const String columnname = 'name';
const String columnrate = 'rate';
const String columnid = "id";

class Person {
  late int id;
  late String name;
  late String rate;
  Person(String pname, String prate, int pid) {
    name = pname;
    rate = prate;
    id = pid;
  }
  //converts to a map
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnname: name,
      columnrate: rate,
      columnid: id
    };
    return map;
  }

  //converts from map
  Person.fromMap(Map<String, Object?> map) {
    name = map[columnname].toString();
    rate = map[columnrate].toString();
    id = int.parse(map[columnid].toString());
  }
}

List<Person> allPersonsDemo = [
  Person("Philip", "20,000", 1),
  Person("Paul", "19,000", 2),
  Person("Simeon", "2300", 3)
];
