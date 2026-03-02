//Develop a program that prevents runtime exceptions when parsing user input

import 'dart:io';

void main(){
  String? a = stdin.readLineSync()!;
  int? b = int.tryParse(a ?? '');
  //int sum = a! + b;
  print(b);
}