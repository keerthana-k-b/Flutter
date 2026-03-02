//Write a Dart program that logs invalid input attempts and displays the count at the end.

import 'dart:io';

void main(){
  String name = "Keerthana";
  int invalid = 0;
  for (int i=0; i<=5; i++){
    print("Enter name: ");
    String? uname = stdin.readLineSync();
    if(name == uname){
      print("login");
      break;
    }else{
      print("Invalid name");
      invalid++;
    }

  }
  print("Count of invalid attempts $invalid");
}