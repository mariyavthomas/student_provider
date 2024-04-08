import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId:0)
class Student{
   @HiveField(0)
   String? studentname;
   @HiveField(1)
   String ? contact;
   @HiveField(2)
   String ?place;
   @HiveField(3)
   String ? rollnumber;
   @HiveField(4)
   String ? year;
   @HiveField(5)
   String ? image;
  @HiveField(6)
   int ? id;
 
 Student({
  required this.studentname,
  required this.contact,
  required this.place,
  required this.rollnumber,
  required this.year,
  required this.image,
  required this.id
 });

}