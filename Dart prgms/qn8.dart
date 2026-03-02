//Write a Dart program to convert a number to words (e.g., 123 → One Two Three)

import 'dart:io';

void main(){
  String? input = stdin.readLineSync()!;
  for(int i = 0; i < input.length ; i++){
    switch(input[i]){
      case '0':
       print("Zero");
       break;
      case '1':
       print("One");
       break;
      case '2':
       print("Two");
       break;
       case '3':
       print("Three");
       break;
      case '4':
       print("Four");
       break;
      case '5':
       print("Five");
       break;
      case '6':
       print("Six");
       break;
      case '7':
       print("Seven");
       break;
      case '8':
       print("Eight");
       break;
      case '9':
       print("Nine");
       break;
      default:
      print("Invalid ");
    }
  }
}