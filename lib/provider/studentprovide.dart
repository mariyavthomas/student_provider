import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_provider/database/student.dart';

class Studentprovide with ChangeNotifier{
  File ? selectedimage;
  String selectrollnumber='';
  String selectedyear='';
   List<Student> studentlist = [];
  List<Student> get studentserachlist => studentlist;

  String ? onsearch;
   

  getsearchtext(String  str){
    onsearch=str;
    notifyListeners();
   
  }
    searchstu(List<Student>newlist){
      studentlist=newlist;
    }
  
   void setrollnumber( String rollnumber){
    selectrollnumber=rollnumber;
    notifyListeners();
   }
   void year(String year){
    selectedyear=year;
    notifyListeners();
   }
    imagepicker(File ? images){
    selectedimage=images;
    notifyListeners();
   }

}