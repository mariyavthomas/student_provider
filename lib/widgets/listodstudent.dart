import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:student_provider/database/functions.dart';
import 'package:student_provider/database/student.dart';
import 'package:student_provider/screen/addstudent.dart';
import 'package:student_provider/widgets/detailpage.dart';




ValueNotifier<bool> scroll = ValueNotifier(false);

class ListOfstudents extends StatefulWidget {
  const ListOfstudents({super.key});

  @override
  State<ListOfstudents> createState() => _ListOfstudentsState();
}

class _ListOfstudentsState extends State<ListOfstudents> {
  //final gets=Dbfunction();

  void initState() {
    getstudents();
    super.initState();
   
  }

  @override
  
  Widget build(BuildContext context) {
    return Column(
      children: [
        
           ValueListenableBuilder(
            valueListenable: studentlist, 
            builder: (context,List<Student>students,Widget ?child){
               return studentlist.value.isEmpty
               ? Expanded(child: 
               Container(
                height: 500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Text('Emty List')
                  ],
                ),
              )
               ): Expanded(child: 
               ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, int index) {
                   
                    final studendata =students.reversed.toList()[index];
                    return InkWell(
                        onTap: () {
                          details(
                              context,
                              studendata.studentname,
                              studendata.rollnumber,
                              studendata.year,
                              studendata.place,
                              studendata.contact,
                              studendata.image,
                              studendata.id!);
                        },
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                                label: 'Edit',
                                icon: Icons.edit,
                                backgroundColor:
                                    const Color.fromARGB(255, 33, 243, 72),
                                onPressed: (context) {
                                  Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (reg) =>
                                                      AddStudent(
                                                       
                                                        value: studendata, isedit: true,
                                                      )));
                                  
                                })
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 41,
                                  backgroundImage:
                                      FileImage(File(studendata.image!)),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  studendata.studentname!.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    details(
                                        context,
                                        studendata.studentname,
                                        studendata.rollnumber,
                                        studendata.year,
                                        studendata.place,
                                        studendata.contact,
                                        studendata.image,
                                        studendata.id!);
                                  },
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                )
          
        );
      }
     ) ]);

             
           
                 
   
  }
}
