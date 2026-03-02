//Write a Dart program that accepts multiple lines of input and stops when a blank line is entered.

import 'dart:io';

void main(){

while(true){
  String? input = stdin.readLineSync();
  if(input == ''){
    break;
  }
// else{
//     continue;
//   }
 
}
}