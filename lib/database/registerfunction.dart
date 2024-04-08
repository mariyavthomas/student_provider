// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_provider/database/functions.dart';
import 'package:student_provider/database/student.dart';


Future<void> registerStudent(
    BuildContext context,
    String studentname,
    String place,
    String rollnumber,
    String contact,
    String image,
    String year,
    GlobalKey<FormState> formKey) async {
  if (image.isEmpty) {
    return;
  }
  if (formKey.currentState!.validate() &&
      studentname.isNotEmpty &&
      place.isNotEmpty &&
      rollnumber.isNotEmpty &&
      year.isNotEmpty&&
      contact != null
      ) {
    final add = Student(
      studentname: studentname,
      place: place,
      rollnumber: rollnumber,
      contact: contact,
       image: image,
       
       year: year,
       
       id: -1
       
      
        );
    addstudent(add);
    showSnackBar(context, 'Register Successful', Colors.green);
    Navigator.pop(context);
  }
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
    backgroundColor: color,
  ));
}

//editting
Future<void> editStudent(context, File? image, String name, String rollnumber,
    String place, String contact,String year, int id) async {
  final editbox = await Hive.openBox<Student>('student');
  final existingStudent =
      editbox.values.firstWhere((element) => element.id == id);
  if (existingStudent != null) {
    existingStudent.studentname = name;
    existingStudent.image = image!.path;
    existingStudent.rollnumber = rollnumber;
    existingStudent.place = place;
    existingStudent.contact = contact;

    await editbox.put(id, existingStudent);
    getstudents();
    Navigator.pop(context);
  }
}

void delete(BuildContext context, int? id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete',
          ),
          content: Text('Remove the Student'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  dlt(context, id);
                },
                child: Text('Yes')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'))
          ],
        );
      });
}

Future<void> dlt(context, int? id) async {
  final remove = await Hive.openBox<Student>('student');
  remove.delete(id);
  getstudents();
  showSnackBar(context, 'Deleted', Colors.red);
  Navigator.pop(context);
}