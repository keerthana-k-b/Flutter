//Develop a program that accepts a string and determines whether it can be safely converted into an integer without using tryParse().

import 'dart:io';

void main(){
  String? input = stdin.readLineSync();
  if(RegExp(r'^[+-]?\d+$').hasMatch(input!)){             //[+-]? → optional + or - sign 
    print(("Valid integer"));
  }else{
    print("Invalid integer");
  }
}