import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_provider/database/student.dart';

ValueNotifier<List<Student>> studentlist = ValueNotifier([]);
Future<void> addstudent(Student value) async {
  final studentDb = await Hive.openBox<Student>('student');
  final id = await studentDb.add(value);
  final studentdata = studentDb.get(id);
  await studentDb.put(
      id,
      Student(
          studentname: studentdata!.studentname,
          contact: studentdata.contact,
        
          place: studentdata.place,
          rollnumber: studentdata.rollnumber,
          year: studentdata.year,
          image: studentdata.image,
          id: id));
          getstudents();
}
Future<void>getstudents()async{
  final studentdb= await Hive.openBox<Student>('student');
 studentlist.value.clear();
 studentlist.value.addAll(studentdb.values);
 // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
 studentlist.notifyListeners();
}