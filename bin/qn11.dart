//Write a Dart program to compute GCD and LCM of two numbers entered via keyboard

import 'dart:io';

void main(){
  print("Enter a number: ");
  int? a = int.parse(stdin.readLineSync()!);
  print("Enter another number: " );
  int? b = int.parse(stdin.readLineSync()!);
  int gcd = a.gcd(b);
  print("GCD of $a and $b = $gcd");
  int lcm = (a * b) ~/ a.gcd(b) ;
  print("LCM of $a and  $b = $lcm");
}