//Write a program that reverses only the digits in a mixed string, leaving other characters in place.

import 'dart:io';

void main(){
  print("Enter a string: ");
  String input = stdin.readLineSync()!;
  int temp = 0;
  int rev = 0;
  
  for(int i = 0; i <= input.length; i++){
    if(RegExp('[0-9]').hasMatch(input[i])){
      temp += int.parse(input[i]);
      int digit = temp % 10 ;
      rev = rev * 10 + digit;
      temp = temp ~/ 10;
      print("$input   + $rev ");

    }
    print(rev);
  

  }
  
}