import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_db/db/modal/modal.dart';

ValueNotifier<List<Studentmodal>> studentListNotifier = ValueNotifier([]);
late Database _db;

Future<void> initializeDataBase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, batch TEXT,domain TEXT,image TEXT)');
    },
  );
}

Future<void> addStudent(Studentmodal value) async {
  await _db.rawInsert(
      'INSERT INTO student(name,age,batch,domain,image)VALUES (?,?,?,?,?)',
      [value.name, value.age, value.batch, value.domain, value.image]);
  getAllStudents();
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  studentListNotifier.value.clear();
  _values.forEach((map) {
    final student = Studentmodal.fromMap(map);
    studentListNotifier.value.add(student);
    studentListNotifier.notifyListeners();
  });
}

Future<void> deletedata(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  getAllStudents();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future<void> updateStudent(Studentmodal newValue) async {
  await _db.rawUpdate(
    'UPDATE student SET name = ?, age = ?, batch = ?, domain = ?, image = ? WHERE id = ?',
    
    [
      newValue.name,
      newValue.age,
      newValue.batch,
      newValue.domain,
      newValue.image,
      newValue.id,
    ],
  );
  getAllStudents();
  studentListNotifier.notifyListeners();
}
Future<void> searchStudent(String name) async {
  final students = await _db.query(
    'student',
    where: 'LOWER(name) LIKE ?',
    whereArgs: ['%${name.toLowerCase()}%'],
  );
  studentListNotifier.value =
      students.map((element) => Studentmodal.fromMap(element)).toList();
}
