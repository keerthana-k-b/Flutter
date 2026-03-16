//Write a Dart program to calculate power (a^b) without using built-in functions.

import 'dart:io';
import 'dart:math';

// void main(){
//   print("Enter a number: ");
//   int? a = int.parse(stdin.readLineSync()!);
//   int len = a.toString().length;
//   int power = pow(a,len).toInt();
//   print("Power of $a = $power");
// }


void main(){
  print("Enter 1st number:");
  int? a = int.parse(stdin.readLineSync()!);
  print("Enter 2st number:");
  int? b = int.parse(stdin.readLineSync()!);
  int power = 1;
  for(int i = 1; i <= b; i++){
   power *= a ;
  }
  print(power);
}
