import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_provider/database/registerfunction.dart';



details(context, String ? studentname, String? rollnumber, String? year,
    String ?place, String ?contact, String ?image, int id) {
  print('njn ivite ond');
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          
          decoration: BoxDecoration(color: Colors.teal[50]),
          child: AlertDialog(
              title: Center(child: Text('Department of computter application')),
              content: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Colors.teal[100]),
                  child: Column(
                 //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(File(image!)),
                          )),
                      Center(child: Text(studentname!,)),
                      Center(child: Text('Roll Number:${rollnumber}')),
                      Center(child: Text('Year:${year}')),
                      Center(child: Text('Place:${place}')),
                       Center(child: Text('Phone Number:${contact}')),
                      
                      
                    ],
                  ),
                ),
              ),
              actions: [
               
                IconButton(
                  onPressed: () {
                    // 
                    delete(context, id);
                    
                  },
                  icon: Icon(
                    Icons.delete,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Back'))
              ]),
        );
      });
}
