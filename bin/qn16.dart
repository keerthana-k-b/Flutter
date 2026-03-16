//Write a Dart program that handles invalid input, null input, and overflow gracefully

import 'dart:io';

void main(){
  print("Enter an integer: ");
  String? a = stdin.readLineSync();
  if(a == null){
    print("Null");
  }else{
    print("Not Null");
  }
  int? b = int.tryParse(a!);
  if(b == null){
    print("Null");
  }else{
    print("Not Null");
  }
  String? c = b.toString();
  print(c);
  int len = a.length;
  print(len);
  if(len > 6){
    print("Overflow");
  }else{
   print("Not Exceeded limit");
 }
}