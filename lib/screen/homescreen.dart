import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:student_provider/database/functions.dart';
import 'package:student_provider/database/student.dart';
import 'package:student_provider/provider/studentprovide.dart';
import 'package:student_provider/widgets/listodstudent.dart';

import 'addstudent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? searchtext = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
   getstudents();
   print(studentlist.value);
    searchController.removeListener(() {
      searchtext;
    });
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
   
    return Consumer<Studentprovide>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Colors.black45,
        body: Column(
          children: [
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      'St.Marys College ',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Department of Computer application'),
                  Image.asset(
                    'asstest/image/StMarysCollageLogo.png',
                    height: 150,
                    width: 150,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (values) {
                    value.getsearchtext(values);
                    //value.getsearchtext(value);
                    onsearch(values);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      suffixIcon: searchController.text.isEmpty
                          ? Icon(
                              Icons.mic,
                              color: Colors.black,
                            )
                          : IconButton(
                              onPressed: () {
                                searchController.clear();
                                value.getsearchtext('');
                                getstudents();
                              },
                              icon: Icon(Icons.clear)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Colors.grey,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0)),
                )),
            Expanded(
              child: 
              ListOfstudents(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Get.to(AddStudent(isedit: false));
            Navigator.push(context, MaterialPageRoute(builder: (reg)=>AddStudent(isedit: false,)));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.teal,
        ),
      );
    });
  }

  onsearch(String values) {
    final studentdb = Hive.box<Student>('student');
    final student = studentdb.values.toList();
    values = searchController.text;
    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(Duration(milliseconds: 200), () {
      if (searchtext != searchController) {
        final filterdStudent = student
            .where((students) => students.studentname!
                .toLowerCase()
                .trim()
                .contains(values.toLowerCase().trim()))
            .toList();
        studentlist.value = filterdStudent;
      }
    });
  }
}
