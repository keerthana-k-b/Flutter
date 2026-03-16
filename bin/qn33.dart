//Build a program that reads a date string (dd/mm/yyyy) and validates whether it is a real calendar date.

import 'dart:async';
import 'dart:io';

void main(){
  String? num = stdin.readLineSync()!;
  List l1 = num.split('/').toList();
  int day = int.parse(l1[0]);
  int month = int.parse(l1[1]);
  int year = int.parse(l1[2]);
  DateTime date = DateTime(year,month,day);
  if(date.day == day && date.month == month && date.year == year){
    print("Valid date  $num");
  }else{
    print("Invalid");
  }
}