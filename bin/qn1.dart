//Write a Dart program that repeatedly asks the user for input until a valid integer is entered.

import 'dart:io';
void main(){
  final RegExp intRegex = RegExp(r'^-?\d+$');     //integers 0 - 9      //^ → start of string  //[+-]? → optional + or - sign  // \d+ → one or more digits  // $ → end of string
  while(true){
    print("Enter input:");
    String? input = stdin.readLineSync();

    if(input == null || input.isEmpty ){
      print(" Empty ");
    } 
    else if(intRegex.hasMatch(input)){
      int num = int.parse(input);
      print(" valid integer ");
      break;
    }else{
      print("Invalid input");
    }
  }
}