//Write a program that validates user input for range constraints (e.g., only accept numbers between 1–100)

import 'dart:io';

void main(){
  stdout.write("Enter a number in range(1 - 100) : ");
  String? input = stdin.readLineSync();

  if( input != null || RegExp(r'^\d+$').hasMatch(input!)){
    int num = int.parse(input);

    if(num >= 1 && num <= 100 ){
      print("Valid input : $num");
    }else{
      print("Number out of range!");
    }
  }else{
    print("Invalid input ");
  }

}

