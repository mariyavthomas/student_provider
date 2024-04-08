
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_provider/database/student.dart';
import 'package:student_provider/provider/studentprovide.dart';

import '../database/registerfunction.dart';


// ignore: must_be_immutable
class AddStudent extends StatefulWidget {
  AddStudent({super.key, required this.isedit, this.value});
  bool isedit = false;
  Student? value;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  static String? phoneValidator(
    String? value,
  ) {
    final trimmedvalue = value?.trim();

    if (trimmedvalue == null || trimmedvalue.isEmpty) {
      return 'Enter your Phone Number';
    }

    final RegExp phoneRegExp =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

    if (!phoneRegExp.hasMatch(trimmedvalue)) {
      return 'Enter your Number';
    }
    return null;
  }

  File? selectedimage;
  List<String> rollNumber = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  List<String> year = ['First year', 'Second Year', 'third year'];
  String? selectrollnumber;
  String? selectyear;
  final studentnamecontroller = TextEditingController();
  final contactcontroller = TextEditingController();
  final placecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  

  @override
  Widget build(BuildContext context) {
    print(widget.value?.year);
    if (widget.isedit) {
      studentnamecontroller.text = widget.value!.studentname.toString();
      contactcontroller.text = widget.value!.contact.toString();
      placecontroller.text = widget.value!.place.toString();
      selectedimage=File(widget.value!.image.toString());
       selectrollnumber = widget.value?.rollnumber;
      selectyear = widget.value?.year;
    }
    return Consumer<Studentprovide>(
      builder: (context,value,child)=>
      Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
            backgroundColor: Colors.teal[300],
            title: widget.isedit ? Text('Edit') : Text('Register')),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(children: [
              
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                          height: 200,
                          width: 200,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(border: Border.all()),
                          child: selectedimage != null
                              ? Image.file(
                                  selectedimage!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                        ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                                  final pickedImage = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    selectedimage= File(pickedImage.path);
                                    value.imagepicker(selectedimage!);
                                  }
                            },
                            icon: Icon(Icons.image))
                      ],
                    )
                  ],
                
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: ,
                  controller: studentnamecontroller,
                  decoration: InputDecoration(
                      hintText: 'Student Name', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: phoneValidator,
                  controller: contactcontroller,
                  decoration: InputDecoration(
                      hintText: 'Contact', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: placecontroller,
                  decoration: InputDecoration(
                      hintText: 'Place', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 150),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'Select rollnumber',
                    focusedBorder: UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.greenAccent,
                  ),
                  //  dropdownColor: const Color.fromARGB(255, 171, 185, 178),
                  value: selectrollnumber,
                  onChanged: (String? newValue) {
                    selectrollnumber = newValue!;
                  },
                  items: rollNumber.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
    
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 150),
                child: DropdownButtonFormField(
                  // onChanged: (){},
                  decoration: InputDecoration(
                    hintText: 'Select Year ',
                    focusedBorder: UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.greenAccent,
                  ),
                  //  dropdownColor: const Color.fromARGB(255, 171, 185, 178),
                  value: selectyear,
                  onChanged: (String? newvalue1) {
                    selectyear = newvalue1!;
                    //controller.update();
                  },
                  items: year.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
             
              SizedBox(
                height: 20,
              ),
              widget.isedit == false
                  ? InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate() &&
                            studentnamecontroller.text.isNotEmpty &&
                            selectrollnumber != null &&
                            contactcontroller.text.isNotEmpty &&
                            placecontroller.text.isNotEmpty &&
                            selectrollnumber != null &&
                            selectyear != null &&
                            selectedimage!.path.isNotEmpty) {
                          registerStudent(
                              context,
                              studentnamecontroller.text.trim(),
                              placecontroller.text.trim(),
                              selectrollnumber.toString(),
                              contactcontroller.text.trim(),
                              selectedimage!.path.toString(),
                              selectyear.toString(),
                              formkey);
                        } else {
                          studentnamecontroller.clear();
                          placecontroller.clear();
                          selectrollnumber = null;
    
                          contactcontroller.clear();
                          selectyear = null;
                           selectedimage =
                                  value.imagepicker(selectedimage = null);
    
                          showSnackBar(context, 'Register fail', Colors.red);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate() &&
                            studentnamecontroller.text.isNotEmpty &&
                            contactcontroller.text.isNotEmpty &&
                            selectrollnumber != null &&
                            selectyear != null) {
                          editStudent(
                              context,
                              selectedimage,
                              studentnamecontroller.text,
                              selectrollnumber.toString(),
                              selectyear.toString(),
                              placecontroller.text,
                              contactcontroller.text,
                              int.parse(widget.value!.id.toString()));
                        } else {
                          studentnamecontroller.clear();
                          contactcontroller.clear();
                          selectedimage = selectrollnumber = null;
                          placecontroller.clear();
                          showSnackBar(context, 'Register faild', Colors.red);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text('Update'),
                        ),
                      ),
                    )
            ]),
          ),
        ),
      ),
    );
  }
}
